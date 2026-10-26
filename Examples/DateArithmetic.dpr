{ Chrono example: calendar arithmetic with TPeriod, exact arithmetic with
  TDuration, and time zone offsets. }
program DateArithmetic;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  ChronoTypes in '..\Source\ChronoTypes.pas';

var
  Invariant: TFormatSettings;

function Fmt(const Value: Chrono.TDateTime): string;
begin
  Result := Value.Format('yyyy-mm-dd hh:nn', Invariant);
end;

procedure PeriodVersusDuration;
var
  Start: Chrono.TDateTime;
begin
  Writeln('--- TPeriod (calendar) vs TDuration (exact) ---');
  Start := Chrono.TDateTime.Create(Chrono.TDate.Create(2024, 3, 30), Chrono.TTime.Create(22, 0, 0));
  Writeln('Start:                 ', Fmt(Start));
  Writeln('+ 1 month (TPeriod):   ', Fmt(Start + Chrono.TPeriod.FromMonths(1)));
  Writeln('+ 30 days (TDuration): ', Fmt(Start + Chrono.TDuration.FromDays(30)));
  Writeln('+ 36 hours:            ', Fmt(Start + Chrono.TDuration.FromHours(36)));
  Writeln;
end;

procedure MonthEndBilling;
var
  Anchor, Chained: Chrono.TDate;
  I: Integer;
begin
  Writeln('--- Monthly billing from January 31 ---');
  Writeln('Always add N months to the anchor date; chaining "+1 month" drifts');
  Writeln('after the first short month:');
  Writeln('  N  anchored     chained');
  Anchor := Chrono.TDate.Create(2024, 1, 31);
  Chained := Anchor;
  for I := 0 to 5 do
  begin
    Writeln(Format('  %d  %s   %s', [I, (Anchor + Chrono.TPeriod.FromMonths(I)).ISO, Chained.ISO]));
    Chained := Chained + Chrono.TPeriod.FromMonths(1);
  end;
  Writeln;
end;

procedure Ages;
var
  Birth, OnDate: Chrono.TDate;
  Age: Chrono.TPeriod;
begin
  Writeln('--- Differences between dates ---');
  Birth := Chrono.TDate.Create(1990, 8, 31);
  OnDate := Chrono.TDate.Create(2024, 3, 1);
  Age := Chrono.TPeriod.Between(Birth, OnDate);
  Writeln('Born ', Birth.ISO, ', on ', OnDate.ISO, ' the age is ',
    Age.Years, ' years, ', Age.Months, ' months and ', Age.Days, ' day(s)');
  // Age.ToString would give e.g. "33y 6m 1d" with units localized to the OS language.
  Writeln('Check: birth date + age = ', (Birth + Age).ISO);
  Writeln('Days lived: ', OnDate - Birth);
  Writeln;
end;

procedure Reporting;
var
  Current: Chrono.TQuarterOfYear;
  Month: Chrono.TMonthOfYear;
begin
  Writeln('--- Reporting periods ---');
  Current := Chrono.TQuarterOfYear.Create(2025, Chrono.Quarter1);
  Writeln('Quarter:          ', string(Current.Quarter), ' ', Word(Current.Year),
    ' = ', Current.Dates.First.ISO, ' .. ', Current.Dates.Last.ISO, ' (', Current.Dates.Count, ' days)');
  Writeln('Previous quarter: ', string((Current - 1).Quarter), ' ', Word((Current - 1).Year));

  Month := Chrono.TMonthOfYear.Create(2024, Chrono.November);
  Writeln('Three months after ', Month.Month.ToString(Invariant), ' ', Word(Month.Year), ': ',
    (Month + 3).Month.ToString(Invariant), ' ', Word((Month + 3).Year));
  Writeln;
end;

procedure TimeZones;
var
  Utc: Chrono.TDateTime;
  Zone: Chrono.TTimeZone;
begin
  Writeln('--- Time zones ---');
  Utc := Chrono.TDateTime.Create(Chrono.TDate.Create(2024, 6, 1), Chrono.TTime.Create(21, 30, 0));
  for var Name in ['+03:00', '-0500', 'Z', 'N'] do
  begin
    Zone := Chrono.TTimeZone(Name);
    // Bias is minutes WEST of UTC (Windows convention), so local = UTC - Bias.
    Writeln(Format('%-7s offset %s  bias %5d  local time %s',
      [Name, string(Zone), Zone.Bias, Fmt(Utc - Chrono.TDuration.FromMinutes(Zone.Bias))]));
  end;
  Writeln('This computer:  offset ', string(Chrono.TTimeZone.System));
end;

begin
  Invariant := TFormatSettings.Invariant;
  try
    PeriodVersusDuration;
    MonthEndBilling;
    Ages;
    Reporting;
    TimeZones;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
