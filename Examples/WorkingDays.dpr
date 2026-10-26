{ Chrono example: business calendars — holidays, moved working days and a
  custom calendar provider. }
program WorkingDays;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  ChronoTypes in '..\Source\ChronoTypes.pas';

type
  /// <summary>A four-day work week: Friday, Saturday and Sunday are off.</summary>
  TFourDayWeekCalendar = class(Chrono.TBasicCalendar)
  public
    function IsWeekEnd(const Date: Chrono.TDate): Boolean; override;
  end;

function TFourDayWeekCalendar.IsWeekEnd(const Date: Chrono.TDate): Boolean;
begin
  Result := (Date.Weekday = Chrono.Friday) or inherited IsWeekEnd(Date);
end;

/// <summary>The date that is Count working days after Date.</summary>
function AddWorkingDays(const Calendar: Chrono.ICalendarProvider; const Date: Chrono.TDate; Count: Integer): Chrono.TDate;
begin
  Result := Date;
  while Count > 0 do
  begin
    Inc(Result);
    if Calendar.IsWorkDay(Result) then
      Dec(Count);
  end;
end;

function CountWorkingDays(const Calendar: Chrono.ICalendarProvider; const Dates: Chrono.TDate.TSequence): Integer;
begin
  Result := 0;
  for var Day in Dates do
    if Calendar.IsWorkDay(Day) then
      Inc(Result);
end;

var
  Company: Chrono.TBasicCalendar;
  Calendar, FourDays: Chrono.ICalendarProvider;
  December: Chrono.TMonthOfYear;
  Invariant: TFormatSettings;
begin
  Invariant := TFormatSettings.Invariant;
  try
    Company := Chrono.TBasicCalendar.Create;
    Calendar := Company; // the interface reference owns the object from here on

    Company.Holiday[Chrono.TDate.Create(2024, 12, 25)] := True;
    Company.Holiday[Chrono.TDate.Create(2024, 12, 26)] := True;
    Company.Holiday[Chrono.TDate.Create(2025, 1, 1)] := True;
    Company.WorkDay[Chrono.TDate.Create(2024, 12, 28)] := True; // a working Saturday
    Company.WorkDay[Chrono.TDate.Create(2024, 12, 31)] := False; // a day off on New Year's Eve

    December := Chrono.TMonthOfYear.Create(2024, Chrono.December);
    Writeln('December 2024 with the company calendar:');
    for var Day in December.Dates do
    begin
      Write(Day.Format('dd ddd', Invariant), '  ');
      if Calendar.IsWorkDay(Day) then
        Writeln('work')
      else if Calendar.IsHoliday(Day) then
        Writeln('holiday')
      else
        Writeln('off');
    end;
    Writeln('Working days in December 2024: ', CountWorkingDays(Calendar, December.Dates));

    Writeln('5 working days after 2024-12-20: ',
      AddWorkingDays(Calendar, Chrono.TDate.Create(2024, 12, 20), 5).ISO);

    FourDays := TFourDayWeekCalendar.Create;
    Writeln('Working days in December 2024 with a four-day week and no holidays: ',
      CountWorkingDays(FourDays, December.Dates));

    // Code that does not take a calendar parameter can use the global default.
    SetDefaultCalendar(Calendar);
    Writeln('Is 2024-12-28 a working day (default calendar)? ',
      DefaultCalendar.IsWorkDay(Chrono.TDate.Create(2024, 12, 28)));
    SetDefaultCalendar(nil);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
