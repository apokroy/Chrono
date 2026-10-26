{ Chrono example: the basic value types — dates, times, date-times,
  calendar units and iteration. }
program Basics;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  ChronoTypes in '..\Source\ChronoTypes.pas';

var
  Invariant: TFormatSettings;

procedure Dates;
var
  Date: Chrono.TDate;
begin
  Writeln('--- Dates ---');
  Date := Chrono.TDate.Create(2024, 2, 29);
  Writeln('Date:            ', Date.ISO);
  Writeln('Year/Month/Day:  ', Word(Date.Year), ' / ', Word(Date.Month), ' / ', Word(Date.Day));
  Writeln('Day of year:     ', Date.DayOfYear);
  Writeln('Quarter:         ', string(Date.Quarter));
  Writeln('Weekday:         ', Date.Weekday.LongName(Invariant));
  Writeln('Leap year:       ', Date.Year.IsLeap);
  Writeln('Tomorrow:        ', (Date + 1).ISO);
  Writeln('Same day 2025:   ', Date.WithYear(2025).ISO, '   (February 29 becomes 28)');
  Writeln('Formatted:       ', Date.Format('dddd, d mmmm yyyy', Invariant));
  Writeln('Days until 2025: ', Chrono.TDate.Create(2025, 1, 1) - Date);
  Writeln('Next Monday:     ', Date.NextWeekday(Chrono.Monday).ISO);
  Writeln('Month ends on:   ', Date.MonthOfYear.Last.ISO);
  Writeln;
end;

procedure Times;
var
  Time: Chrono.TTime;
begin
  Writeln('--- Times ---');
  Time := Chrono.TTime.Create(9, 30, 0);
  Writeln('Time:            ', Time.ISO);
  Writeln('+ 90 minutes:    ', (Time + Chrono.TMinutes(90)).ISO);
  if Time < Chrono.THours(12) then
    Writeln('                 it is still morning');
  Writeln('Until lunch:     ', (Chrono.TTime.Create(13, 0, 0) - Time).ToString);
  Time.MIME := '4:45 PM';
  Writeln('Parsed "4:45 PM" ', Time.ISO);
  Writeln;
end;

procedure DateTimes;
var
  Starts, Ends: Chrono.TDateTime;
  Sys: System.TDateTime;
begin
  Writeln('--- Date and time ---');
  Starts := Chrono.TDateTime.Create(Chrono.TDate.Create(2024, 12, 31), Chrono.TTime.Create(23, 15, 0));
  Ends := Starts + Chrono.TDuration.FromMinutes(90); // crosses midnight and the year boundary
  Writeln('Party starts:    ', Starts.Format('yyyy-mm-dd hh:nn', Invariant));
  Writeln('Party ends:      ', Ends.Format('yyyy-mm-dd hh:nn', Invariant));
  Writeln('Length:          ', (Ends - Starts).ToString);

  // Interoperability with the RTL: implicit conversions both ways.
  Sys := Ends;
  Writeln('As TDateTime:    ', DateTimeToStr(Sys, Invariant));
  Ends := Now;
  Writeln('Now:             ', Ends.Format('yyyy-mm-dd hh:nn:ss', Invariant));
  Writeln;
end;

procedure Iteration;
var
  Day: Chrono.TDate;
  Month: Chrono.TMonth;
  Weekday: Chrono.TWeekday;
begin
  Writeln('--- Iteration ---');
  Write('Fridays in February 2024: ');
  for Day in Chrono.February.Sequence(2024) do
    if Day.Weekday = Chrono.Friday then
      Write(Day.ISO, ' ');
  Writeln;

  Write('Months: ');
  for Month in Chrono.TMonth.Each do
    Write(Month.ToString(True, Invariant), ' ');
  Writeln;

  Writeln('Q4 2024:');
  for var MonthOfYear in Chrono.TQuarterOfYear.Create(2024, Chrono.Quarter4).Months do
    Writeln('  ', MonthOfYear.Month.ToString(Invariant), ' ', Word(MonthOfYear.Year), ': ', MonthOfYear.Days, ' days');

  Write('A week that starts on Monday: ');
  for Weekday in Chrono.WeekDays(Chrono.Monday) do
    Write(Weekday.ShortName(Invariant), ' ');
  Writeln;
  Writeln;
end;

procedure Today;
begin
  Writeln('--- Today ---');
  Writeln('Today:           ', Chrono.Today.ISO);
  Writeln('Week starts on:  ', Chrono.Today.StartOfWeek.ISO,
    ' (first day of week from the OS: ', Chrono.FirstDayOfWeek.LongName(Invariant), ')');
  Writeln('This quarter:    ', string(Chrono.TQuarterOfYear.Current.Quarter), ' ', Word(Chrono.TQuarterOfYear.Current.Year));
end;

begin
  Invariant := TFormatSettings.Invariant;
  try
    Dates;
    Times;
    DateTimes;
    Iteration;
    Today;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
