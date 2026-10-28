program CompileFail;

// Compile-time checks: statements that must NOT compile.
//
// Each {$IFDEF} line below holds such a statement and, after it, the error the
// compiler must report. Build.ps1 compiles this program once as it is, which
// must succeed, and then once per line with that line's symbol defined; a check
// passes only if the compiler reports that error on that line. A statement that
// compiles, or fails with a different error (for example E2251 "ambiguous call"
// instead of E2015 "operator not applicable", which means that some conversion
// path still exists), fails the build.
//
// To add a check, add a line of the same form with a new symbol:
//   {$IFDEF SYMBOL} statement; {$ENDIF} // E<code>
//
// The statements outside {$IFDEF} show what to write instead.

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  ChronoTypes;

var
  D1, D2: Chrono.TDate;
  T1, T2: Chrono.TTime;
  DT1, DT2: Chrono.TDateTime;
  Year: Chrono.TYear;
  Month: Chrono.TMonth;
  Day: Chrono.TDay;
  V: Variant;
  N: Integer;
  S: string;

begin
  D1 := Chrono.TDate.Create(2024, 3, 15);
  D2 := D1 + 7;
  T1 := Chrono.TTime.Create(10, 0, 0);
  T2 := T1 + Chrono.TDuration.FromMinutes(90);
  DT1 := Chrono.TDateTime.Create(D1, T1);
  DT2 := DT1 + Chrono.TDuration.FromHours(36);

  // Dates, times and date-times cannot be added to each other. A date and a
  // time are combined by TDateTime.Create (above); a date is moved by days or
  // a TPeriod, a time by a TDuration or named units.
  {$IFDEF DATE_PLUS_DATE}         D1 := D1 + D2;    {$ENDIF} // E2015
  {$IFDEF DATE_PLUS_TIME}         D1 := D1 + T1;    {$ENDIF} // E2015
  {$IFDEF DATE_MINUS_TIME}        D1 := D1 - T1;    {$ENDIF} // E2015
  {$IFDEF DATE_PLUS_DATETIME}     D1 := D1 + DT1;   {$ENDIF} // E2015
  {$IFDEF TIME_PLUS_DATE}         T1 := T1 + D1;    {$ENDIF} // E2015
  {$IFDEF TIME_PLUS_TIME}         T1 := T1 + T2;    {$ENDIF} // E2015
  {$IFDEF DATETIME_PLUS_DATETIME} DT1 := DT1 + DT2; {$ENDIF} // E2015

  // Nor do they turn into numbers or strings by themselves. Assigning to a
  // Variant needs no cast: it goes through System.TDateTime and gives varDate.
  // (The operators to Variant are explicit so that a Variant cannot carry a
  // date into the statements checked here; see TDate's operators.)
  N := Integer(D1);
  S := D1.ISO;
  V := D1;
  V := T1;
  V := DT1;
  V := Variant(D1);
  {$IFDEF DATE_TO_INTEGER}        N := D1;          {$ENDIF} // E2010
  {$IFDEF DATE_TO_STRING}         S := D1;          {$ENDIF} // E2010

  // Conversions that drop the time or the date are explicit.
  D1 := Chrono.TDate(Now());
  T1 := Chrono.TTime(Now());
  {$IFDEF NOW_TO_DATE}            D1 := Now;        {$ENDIF} // E2010
  {$IFDEF NOW_TO_TIME}            T1 := Now;        {$ENDIF} // E2010

  // Numbers convert to the component types, but not back, so a day cannot be
  // passed where a month is expected.
  Year := D1.Year;
  Month := D1.Month;
  Day := D1.Day;
  N := Integer(Day);
  D1 := Chrono.TDate.Create(Year, Month, Day);
  {$IFDEF DAY_TO_INTEGER}         N := Day;         {$ENDIF} // E2010
  {$IFDEF SWAPPED_COMPONENTS}     D1 := Chrono.TDate.Create(Year, Day, Month); {$ENDIF} // E2250

  // Service helpers and constants are internal.
  {$IFDEF PRIVATE_HELPER}         N := Chrono.DaysInMonth(2024, 2); {$ENDIF} // E2361
  {$IFDEF HIDDEN_CONSTANT}        S := S60[5];      {$ENDIF} // E2003
end.
