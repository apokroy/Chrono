{ DUnitX tests for ChronoTypes.
  The tests are platform neutral: they never depend on the OS locale or on the
  OS first day of week — format settings and Chrono.FirstDayOfWeek are set
  explicitly where they matter. Reference values come from the Delphi RTL
  (EncodeDate, DecodeDate, DayOfWeek, IsLeapYear). }
unit ChronoTypes.Tests;

interface

uses
  System.SysUtils, System.DateUtils, System.Variants,
  DUnitX.TestFramework,
  ChronoTypes;

type
  [TestFixture]
  TDateTests = class
  public
    [Test] procedure MatchesRtlForEveryDayFrom0001To9999;
    [Test] procedure StampIsCompatibleWithTimeStamp;
    [Test] procedure ZeroDateDecodesToDayBeforeEra;
    [Test] procedure ImpossibleDateInsideTableRangeEncodesToZero;
    [Test] procedure Components;
    [Test] procedure DayOfYear;
    [Test] procedure WithMonthClampsDay;
    [Test] procedure WithYearHandlesFebruary29;
    [Test] procedure WithDayDoesNotClamp;
    [Test] procedure ISORoundTrip;
    [Test] procedure Arithmetic;
    [Test] procedure Comparison;
    [Test] procedure SystemDateTimeConversion;
    [Test] procedure VariantConversion;
    [Test] procedure RangeAndSequence;
    [Test] procedure YearMonthQuarterDates;
    [Test] procedure MonthOfYearAndQuarterOfYear;
    [Test] procedure DayOfMonthOrdering;
    [Test] procedure TodayMatchesRtl;
  end;

  [TestFixture]
  TWeekdayTests = class
  private
    FSavedFirstDayOfWeek: Chrono.TWeekday;
    FInvariant: TFormatSettings;
  public
    [Setup] procedure Setup;
    [TearDown] procedure TearDown;
    [Test] procedure MatchesRtlForEveryDayFrom0001To9999;
    [Test] procedure KnownDates;
    [Test] procedure DayOfWeekIsRelativeToFirstDay;
    [Test] procedure DayUsesGlobalFirstDayOfWeek;
    [Test] procedure WeekdayFromOrdinal;
    [Test] procedure WeekDaysEnumeration;
    [Test] procedure StartAndEndOfWeek;
    [Test] procedure NextAndPreviousWeekday;
    [Test] procedure SetWeekdayMovesWithinWeek;
    [Test] procedure NamesAndParsing;
  end;

  [TestFixture]
  TPeriodTests = class
  public
    [Test] procedure AddMonthsClampsToEndOfMonth;
    [Test] procedure AddYearToFebruary29;
    [Test] procedure MonthsCarryAcrossYearBoundary;
    [Test] procedure AddCombinedPeriod;
    [Test] procedure Between;
    [Test] procedure BetweenThenAddRestoresTarget;
    [Test] procedure Operators;
    [Test] procedure ToStringUsesLocalizedUnits;
  end;

  [TestFixture]
  TDurationTests = class
  public
    [Test] procedure Components;
    [Test] procedure Negative;
    [Test] procedure Arithmetic;
    [Test] procedure BetweenCrossesMidnight;
  end;

  [TestFixture]
  TTimeTests = class
  public
    [Test] procedure Components;
    [Test] procedure ISO;
    [Test] procedure MIME;
    [Test] procedure SystemDateTimeRoundTrip;
    [Test] procedure NamedUnits;
    [Test] procedure SubtractGivesDuration;
    [Test] procedure VariantConversion;
  end;

  /// <summary>
  ///  Regression tests for the compiler issue described next to
  ///  Chrono.TDateTime.Implicit(Chrono.TDateTime): Variant in ChronoTypes.pas —
  ///  conversion from System.TDateTime must add DateDelta exactly once.
  /// </summary>
  [TestFixture]
  TSystemDateTimeConversionTests = class
  public
    [Test] procedure ImplicitFromSystemDateTime;
    [Test] procedure ExplicitFromSystemDateTime;
    [Test] procedure ConstructorFromSystemDateTime;
    [Test] procedure RoundTripToSystemDateTime;
    [Test] procedure VariantRoundTrip;
    [Test] procedure TimeStampRoundTrip;
    [Test] procedure DateBefore1899;
  end;

  [TestFixture]
  TDateTimeTests = class
  public
    [Test] procedure AddDurationCrossesMidnightForward;
    [Test] procedure SubtractDurationCrossesMidnightBackward;
    [Test] procedure AddNegativeDays;
    [Test] procedure SubtractGivesDuration;
    [Test] procedure AddPeriodKeepsTime;
    [Test] procedure StartAndEndOfDay;
    [Test] procedure Comparison;
  end;

  [TestFixture]
  TCalendarUnitTests = class
  public
    [Test] procedure LeapYearsMatchRtl;
    [Test] procedure MonthDays;
    [Test] procedure MonthNames;
    [Test] procedure QuarterParsing;
    [Test] procedure QuarterRangeAndMonths;
    [Test] procedure MonthOfYearArithmetic;
    [Test] procedure QuarterOfYearArithmetic;
    [Test] procedure DatePartNames;
  end;

  [TestFixture]
  TTimeZoneTests = class
  public
    [Test] procedure ParseOffsets;
    [Test] procedure ParseNamedZones;
    [Test] procedure UnknownZoneRaises;
    [Test] procedure RegisterZone;
    [Test] procedure Subtract;
    [Test] procedure SystemZoneIsInRange;
  end;

  [TestFixture]
  TBasicCalendarTests = class
  public
    [Test] procedure WeekendsAreNotWorkDays;
    [Test] procedure HolidaysAreNotWorkDays;
    [Test] procedure WorkDayOverrideWins;
    [Test] procedure DefaultCalendar;
  end;

implementation

function D(const Year, Month, Day: Word): Chrono.TDate;
begin
  Result := Chrono.TDate.Create(Year, Month, Day);
end;

function T(const Hour, Minute, Second: Word; const MSec: Word = 0): Chrono.TTime;
begin
  Result := Chrono.TTime.Create(Hour, Minute, Second, MSec);
end;

function WD(const Day: Chrono.TWeekday): Integer;
begin
  Result := Word(Day);
end;

function MSecs(const Hour, Minute, Second: Integer; const MSec: Integer = 0): Integer;
begin
  Result := ((Hour * 60 + Minute) * 60 + Second) * 1000 + MSec;
end;

function TimeOf(const Value: Chrono.TDateTime): string;
begin
  Result := Value.Time.ISO;
end;

{ TDateTests }

procedure TDateTests.MatchesRtlForEveryDayFrom0001To9999;
var
  N, Last: Integer;
  Date: Chrono.TDate;
  Y, M, Dd, RY, RM, RD: Word;
  Mismatch: string;
begin
  // Covers both the lookup tables (1970..2100) and the arithmetic path.
  Mismatch := '';
  Last := DateTimeToTimeStamp(EncodeDate(9999, 12, 31)).Date;
  for N := 1 to Last do
  begin
    DecodeDate(N - DateDelta, RY, RM, RD);
    Date := Chrono.TDate(N);
    Date.Decode(Y, M, Dd);
    if (Y <> RY) or (M <> RM) or (Dd <> RD) then
    begin
      Mismatch := Format('Decode(%d) = %d-%d-%d, expected %d-%d-%d', [N, Y, M, Dd, RY, RM, RD]);
      Break;
    end;
    if Integer(D(RY, RM, RD)) <> N then
    begin
      Mismatch := Format('Encode(%d-%d-%d) = %d, expected %d', [RY, RM, RD, Integer(D(RY, RM, RD)), N]);
      Break;
    end;
  end;
  Assert.AreEqual('', Mismatch);
end;

procedure TDateTests.StampIsCompatibleWithTimeStamp;
var
  TS: TTimeStamp;
begin
  Assert.AreEqual(1, Integer(D(1, 1, 1)));
  TS := D(2024, 3, 15);
  Assert.AreEqual(DateTimeToTimeStamp(EncodeDate(2024, 3, 15)).Date, TS.Date);
  Assert.AreEqual(0, TS.Time);
  TS.Date := DateTimeToTimeStamp(EncodeDate(1812, 9, 7)).Date;
  Assert.AreEqual('1812-09-07', Chrono.TDate(TS).ISO);
end;

procedure TDateTests.ZeroDateDecodesToDayBeforeEra;
var
  Y, M, Dd: Word;
begin
  Assert.AreEqual(0, Integer(Chrono.TDate.Zero));
  Assert.AreEqual(0, Integer(Default(Chrono.TDate)));
  Chrono.TDate.Zero.Decode(Y, M, Dd);
  Assert.AreEqual(0, Integer(Y));
  Assert.AreEqual(12, Integer(M));
  Assert.AreEqual(31, Integer(Dd));
end;

procedure TDateTests.ImpossibleDateInsideTableRangeEncodesToZero;
begin
  Assert.AreEqual(0, Integer(D(2023, 2, 29)));
  Assert.AreEqual(0, Integer(D(2024, 4, 31)));
end;

procedure TDateTests.Components;
var
  Date: Chrono.TDate;
begin
  Date := D(2024, 12, 31);
  Assert.AreEqual(2024, Integer(Word(Date.Year)));
  Assert.AreEqual(12, Integer(Word(Date.Month)));
  Assert.AreEqual(31, Integer(Word(Date.Day)));
  Assert.AreEqual(4, Integer(Word(Date.Quarter)));
  Assert.AreEqual(366, Integer(Date.DayOfYear));

  Date := D(1600, 5, 17); // outside the lookup tables
  Assert.AreEqual(1600, Integer(Word(Date.Year)));
  Assert.AreEqual(5, Integer(Word(Date.Month)));
  Assert.AreEqual(17, Integer(Word(Date.Day)));
  Assert.AreEqual(2, Integer(Word(Date.Quarter)));
end;

procedure TDateTests.DayOfYear;
var
  Date: Chrono.TDate;
begin
  Assert.AreEqual(1, Integer(D(2023, 1, 1).DayOfYear));
  Assert.AreEqual(365, Integer(D(2023, 12, 31).DayOfYear));
  Date := D(2024, 1, 1);
  Date.DayOfYear := 60;
  Assert.AreEqual('2024-02-29', Date.ISO);
  Date := D(2023, 7, 4);
  Date.DayOfYear := 60;
  Assert.AreEqual('2023-03-01', Date.ISO);
end;

procedure TDateTests.WithMonthClampsDay;
begin
  Assert.AreEqual('2024-02-29', D(2024, 1, 31).WithMonth(Chrono.February).ISO);
  Assert.AreEqual('2023-02-28', D(2023, 1, 31).WithMonth(Chrono.February).ISO);
  Assert.AreEqual('1900-02-28', D(1900, 1, 31).WithMonth(Chrono.February).ISO);
  Assert.AreEqual('2024-06-30', D(2024, 3, 31).WithMonth(Chrono.June).ISO);
  Assert.AreEqual('2024-07-15', D(2024, 3, 15).WithMonth(Chrono.July).ISO);
end;

procedure TDateTests.WithYearHandlesFebruary29;
begin
  Assert.AreEqual('2023-02-28', D(2024, 2, 29).WithYear(2023).ISO);
  Assert.AreEqual('2028-02-29', D(2024, 2, 29).WithYear(2028).ISO);
  Assert.AreEqual('1900-02-28', D(2000, 2, 29).WithYear(1900).ISO);
  Assert.AreEqual('2031-08-09', D(2024, 8, 9).WithYear(2031).ISO);
end;

procedure TDateTests.WithDayDoesNotClamp;
begin
  Assert.AreEqual('2024-03-01', D(2024, 3, 15).WithDay(1).ISO);
  // Documented behavior: the day is not clamped to the month length.
  Assert.AreEqual(0, Integer(D(2023, 2, 10).WithDay(30)));
end;

procedure TDateTests.ISORoundTrip;
var
  Date: Chrono.TDate;
begin
  Assert.AreEqual('2024-03-15', D(2024, 3, 15).ISO);
  Assert.AreEqual('0001-01-01', D(1, 1, 1).ISO);
  Date.ISO := '1600-02-29';
  Assert.AreEqual(1600, Integer(Word(Date.Year)));
  Assert.AreEqual(2, Integer(Word(Date.Month)));
  Assert.AreEqual(29, Integer(Word(Date.Day)));
  Assert.AreEqual('1600-02-29', Date.ISO);
  Assert.WillRaise(
    procedure
    var
      Bad: Chrono.TDate;
    begin
      Bad.ISO := '2023-02-29';
    end, EConvertError);
end;

procedure TDateTests.Arithmetic;
var
  Date: Chrono.TDate;
begin
  Assert.AreEqual('2024-02-29', (D(2024, 2, 28) + 1).ISO);
  Assert.AreEqual('2023-12-31', (D(2024, 1, 1) - 1).ISO);
  Assert.AreEqual(29, D(2024, 3, 1) - D(2024, 2, 1));
  Assert.AreEqual(-366, D(2024, 1, 1) - D(2025, 1, 1));
  Assert.AreEqual('2101-01-01', D(2100, 12, 31).Plus(1).ISO); // leaves the table range
  Assert.AreEqual('1969-12-31', D(1970, 1, 1).Minus(1).ISO);
  Date := D(2024, 12, 31);
  Inc(Date);
  Assert.AreEqual('2025-01-01', Date.ISO);
  Dec(Date);
  Assert.AreEqual('2024-12-31', Date.ISO);
end;

procedure TDateTests.Comparison;
begin
  Assert.IsTrue(D(2024, 1, 1) < D(2024, 1, 2));
  Assert.IsTrue(D(2024, 1, 2) > D(2023, 12, 31));
  Assert.IsTrue(D(2024, 1, 1) = D(2024, 1, 1));
  Assert.IsTrue(D(2024, 1, 1) <> D(2024, 1, 2));
  Assert.IsTrue(D(2024, 1, 1) <= D(2024, 1, 1));
  Assert.IsTrue(D(2024, 1, 1) >= D(2024, 1, 1));
end;

procedure TDateTests.SystemDateTimeConversion;
var
  Date: Chrono.TDate;
  Sys: System.TDateTime;
begin
  Date := EncodeDate(2024, 3, 15);
  Assert.AreEqual('2024-03-15', Date.ISO);
  Date := EncodeDateTime(2024, 3, 15, 18, 30, 0, 0); // the time part is dropped
  Assert.AreEqual('2024-03-15', Date.ISO);
  Sys := D(2024, 3, 15);
  Assert.AreEqual(Double(EncodeDate(2024, 3, 15)), Double(Sys));
  Date := Chrono.TDate.Create(EncodeDate(1850, 6, 1));
  Assert.AreEqual('1850-06-01', Date.ISO);
end;

procedure TDateTests.VariantConversion;
var
  V: Variant;
  Date: Chrono.TDate;
begin
  V := D(2024, 3, 15);
  Assert.AreEqual(Integer(varDate), Integer(VarType(V)));
  Assert.AreEqual(Double(EncodeDate(2024, 3, 15)), Double(VarToDateTime(V)));
  Date := V;
  Assert.AreEqual('2024-03-15', Date.ISO);
end;

procedure TDateTests.RangeAndSequence;
var
  Dates: TArray<Chrono.TDate>;
  Seq: Chrono.TDate.TSequence;
  Day, Last: Chrono.TDate;
  Count: Integer;
begin
  Dates := Chrono.TDate.Range(D(2024, 1, 1), D(2024, 1, 31));
  Assert.AreEqual(31, Integer(Length(Dates)));
  Assert.AreEqual('2024-01-01', Dates[0].ISO);
  Assert.AreEqual('2024-01-31', Dates[30].ISO);

  Seq := Chrono.TDate.Sequence(D(2024, 2, 1), D(2024, 2, 29));
  Assert.AreEqual(29, Seq.Count);
  Assert.AreEqual('2024-02-01', Seq.First.ISO);
  Assert.AreEqual('2024-02-29', Seq.Last.ISO);
  Count := 0;
  Last := Chrono.TDate.Zero;
  for Day in Seq do
  begin
    Inc(Count);
    Last := Day;
  end;
  Assert.AreEqual(29, Count);
  Assert.AreEqual('2024-02-29', Last.ISO);
end;

procedure TDateTests.YearMonthQuarterDates;
begin
  Assert.AreEqual(366, Chrono.TYear(2024).Dates.Count);
  Assert.AreEqual(365, Chrono.TYear(2023).Dates.Count);
  Assert.AreEqual('2023-01-01', Chrono.TYear(2023).First.ISO);
  Assert.AreEqual('2023-12-31', Chrono.TYear(2023).Last.ISO);

  Assert.AreEqual(29, Chrono.February.Sequence(2024).Count);
  Assert.AreEqual('2023-02-01', Chrono.February.First(2023).ISO);
  Assert.AreEqual('2023-02-28', Chrono.February.Last(2023).ISO);
  Assert.AreEqual('2024-12-31', Chrono.December.Last(2024).ISO);

  Assert.AreEqual(91, Chrono.Quarter1.Dates(2024).Count);
  Assert.AreEqual(90, Chrono.Quarter1.Dates(2023).Count);
  Assert.AreEqual('2024-10-01', Chrono.Quarter4.Dates(2024).First.ISO);
  Assert.AreEqual('2024-12-31', Chrono.Quarter4.Dates(2024).Last.ISO);
end;

procedure TDateTests.MonthOfYearAndQuarterOfYear;
var
  Date: Chrono.TDate;
  MY: Chrono.TMonthOfYear;
  QY: Chrono.TQuarterOfYear;
begin
  Date := D(2024, 8, 20);
  MY := Date.MonthOfYear;
  Assert.AreEqual(2024, Integer(Word(MY.Year)));
  Assert.AreEqual(8, Integer(Word(MY.Month)));
  QY := Date.QuarterOfYear;
  Assert.AreEqual(2024, Integer(Word(QY.Year)));
  Assert.AreEqual(3, Integer(Word(QY.Quarter)));

  Date.MonthOfYear := Chrono.TMonthOfYear.Create(2023, Chrono.February);
  Assert.AreEqual('2023-02-20', Date.ISO);
end;

procedure TDateTests.DayOfMonthOrdering;
var
  A, B: Chrono.TDayOfMonth;
begin
  A := D(2024, 3, 15).DayOfMonth;
  B := D(2020, 4, 1).DayOfMonth;
  Assert.IsTrue(A < B, 'the month is compared first');
  Assert.IsTrue(D(2024, 3, 15).DayOfMonth = D(1999, 3, 15).DayOfMonth, 'the year is ignored');
  Assert.IsTrue(D(2024, 3, 16).DayOfMonth > A);
end;

procedure TDateTests.TodayMatchesRtl;
var
  Before, After: Chrono.TDate;
  Today: Chrono.TDate;
begin
  // Read the RTL date on both sides to stay correct if the test runs across midnight.
  Before := System.SysUtils.Date;
  Today := Chrono.Today;
  After := System.SysUtils.Date;
  Assert.IsTrue((Today >= Before) and (Today <= After));
  Assert.IsTrue(Chrono.TYear.Current = Today.Year);
end;

{ TWeekdayTests }

procedure TWeekdayTests.Setup;
begin
  FSavedFirstDayOfWeek := Chrono.FirstDayOfWeek;
  FInvariant := TFormatSettings.Invariant;
end;

procedure TWeekdayTests.TearDown;
begin
  Chrono.FirstDayOfWeek := FSavedFirstDayOfWeek;
end;

procedure TWeekdayTests.MatchesRtlForEveryDayFrom0001To9999;
var
  N, Last: Integer;
  Mismatch: string;
begin
  Mismatch := '';
  Last := DateTimeToTimeStamp(EncodeDate(9999, 12, 31)).Date;
  for N := 1 to Last do
    if WD(Chrono.TDate(N).Weekday) <> DayOfWeek(N - DateDelta) then
    begin
      Mismatch := Format('Weekday of day %d', [N]);
      Break;
    end;
  Assert.AreEqual('', Mismatch);
end;

procedure TWeekdayTests.KnownDates;
begin
  Assert.AreEqual(WD(Chrono.Monday), WD(D(1, 1, 1).Weekday));
  Assert.AreEqual(WD(Chrono.Monday), WD(D(2024, 1, 1).Weekday));
  Assert.AreEqual(WD(Chrono.Saturday), WD(D(2000, 1, 1).Weekday));
  Assert.AreEqual(WD(Chrono.Thursday), WD(D(1970, 1, 1).Weekday));
  Assert.AreEqual(WD(Chrono.Friday), WD(D(2100, 12, 31).Weekday));
end;

procedure TWeekdayTests.DayOfWeekIsRelativeToFirstDay;
begin
  Assert.AreEqual(1, Integer(Chrono.Monday.DayOfWeek[Chrono.Monday]));
  Assert.AreEqual(2, Integer(Chrono.Monday.DayOfWeek[Chrono.Sunday]));
  Assert.AreEqual(7, Integer(Chrono.Sunday.DayOfWeek[Chrono.Monday]));
  Assert.AreEqual(1, Integer(Chrono.Saturday.DayOfWeek[Chrono.Saturday]));
  Assert.AreEqual(2, Integer(Chrono.Sunday.DayOfWeek[Chrono.Saturday]));
end;

procedure TWeekdayTests.DayUsesGlobalFirstDayOfWeek;
var
  Day: Chrono.TWeekday;
begin
  Chrono.FirstDayOfWeek := Chrono.Monday;
  Assert.AreEqual(7, Integer(Chrono.Sunday.Day));
  Assert.AreEqual(1, Integer(Chrono.Monday.Day));
  Day := Chrono.Monday;
  Day.Day := 3;
  Assert.AreEqual(WD(Chrono.Wednesday), WD(Day));

  Chrono.FirstDayOfWeek := Chrono.Sunday;
  Assert.AreEqual(1, Integer(Chrono.Sunday.Day));
  Assert.AreEqual(2, Integer(Chrono.Monday.Day));
end;

procedure TWeekdayTests.WeekdayFromOrdinal;
begin
  Assert.AreEqual(WD(Chrono.Monday), WD(Chrono.Weekday(1, Chrono.Monday)));
  Assert.AreEqual(WD(Chrono.Sunday), WD(Chrono.Weekday(7, Chrono.Monday)));
  Assert.AreEqual(WD(Chrono.Friday), WD(Chrono.Weekday(7, Chrono.Saturday)));
  Chrono.FirstDayOfWeek := Chrono.Monday;
  Assert.AreEqual(WD(Chrono.Sunday), WD(Chrono.Weekday(7)));
end;

procedure TWeekdayTests.WeekDaysEnumeration;
var
  Day: Chrono.TWeekday;
  Order: string;
begin
  Order := '';
  for Day in Chrono.WeekDays(Chrono.Monday) do
    Order := Order + IntToStr(WD(Day));
  Assert.AreEqual('2345671', Order);
  Assert.AreEqual(WD(Chrono.Sunday), WD(Chrono.WeekDays(Chrono.Monday)[7]));

  Chrono.FirstDayOfWeek := Chrono.Saturday;
  Order := '';
  for Day in Chrono.WeekDays do
    Order := Order + IntToStr(WD(Day));
  Assert.AreEqual('7123456', Order);
end;

procedure TWeekdayTests.StartAndEndOfWeek;
var
  Thursday: Chrono.TDate;
begin
  Thursday := D(2024, 3, 14);
  Assert.AreEqual('2024-03-11', Thursday.StartOfWeek(Chrono.Monday).ISO);
  Assert.AreEqual('2024-03-17', Thursday.EndOfWeek(Chrono.Monday).ISO);
  Assert.AreEqual('2024-03-10', Thursday.StartOfWeek(Chrono.Sunday).ISO);
  Assert.AreEqual('2024-03-16', Thursday.EndOfWeek(Chrono.Sunday).ISO);
  // The first day of the week is its own start.
  Assert.AreEqual('2024-03-11', D(2024, 3, 11).StartOfWeek(Chrono.Monday).ISO);

  Chrono.FirstDayOfWeek := Chrono.Monday;
  Assert.AreEqual('2024-03-11', Thursday.StartOfWeek.ISO);
  Assert.AreEqual('2024-03-17', Thursday.EndOfWeek.ISO);
end;

procedure TWeekdayTests.NextAndPreviousWeekday;
var
  Thursday: Chrono.TDate;
begin
  Thursday := D(2024, 3, 14);
  Assert.AreEqual('2024-03-18', Thursday.NextWeekday(Chrono.Monday).ISO);
  Assert.AreEqual('2024-03-14', Thursday.NextWeekday(Chrono.Thursday).ISO);
  Assert.AreEqual('2024-03-15', Thursday.NextWeekday(Chrono.Friday).ISO);
  Assert.AreEqual('2024-03-11', Thursday.PreviousWeekday(Chrono.Monday).ISO);
  Assert.AreEqual('2024-03-14', Thursday.PreviousWeekday(Chrono.Thursday).ISO);
  Assert.AreEqual('2024-03-08', Thursday.PreviousWeekday(Chrono.Friday).ISO);
end;

procedure TWeekdayTests.SetWeekdayMovesWithinWeek;
var
  Date: Chrono.TDate;
begin
  Date := D(2024, 3, 14);
  Date.Weekday := Chrono.Monday;
  Assert.AreEqual('2024-03-11', Date.ISO);
  Date.Weekday := Chrono.Saturday;
  Assert.AreEqual('2024-03-16', Date.ISO);
  Date.Weekday := Chrono.Sunday;
  Assert.AreEqual('2024-03-10', Date.ISO);
end;

procedure TWeekdayTests.NamesAndParsing;
var
  Day: Chrono.TWeekday;
begin
  Assert.AreEqual('Monday', Chrono.Monday.LongName(FInvariant));
  Assert.AreEqual('Mon', Chrono.Monday.ShortName(FInvariant));
  Assert.AreEqual('Sunday', Chrono.Sunday.ToString(FInvariant));

  Day.Parse('monday', FInvariant);
  Assert.AreEqual(WD(Chrono.Monday), WD(Day));
  Assert.IsTrue(Day.TryParse('TUE', FInvariant));
  Assert.AreEqual(WD(Chrono.Tuesday), WD(Day));
  Assert.IsFalse(Day.TryParse('Funday', FInvariant));
  Assert.WillRaise(
    procedure
    var
      Bad: Chrono.TWeekday;
    begin
      Bad.Parse('Funday', TFormatSettings.Invariant);
    end, EConvertError);
end;

{ TPeriodTests }

procedure TPeriodTests.AddMonthsClampsToEndOfMonth;
begin
  Assert.AreEqual('2024-02-29', (D(2024, 1, 31) + Chrono.TPeriod.FromMonths(1)).ISO);
  Assert.AreEqual('2023-02-28', (D(2023, 1, 31) + Chrono.TPeriod.FromMonths(1)).ISO);
  Assert.AreEqual('2024-04-30', (D(2024, 3, 31) + Chrono.TPeriod.FromMonths(1)).ISO);
  Assert.AreEqual('2024-03-31', (D(2024, 1, 31) + Chrono.TPeriod.FromMonths(2)).ISO);
end;

procedure TPeriodTests.AddYearToFebruary29;
begin
  Assert.AreEqual('2025-02-28', (D(2024, 2, 29) + Chrono.TPeriod.FromYears(1)).ISO);
  Assert.AreEqual('2028-02-29', (D(2024, 2, 29) + Chrono.TPeriod.FromYears(4)).ISO);
  Assert.AreEqual('2023-02-28', (D(2024, 2, 29) - Chrono.TPeriod.FromYears(1)).ISO);
end;

procedure TPeriodTests.MonthsCarryAcrossYearBoundary;
begin
  Assert.AreEqual('2025-01-15', (D(2024, 12, 15) + Chrono.TPeriod.FromMonths(1)).ISO);
  Assert.AreEqual('2024-12-15', (D(2025, 1, 15) - Chrono.TPeriod.FromMonths(1)).ISO);
  Assert.AreEqual('2026-03-15', (D(2024, 12, 15) + Chrono.TPeriod.FromMonths(15)).ISO);
  Assert.AreEqual('2023-09-15', (D(2024, 12, 15) - Chrono.TPeriod.FromMonths(15)).ISO);
end;

procedure TPeriodTests.AddCombinedPeriod;
begin
  Assert.AreEqual('2025-03-11', D(2024, 1, 1).Plus(Chrono.TPeriod.Create(1, 2, 10)).ISO);
  // Days are added after the month arithmetic (and its clamping).
  Assert.AreEqual('2024-03-01', D(2024, 1, 31).Plus(Chrono.TPeriod.Create(0, 1, 1)).ISO);
  Assert.AreEqual('2023-10-22', D(2024, 1, 1).Minus(Chrono.TPeriod.Create(0, 2, 10)).ISO);
  Assert.AreEqual('2024-01-11', D(2024, 1, 1).Plus(Chrono.TPeriod.FromDays(10)).ISO);
end;

procedure TPeriodTests.Between;
var
  P: Chrono.TPeriod;
begin
  P := Chrono.TPeriod.Between(D(2024, 1, 31), D(2024, 3, 1));
  Assert.AreEqual(0, Integer(P.Years));
  Assert.AreEqual(1, Integer(P.Months));
  Assert.AreEqual(1, Integer(P.Days));

  P := Chrono.TPeriod.Between(D(2024, 3, 1), D(2024, 1, 31));
  Assert.AreEqual(0, Integer(P.Years));
  Assert.AreEqual(-1, Integer(P.Months));
  Assert.AreEqual(-1, Integer(P.Days));

  P := Chrono.TPeriod.Between(D(2020, 2, 29), D(2024, 2, 28));
  Assert.AreEqual(3, Integer(P.Years));
  Assert.AreEqual(11, Integer(P.Months));
  Assert.AreEqual(30, Integer(P.Days));

  P := Chrono.TPeriod.Between(D(1990, 5, 20), D(2024, 5, 20));
  Assert.IsTrue(P = Chrono.TPeriod.FromYears(34));

  Assert.IsTrue(Chrono.TPeriod.Between(D(2024, 5, 20), D(2024, 5, 20)).IsZero);
end;

procedure TPeriodTests.BetweenThenAddRestoresTarget;
const
  Offsets: array[0..11] of Integer = (0, 1, 27, 28, 29, 30, 31, 59, 365, 366, 400, 1000);
var
  N, Offset: Integer;
  A, B: Chrono.TDate;
  Mismatch: string;
begin
  Mismatch := '';
  for N := Integer(D(2023, 1, 1)) to Integer(D(2025, 12, 31)) do
  begin
    A := Chrono.TDate(N);
    for Offset in Offsets do
    begin
      B := A + Offset;
      if A + Chrono.TPeriod.Between(A, B) <> B then
      begin
        Mismatch := A.ISO + ' + Between(' + A.ISO + ', ' + B.ISO + ') = ' +
          (A + Chrono.TPeriod.Between(A, B)).ISO;
        Break;
      end;
    end;
    if Mismatch <> '' then
      Break;
  end;
  Assert.AreEqual('', Mismatch);
end;

procedure TPeriodTests.Operators;
var
  P: Chrono.TPeriod;
begin
  P := Chrono.TPeriod.Create(1, 2, 3) + Chrono.TPeriod.Create(0, 1, 1);
  Assert.IsTrue(P = Chrono.TPeriod.Create(1, 3, 4));
  P := P - Chrono.TPeriod.FromYears(1);
  Assert.IsTrue(P = Chrono.TPeriod.Create(0, 3, 4));
  Assert.IsTrue(-P = Chrono.TPeriod.Create(0, -3, -4));
  Assert.IsTrue(P.Negate <> P);
  Assert.IsTrue(Chrono.TPeriod.Zero.IsZero);
end;

procedure TPeriodTests.ToStringUsesLocalizedUnits;
var
  Y, M, Dd: string;
begin
  Y := Chrono.TDatePart.Year.GetShortName;
  M := Chrono.TDatePart.Month.GetShortName;
  Dd := Chrono.TDatePart.Day.GetShortName;
  Assert.AreEqual('1' + Y + ' 2' + M + ' 3' + Dd, Chrono.TPeriod.Create(1, 2, 3).ToString);
  Assert.AreEqual('5' + M, Chrono.TPeriod.FromMonths(5).ToString);
  Assert.AreEqual('0' + Dd, Chrono.TPeriod.Zero.ToString);
end;

{ TDurationTests }

procedure TDurationTests.Components;
var
  Dur: Chrono.TDuration;
begin
  Dur := Chrono.TDuration.FromHours(25) + Chrono.TDuration.FromMilliseconds(1234);
  Assert.AreEqual(1, Integer(Dur.Days));
  Assert.AreEqual(1, Integer(Dur.Hours));
  Assert.AreEqual(0, Integer(Dur.Minutes));
  Assert.AreEqual(1, Integer(Dur.Seconds));
  Assert.AreEqual(234, Integer(Dur.Milliseconds));
  Assert.AreEqual(Int64(90001234), Dur.TotalMilliseconds);
  Assert.AreEqual(25.00034277778, Dur.TotalHours, 1E-9);
  Assert.AreEqual('1 01:00:01.234', Dur.ToString);
  Assert.AreEqual('00:01:30.000', Chrono.TDuration.FromSeconds(90).ToString);
  Assert.AreEqual(Int64(86400000), Chrono.TDuration.FromDays(1).TotalMilliseconds);
end;

procedure TDurationTests.Negative;
var
  Dur: Chrono.TDuration;
begin
  Dur := Chrono.TDuration.FromMinutes(-90);
  Assert.IsTrue(Dur.IsNegative);
  Assert.AreEqual('-01:30:00.000', Dur.ToString);
  Assert.AreEqual(1, Integer(Dur.Hours));
  Assert.IsTrue(Dur.Abs = Chrono.TDuration.FromMinutes(90));
  Assert.IsTrue(-Dur = Chrono.TDuration.FromMinutes(90));
  Assert.IsTrue(Dur.Negate = Chrono.TDuration.FromMinutes(90));
end;

procedure TDurationTests.Arithmetic;
begin
  Assert.AreEqual(Int64(135000), (Chrono.TDuration.FromSeconds(90) * 1.5).TotalMilliseconds);
  Assert.AreEqual(Int64(150000), (Chrono.TDuration.FromMinutes(10) div 4).TotalMilliseconds);
  Assert.IsTrue(Chrono.TDuration.FromSeconds(60) = Chrono.TDuration.FromMinutes(1));
  Assert.IsTrue(Chrono.TDuration.FromSeconds(59) < Chrono.TDuration.FromMinutes(1));
  Assert.IsTrue(Chrono.TDuration.FromHours(2) > Chrono.TDuration.FromMinutes(119));
  Assert.IsTrue((Chrono.TDuration.FromHours(1) - Chrono.TDuration.FromMinutes(60)).IsZero);
  Assert.IsTrue(Chrono.TDuration.Zero.IsZero);
end;

procedure TDurationTests.BetweenCrossesMidnight;
var
  A, B: Chrono.TDateTime;
begin
  A := Chrono.TDateTime.Create(D(2024, 3, 15), T(23, 0, 0));
  B := Chrono.TDateTime.Create(D(2024, 3, 16), T(1, 30, 0));
  Assert.AreEqual(Int64(MSecs(2, 30, 0)), Chrono.TDuration.Between(A, B).TotalMilliseconds);
  Assert.AreEqual(Int64(-MSecs(2, 30, 0)), Chrono.TDuration.Between(B, A).TotalMilliseconds);
end;

{ TTimeTests }

procedure TTimeTests.Components;
var
  Time: Chrono.TTime;
  H, M, S, MS: Word;
begin
  Time := T(13, 45, 30, 250);
  Assert.AreEqual(13, Integer(Time.Hour));
  Assert.AreEqual(45, Integer(Time.Minute));
  Assert.AreEqual(30, Integer(Time.Second));
  Assert.AreEqual(250, Integer(Time.MSecond));
  Assert.AreEqual(MSecs(13, 45, 30, 250), Integer(Time));
  Time.Decode(H, M, S, MS);
  Assert.AreEqual(13, Integer(H));
  Assert.AreEqual(45, Integer(M));
  Assert.AreEqual(30, Integer(S));
  Assert.AreEqual(250, Integer(MS));
  Time.Minute := 5;
  Assert.AreEqual(MSecs(13, 5, 30, 250), Integer(Time));
  Assert.AreEqual(MSecs(23, 59, 59, 999), Integer(T(23, 59, 59, 999)));
end;

procedure TTimeTests.ISO;
var
  Time: Chrono.TTime;
begin
  Assert.AreEqual('13:45:30', T(13, 45, 30, 250).ISO);
  Assert.AreEqual('00:00:00', Chrono.TTime.Zero.ISO);
  Time.ISO := '08:05:09';
  Assert.AreEqual(MSecs(8, 5, 9), Integer(Time));
end;

procedure TTimeTests.MIME;
var
  Time: Chrono.TTime;
begin
  Assert.AreEqual('134530', T(13, 45, 30).MIME);
  Time.MIME := '1:30 PM';
  Assert.AreEqual(MSecs(13, 30, 0), Integer(Time));
  Time.MIME := '12:00 AM';
  Assert.AreEqual(0, Integer(Time));
  Time.MIME := '12:15 pm';
  Assert.AreEqual(MSecs(12, 15, 0), Integer(Time));
  Time.MIME := '23:59:58';
  Assert.AreEqual(MSecs(23, 59, 58), Integer(Time));
end;

procedure TTimeTests.SystemDateTimeRoundTrip;
var
  Ms: Integer;
  Time: Chrono.TTime;
  Mismatch: string;
begin
  Time := EncodeTime(6, 0, 0, 0);
  Assert.AreEqual(6, Integer(Time.Hour));
  Assert.AreEqual(0.25, Double(System.TDateTime(Time)), 1E-12);
  Time := EncodeDateTime(2024, 3, 15, 23, 59, 59, 999); // the date part is dropped
  Assert.AreEqual(MSecs(23, 59, 59, 999), Integer(Time));

  Mismatch := '';
  Ms := 0;
  while Ms < MSecsPerDay do
  begin
    Time := Chrono.TTime(Ms);
    if Integer(Chrono.TTime(System.TDateTime(Time))) <> Ms then
    begin
      Mismatch := 'Round trip of ' + IntToStr(Ms) + ' ms';
      Break;
    end;
    Inc(Ms, 997);
  end;
  Assert.AreEqual('', Mismatch);
end;

procedure TTimeTests.NamedUnits;
var
  Time: Chrono.TTime;
begin
  Time := T(13, 0, 30);
  Assert.AreEqual(MSecs(15, 0, 30), Integer(Time + Chrono.THours(2)));
  Assert.AreEqual(MSecs(12, 15, 30), Integer(Time - Chrono.TMinutes(45)));
  Assert.AreEqual(MSecs(13, 1, 0), Integer(Time + Chrono.TSeconds(30)));
  Assert.IsTrue(Time > Chrono.THours(13));
  Assert.IsTrue(Time < Chrono.THours(14));
  Assert.IsTrue(Chrono.THours(14) > Time);
  Assert.IsTrue(Time >= Chrono.TMinutes(13 * 60));
  Assert.IsTrue(T(8, 0, 0) = Chrono.THours(8));
  Assert.AreEqual(13, Integer(Chrono.THours(Time)));
  Assert.AreEqual(13 * 60, Integer(Chrono.TMinutes(Time)));
end;

procedure TTimeTests.SubtractGivesDuration;
begin
  Assert.AreEqual(Int64(MSecs(1, 30, 0)), (T(10, 0, 0) - T(8, 30, 0)).TotalMilliseconds);
  Assert.IsTrue((T(8, 30, 0) - T(10, 0, 0)).IsNegative);
end;

procedure TTimeTests.VariantConversion;
var
  V: Variant;
  Time: Chrono.TTime;
begin
  V := T(6, 30, 0);
  Assert.AreEqual(Integer(varDate), Integer(VarType(V)));
  Time := V;
  Assert.AreEqual(MSecs(6, 30, 0), Integer(Time));
end;

{ TSystemDateTimeConversionTests }

procedure TSystemDateTimeConversionTests.ImplicitFromSystemDateTime;
var
  Sys: System.TDateTime;
  Value: Chrono.TDateTime;
begin
  Sys := EncodeDateTime(2024, 3, 15, 10, 20, 30, 400);
  Value := Sys;
  Assert.AreEqual('2024-03-15', Value.Date.ISO);
  Assert.AreEqual(MSecs(10, 20, 30, 400), Integer(Value.Time));
end;

procedure TSystemDateTimeConversionTests.ExplicitFromSystemDateTime;
var
  Sys: System.TDateTime;
begin
  Sys := EncodeDateTime(2024, 3, 15, 10, 20, 30, 400);
  Assert.AreEqual('2024-03-15', Chrono.TDateTime(Sys).Date.ISO);
  Assert.AreEqual(MSecs(10, 20, 30, 400), Integer(Chrono.TDateTime(Sys).Time));
end;

procedure TSystemDateTimeConversionTests.ConstructorFromSystemDateTime;
var
  Value: Chrono.TDateTime;
begin
  Value := Chrono.TDateTime.Create(EncodeDateTime(2024, 3, 15, 10, 20, 30, 400));
  Assert.AreEqual('2024-03-15', Value.Date.ISO);
  Assert.AreEqual(MSecs(10, 20, 30, 400), Integer(Value.Time));
end;

procedure TSystemDateTimeConversionTests.RoundTripToSystemDateTime;
var
  Sys, Back: System.TDateTime;
  Value: Chrono.TDateTime;
begin
  Sys := EncodeDateTime(2024, 3, 15, 10, 20, 30, 400);
  Value := Sys;
  Back := Value;
  Assert.AreEqual(Int64(0), MilliSecondsBetween(Sys, Back));
  Assert.AreEqual(Double(Sys), Double(Back), 1E-9);
end;

procedure TSystemDateTimeConversionTests.VariantRoundTrip;
var
  V: Variant;
  Value, Back: Chrono.TDateTime;
begin
  Value := Chrono.TDateTime.Create(D(2024, 3, 15), T(10, 20, 30, 400));
  V := Value;
  Assert.AreEqual(Integer(varDate), Integer(VarType(V)));
  // The documented way back from a Variant goes through System.TDateTime.
  Back := Chrono.TDateTime(System.TDateTime(V));
  Assert.AreEqual('2024-03-15', Back.Date.ISO);
  Assert.AreEqual(MSecs(10, 20, 30, 400), Integer(Back.Time));
end;

procedure TSystemDateTimeConversionTests.TimeStampRoundTrip;
var
  TS: TTimeStamp;
  Value: Chrono.TDateTime;
begin
  Value := Chrono.TDateTime.Create(D(2024, 3, 15), T(10, 20, 30, 400));
  TS := Value;
  Assert.AreEqual(Integer(D(2024, 3, 15)), TS.Date);
  Assert.AreEqual(MSecs(10, 20, 30, 400), TS.Time);
  Value := Chrono.TDateTime.Zero;
  Value := TS;
  Assert.AreEqual('2024-03-15', Value.Date.ISO);
  Assert.AreEqual(MSecs(10, 20, 30, 400), Integer(Value.Time));
end;

procedure TSystemDateTimeConversionTests.DateBefore1899;
var
  Sys, Back: System.TDateTime;
  Value: Chrono.TDateTime;
  TS: TTimeStamp;
begin
  // System.TDateTime is negative here; its fraction is a time of day whose sign is ignored.
  Sys := EncodeDateTime(1850, 6, 1, 18, 0, 0, 0);
  Value := Sys;
  Assert.AreEqual('1850-06-01', Value.Date.ISO);
  Assert.AreEqual('18:00:00', TimeOf(Value));
  Back := Value;
  Assert.AreEqual(DateTimeToStr(Sys, TFormatSettings.Invariant), DateTimeToStr(Back, TFormatSettings.Invariant));
  TS := Value;
  Assert.AreEqual(Integer(D(1850, 6, 1)), TS.Date);
  Assert.AreEqual(MSecs(18, 0, 0), TS.Time);
end;

{ TDateTimeTests }

procedure TDateTimeTests.AddDurationCrossesMidnightForward;
var
  Value: Chrono.TDateTime;
begin
  Value := Chrono.TDateTime.Create(D(2024, 12, 31), T(23, 30, 0)) + Chrono.TDuration.FromHours(1);
  Assert.AreEqual('2025-01-01', Value.Date.ISO);
  Assert.AreEqual('00:30:00', TimeOf(Value));
  Value := Chrono.TDateTime.Create(D(2024, 3, 15), T(12, 0, 0)).Plus(Chrono.TDuration.FromHours(36));
  Assert.AreEqual('2024-03-17', Value.Date.ISO);
  Assert.AreEqual('00:00:00', TimeOf(Value));
end;

procedure TDateTimeTests.SubtractDurationCrossesMidnightBackward;
var
  Value: Chrono.TDateTime;
begin
  Value := Chrono.TDateTime.Create(D(2024, 3, 15), T(0, 30, 0)) - Chrono.TDuration.FromHours(1);
  Assert.AreEqual('2024-03-14', Value.Date.ISO);
  Assert.AreEqual('23:30:00', TimeOf(Value));
  Value := Chrono.TDateTime.Create(D(2024, 3, 15), T(0, 0, 0)).Minus(Chrono.TDuration.FromMilliseconds(1));
  Assert.AreEqual('2024-03-14', Value.Date.ISO);
  Assert.AreEqual(MSecs(23, 59, 59, 999), Integer(Value.Time));
end;

procedure TDateTimeTests.AddNegativeDays;
var
  Value: Chrono.TDateTime;
begin
  Value := Chrono.TDateTime.Create(D(2024, 3, 1), T(9, 15, 0)) + Chrono.TDuration.FromDays(-3);
  Assert.AreEqual('2024-02-27', Value.Date.ISO);
  Assert.AreEqual('09:15:00', TimeOf(Value));
end;

procedure TDateTimeTests.SubtractGivesDuration;
var
  A, B: Chrono.TDateTime;
begin
  A := Chrono.TDateTime.Create(D(2024, 3, 15), T(8, 0, 0));
  B := Chrono.TDateTime.Create(D(2024, 3, 17), T(9, 30, 0));
  Assert.AreEqual(Int64(2) * MSecsPerDay + MSecs(1, 30, 0), (B - A).TotalMilliseconds);
  Assert.AreEqual(49.5, (B - A).TotalHours, 1E-12);
end;

procedure TDateTimeTests.AddPeriodKeepsTime;
var
  Value: Chrono.TDateTime;
begin
  Value := Chrono.TDateTime.Create(D(2024, 1, 31), T(17, 45, 0)) + Chrono.TPeriod.FromMonths(1);
  Assert.AreEqual('2024-02-29', Value.Date.ISO);
  Assert.AreEqual('17:45:00', TimeOf(Value));
  Value := Value.Minus(Chrono.TPeriod.FromYears(1));
  Assert.AreEqual('2023-02-28', Value.Date.ISO);
  Assert.AreEqual('17:45:00', TimeOf(Value));
end;

procedure TDateTimeTests.StartAndEndOfDay;
var
  Value: Chrono.TDateTime;
begin
  Value := Chrono.TDateTime.Create(D(2024, 3, 15), T(17, 45, 12, 345));
  Assert.AreEqual(0, Integer(Value.StartOfDay.Time));
  Assert.AreEqual(MSecs(23, 59, 59, 999), Integer(Value.EndOfDay.Time));
  Assert.AreEqual('2024-03-15', Value.EndOfDay.Date.ISO);
  Assert.AreEqual('2024-03-16', Value.WithDate(D(2024, 3, 16)).Date.ISO);
  Assert.AreEqual('06:00:00', TimeOf(Value.WithTime(T(6, 0, 0))));
end;

procedure TDateTimeTests.Comparison;
var
  A, B, C: Chrono.TDateTime;
begin
  A := Chrono.TDateTime.Create(D(2024, 3, 15), T(23, 0, 0));
  B := Chrono.TDateTime.Create(D(2024, 3, 16), T(1, 0, 0));
  C := Chrono.TDateTime.Create(D(2024, 3, 16), T(2, 0, 0));
  Assert.IsTrue(A < B);
  Assert.IsTrue(B < C);
  Assert.IsTrue(C > A);
  Assert.IsTrue(B <= B);
  Assert.IsTrue(B >= B);
  Assert.IsTrue(A <> B);
  Assert.IsTrue(A = Chrono.TDateTime.Create(D(2024, 3, 15), T(23, 0, 0)));
end;

{ TCalendarUnitTests }

procedure TCalendarUnitTests.LeapYearsMatchRtl;
var
  Year: Word;
begin
  for Year := 1 to 9999 do
    if Chrono.TYear(Year).IsLeap <> IsLeapYear(Year) then
      Assert.Fail('IsLeap(' + IntToStr(Year) + ')');
  Assert.IsTrue(Chrono.TYear(0).IsLeap, 'year 0 is a leap year (proleptic Gregorian)');
end;

procedure TCalendarUnitTests.MonthDays;
begin
  Assert.AreEqual(29, Integer(Chrono.February.Days(2024)));
  Assert.AreEqual(28, Integer(Chrono.February.Days(1900)));
  Assert.AreEqual(29, Integer(Chrono.February.Days(2000)));
  Assert.AreEqual(30, Integer(Chrono.April.Days(2023)));
  Assert.AreEqual(31, Integer(Chrono.TMonthOfYear.Create(2023, Chrono.December).Days));
end;

procedure TCalendarUnitTests.MonthNames;
var
  Invariant: TFormatSettings;
begin
  Invariant := TFormatSettings.Invariant;
  Assert.AreEqual('March', Chrono.March.ToString(Invariant));
  Assert.AreEqual('Mar', Chrono.March.ToString(True, Invariant));
  // Parsing uses the global FormatSettings, so build the input from it.
  Assert.AreEqual(3, Integer(Word(Chrono.TMonth(FormatSettings.LongMonthNames[3]))));
  Assert.AreEqual(11, Integer(Word(Chrono.TMonth(FormatSettings.ShortMonthNames[11]))));
  Assert.WillRaise(
    procedure
    var
      Month: Chrono.TMonth;
    begin
      Month := Chrono.TMonth('Smarch');
    end, EConvertError);
end;

procedure TCalendarUnitTests.QuarterParsing;
begin
  Assert.AreEqual(1, Integer(Word(Chrono.TQuarter('I'))));
  Assert.AreEqual(2, Integer(Word(Chrono.TQuarter('II'))));
  Assert.AreEqual(3, Integer(Word(Chrono.TQuarter('III'))));
  Assert.AreEqual(4, Integer(Word(Chrono.TQuarter('IV'))));
  Assert.AreEqual(3, Integer(Word(Chrono.TQuarter('3'))));
  Assert.AreEqual(3, Integer(Word(Chrono.TQuarter(#$2162))));
  Assert.AreEqual('IV', string(Chrono.Quarter4));
  Assert.WillRaise(
    procedure
    var
      Quarter: Chrono.TQuarter;
    begin
      Quarter := Chrono.TQuarter('X');
    end, EConvertError);
end;

procedure TCalendarUnitTests.QuarterRangeAndMonths;
var
  Q: Chrono.TQuarter;
  M: Chrono.TMonth;
  Order: string;
begin
  Assert.AreEqual(3, Chrono.TQuarter.Range(Chrono.Quarter1, Chrono.Quarter3).Count);
  Order := '';
  for Q in Chrono.TQuarter.Range(Chrono.Quarter2, Chrono.Quarter4) do
    Order := Order + string(Q) + ' ';
  Assert.AreEqual('II III IV ', Order);

  Assert.AreEqual(4, Integer(Word(Chrono.Quarter2.First)));
  Assert.AreEqual(6, Integer(Word(Chrono.Quarter2.Last)));
  Order := '';
  for M in Chrono.Quarter3.Months do
    Order := Order + IntToStr(Word(M)) + ' ';
  Assert.AreEqual('7 8 9 ', Order);
end;

procedure TCalendarUnitTests.MonthOfYearArithmetic;
var
  MY: Chrono.TMonthOfYear;
  Count: Integer;
begin
  MY := Chrono.TMonthOfYear.Create(2024, Chrono.December) + 1;
  Assert.AreEqual(2025, Integer(Word(MY.Year)));
  Assert.AreEqual(1, Integer(Word(MY.Month)));
  Dec(MY);
  Assert.AreEqual(2024, Integer(Word(MY.Year)));
  Assert.AreEqual(12, Integer(Word(MY.Month)));
  MY := MY - 13;
  Assert.AreEqual(2023, Integer(Word(MY.Year)));
  Assert.AreEqual(11, Integer(Word(MY.Month)));
  Assert.AreEqual(14, Chrono.TMonthOfYear.Create(2025, Chrono.January) - Chrono.TMonthOfYear.Create(2023, Chrono.November));
  Assert.IsTrue(Chrono.TMonthOfYear.Create(2023, Chrono.December) < Chrono.TMonthOfYear.Create(2024, Chrono.January));

  MY := Chrono.TMonthOfYear.Create(2024, Chrono.February);
  Assert.AreEqual('2024-02-01', MY.First.ISO);
  Assert.AreEqual('2024-02-29', MY.Last.ISO);
  Count := 0;
  for var Day in MY.Dates do
    Inc(Count);
  Assert.AreEqual(29, Count);
end;

procedure TCalendarUnitTests.QuarterOfYearArithmetic;
var
  QY: Chrono.TQuarterOfYear;
  Order: string;
begin
  QY := Chrono.TQuarterOfYear.Create(2024, Chrono.Quarter4) + 1;
  Assert.AreEqual(2025, Integer(Word(QY.Year)));
  Assert.AreEqual(1, Integer(Word(QY.Quarter)));
  QY := QY - 2;
  Assert.AreEqual(2024, Integer(Word(QY.Year)));
  Assert.AreEqual(3, Integer(Word(QY.Quarter)));
  Assert.AreEqual(5, Chrono.TQuarterOfYear.Create(2025, Chrono.Quarter4) - Chrono.TQuarterOfYear.Create(2024, Chrono.Quarter3));

  QY := Chrono.TQuarterOfYear.Create(2024, Chrono.Quarter4);
  Assert.AreEqual(92, QY.Dates.Count);
  Assert.AreEqual('2024-10-01', QY.Dates.First.ISO);
  Assert.AreEqual('2024-12-31', QY.Dates.Last.ISO);
  Order := '';
  for var MY in QY.Months do
    Order := Order + IntToStr(Word(MY.Month)) + ' ';
  Assert.AreEqual('10 11 12 ', Order);

  QY := Chrono.TQuarterOfYear.Create(EncodeDate(2024, 5, 9));
  Assert.AreEqual(2, Integer(Word(QY.Quarter)));
end;

procedure TCalendarUnitTests.DatePartNames;
var
  DatePart: Chrono.TDatePart;
  TimePart: Chrono.TTimePart;
begin
  for DatePart := Low(Chrono.TDatePart) to High(Chrono.TDatePart) do
  begin
    Assert.AreNotEqual('', DatePart.GetName);
    Assert.AreNotEqual('', DatePart.GetShortName);
  end;
  for TimePart := Chrono.TTimePart.Hour to High(Chrono.TTimePart) do
  begin
    Assert.AreNotEqual('', TimePart.GetName);
    Assert.AreNotEqual('', TimePart.GetShortName);
  end;
end;

{ TTimeZoneTests }

procedure TTimeZoneTests.ParseOffsets;
var
  Zone: Chrono.TTimeZone;
begin
  Zone := Chrono.TTimeZone('+03:00');
  Assert.AreEqual(-180, Integer(Zone.Bias));
  Assert.AreEqual('+03:00', string(Zone));
  Assert.AreEqual('+0300', Zone.MIME);

  Zone := Chrono.TTimeZone('-0530');
  Assert.AreEqual(330, Integer(Zone.Bias));
  Assert.AreEqual('-05:30', string(Zone));
  Assert.AreEqual('-0530', Zone.MIME);

  Assert.AreEqual(-300, Integer(Chrono.TTimeZone('+05').Bias));
  Assert.AreEqual(0, Integer(Chrono.TTimeZone('').Bias));
  Assert.AreEqual('+00:00', string(Chrono.TTimeZone('')));
end;

procedure TTimeZoneTests.ParseNamedZones;
begin
  Assert.AreEqual(0, Integer(Chrono.TTimeZone('UTC').Bias));
  Assert.AreEqual(0, Integer(Chrono.TTimeZone('GMT').Bias));
  Assert.AreEqual(0, Integer(Chrono.TTimeZone('Z').Bias));
  Assert.AreEqual(-60, Integer(Chrono.TTimeZone('A').Bias));
  Assert.AreEqual(-720, Integer(Chrono.TTimeZone('M').Bias));
  Assert.AreEqual(60, Integer(Chrono.TTimeZone('N').Bias));
  Assert.AreEqual(720, Integer(Chrono.TTimeZone('Y').Bias));
end;

procedure TTimeZoneTests.UnknownZoneRaises;
begin
  Assert.WillRaise(
    procedure
    var
      Zone: Chrono.TTimeZone;
    begin
      Zone := Chrono.TTimeZone('Mars/Olympus');
    end, EConvertError);
end;

procedure TTimeZoneTests.RegisterZone;
begin
  Chrono.TTimeZone.Register('TEST-MSK', -180);
  Assert.AreEqual(-180, Integer(Chrono.TTimeZone('TEST-MSK').Bias));
end;

procedure TTimeZoneTests.Subtract;
begin
  Assert.AreEqual(-120, Integer(Chrono.TTimeZone('+03:00') - Chrono.TTimeZone('+01:00')));
end;

procedure TTimeZoneTests.SystemZoneIsInRange;
var
  Bias: Integer;
begin
  Bias := Chrono.TTimeZone.System.Bias;
  Assert.IsTrue((Bias >= -24 * 60) and (Bias <= 24 * 60));
end;

{ TBasicCalendarTests }

procedure TBasicCalendarTests.WeekendsAreNotWorkDays;
var
  Calendar: Chrono.ICalendarProvider;
begin
  Calendar := Chrono.TBasicCalendar.Create;
  Assert.IsTrue(Calendar.IsWeekEnd(D(2024, 3, 16)));   // Saturday
  Assert.IsTrue(Calendar.IsWeekEnd(D(2024, 3, 17)));   // Sunday
  Assert.IsFalse(Calendar.IsWeekEnd(D(2024, 3, 18)));  // Monday
  Assert.IsFalse(Calendar.IsWorkDay(D(2024, 3, 16)));
  Assert.IsTrue(Calendar.IsWorkDay(D(2024, 3, 18)));
end;

procedure TBasicCalendarTests.HolidaysAreNotWorkDays;
var
  Basic: Chrono.TBasicCalendar;
  Calendar: Chrono.ICalendarProvider;
begin
  Basic := Chrono.TBasicCalendar.Create;
  Calendar := Basic; // the interface reference owns the object
  Basic.Holiday[D(2024, 3, 8)] := True;
  Assert.IsTrue(Calendar.IsHoliday(D(2024, 3, 8)));
  Assert.IsFalse(Calendar.IsWorkDay(D(2024, 3, 8)));
  Assert.IsFalse(Calendar.IsHoliday(D(2024, 3, 7)));
  Basic.Holiday[D(2024, 3, 8)] := False;
  Assert.IsTrue(Calendar.IsWorkDay(D(2024, 3, 8)));
end;

procedure TBasicCalendarTests.WorkDayOverrideWins;
var
  Basic: Chrono.TBasicCalendar;
  Calendar: Chrono.ICalendarProvider;
begin
  Basic := Chrono.TBasicCalendar.Create;
  Calendar := Basic;
  Basic.WorkDay[D(2024, 4, 27)] := True;  // a working Saturday
  Basic.Holiday[D(2024, 4, 29)] := True;
  Basic.WorkDay[D(2024, 4, 29)] := True;  // the override beats the holiday
  Basic.WorkDay[D(2024, 4, 30)] := False; // a non-working Tuesday
  Assert.IsTrue(Calendar.IsWorkDay(D(2024, 4, 27)));
  Assert.IsTrue(Calendar.IsWorkDay(D(2024, 4, 29)));
  Assert.IsFalse(Calendar.IsWorkDay(D(2024, 4, 30)));
  Assert.IsTrue(Basic.WorkDay[D(2024, 4, 27)]);
  Assert.IsFalse(Basic.WorkDay[D(2024, 5, 2)], 'no override set');
end;

procedure TBasicCalendarTests.DefaultCalendar;
var
  Custom: Chrono.ICalendarProvider;
begin
  Assert.IsTrue(ChronoTypes.DefaultCalendar <> nil);
  Custom := Chrono.TBasicCalendar.Create;
  SetDefaultCalendar(Custom);
  try
    Assert.IsTrue(ChronoTypes.DefaultCalendar = Custom);
  finally
    SetDefaultCalendar(nil);
  end;
  Assert.IsTrue(ChronoTypes.DefaultCalendar <> nil);
  Assert.IsTrue(ChronoTypes.DefaultCalendar <> Custom);
end;

initialization
  TDUnitX.RegisterTestFixture(TDateTests);
  TDUnitX.RegisterTestFixture(TWeekdayTests);
  TDUnitX.RegisterTestFixture(TPeriodTests);
  TDUnitX.RegisterTestFixture(TDurationTests);
  TDUnitX.RegisterTestFixture(TTimeTests);
  TDUnitX.RegisterTestFixture(TSystemDateTimeConversionTests);
  TDUnitX.RegisterTestFixture(TDateTimeTests);
  TDUnitX.RegisterTestFixture(TCalendarUnitTests);
  TDUnitX.RegisterTestFixture(TTimeZoneTests);
  TDUnitX.RegisterTestFixture(TBasicCalendarTests);

end.
