# Chrono

A date and time library for Delphi: dedicated types for dates, times, durations
and calendar periods, month-end-aware arithmetic, date ranges and iteration,
months and quarters of a year, weekdays with a configurable first day of the week,
business calendars with holidays, time zone offsets, ISO 8601 formatting and
fast table-driven date conversion — all in a single unit.

Where `System.TDateTime` is one `Double` for everything, Chrono gives each
concept its own small record type with operators, so the compiler can tell them
apart, the arithmetic is exact, and the code reads like the domain:

```pascal
uses
  ChronoTypes;

var
  Due: Chrono.TDate;
  Meeting: Chrono.TDateTime;
begin
  Due := Chrono.TDate.Create(2024, 1, 31) + Chrono.TPeriod.FromMonths(1); // 2024-02-29
  Meeting := Chrono.TDateTime.Create(Due, Chrono.TTime.Create(23, 30, 0))
           + Chrono.TDuration.FromMinutes(90);                          // 2024-03-01 01:00
  if Meeting.Time < Chrono.THours(8) then
    Writeln('Too early: ', Meeting.Format('yyyy-mm-dd hh:nn'));
end;
```

## Features

- **Separate types** for dates, times of day, date-times, exact durations,
  calendar periods, years, quarters, months, days and weekdays.
- **Exact arithmetic**: dates are whole day numbers, times are whole milliseconds,
  durations are `Int64` milliseconds — no `Double` rounding.
- **Calendar-aware periods**: adding months clamps to the end of the month
  (January 31 + 1 month = February 29 in a leap year), `TPeriod.Between`
  computes "years, months, days" differences.
- **Iteration** with `for ... in` over date ranges, months of a year or quarter,
  quarters and weekdays.
- **Interoperability**: implicit conversions to and from `System.TDateTime`,
  `TTimeStamp` and `Variant`.
- **Business calendars**: weekends, holidays and moved working days through the
  `ICalendarProvider` interface and the `TBasicCalendar` class.
- **Time zone offsets** in `+HH:MM`, `+HHMM` and RFC 5322 named forms.
- **Fast**: dates from 1970 to 2100 are encoded and decoded with precomputed
  lookup tables.
- A single unit with no dependencies beyond the Delphi RTL.

## Background

Chrono is used in production and has been in use since Delphi 10.4 Sydney.

It is the successor of, my experimental, `Ext.Types.Date` from
[Ext.Types](https://github.com/apokroy/Ext.Types), which is now archived: that unit mixed
its own types with the system `TDateTime`. Chrono keeps all its types separate,
inside the `Chrono` namespace, and converts to and from `System.TDateTime`
through dedicated conversion operators.

## Requirements

- Delphi 10.3 Rio or later.
- Platforms: Windows 32/64-bit and Linux 64-bit are tested; the unit also
  compiles for macOS (x64 and ARM64), but that is not tested.

## Installation

Copy the `Source` folder into your project (or add it to the library or project
search path) and add the unit to the `uses` clause:

```pascal
uses
  ChronoTypes;
```

The `.inc` files in `Source` are included by `ChronoTypes.pas` and must stay
next to it.

All types are nested in the `Chrono` record, which acts as a namespace, so they
do not clash with `System.TDate`, `System.TTime` or `System.TDateTime`:
write `Chrono.TDate`, `Chrono.TTime`, `Chrono.Monday`, `Chrono.February` and so on.

## Types

| Type | Meaning |
|---|---|
| `Chrono.TDate` | A calendar date (proleptic Gregorian), stored as a day number compatible with `TTimeStamp.Date`. |
| `Chrono.TTime` | A time of day with millisecond precision, compatible with `TTimeStamp.Time`. |
| `Chrono.TDateTime` | A `TDate` + `TTime` pair. |
| `Chrono.TDuration` | An exact time span in milliseconds ("24 hours" is always 86,400,000 ms). |
| `Chrono.TPeriod` | A calendar interval of years, months and days ("1 month" is 28–31 days). |
| `Chrono.TYear`, `TMonth`, `TQuarter`, `TDay` | Single calendar components, with constants such as `Chrono.March` and `Chrono.Quarter2`. |
| `Chrono.TMonthOfYear`, `TQuarterOfYear` | A month or quarter of a particular year; `+ 1` crosses year boundaries. |
| `Chrono.TWeekday`, `TWeek` | A day of the week (`Chrono.Sunday` .. `Chrono.Saturday`) and the days of a week in order. |
| `Chrono.TTimeZone` | A UTC offset. |
| `Chrono.ICalendarProvider`, `TBasicCalendar` | Working days, weekends and holidays. |

## Examples

### Dates

```pascal
var
  Date: Chrono.TDate;
begin
  Date := Chrono.TDate.Create(2024, 2, 29);
  Writeln(Date.ISO);                                   // 2024-02-29
  Writeln(Word(Date.Year), ' Q', Word(Date.Quarter));  // 2024 Q1
  Writeln(Date.DayOfYear);                             // 60
  Writeln(Date.WithYear(2025).ISO);                    // 2025-02-28
  Writeln(Date.NextWeekday(Chrono.Monday).ISO);        // 2024-03-04
  Writeln(Date.StartOfWeek(Chrono.Monday).ISO);        // 2024-02-26
  Writeln(Chrono.TDate.Create(2025, 1, 1) - Date);     // 307 (days)

  Date.ISO := '2024-12-31';
  Inc(Date);                                           // 2025-01-01
end;
```

### Periods and durations

```pascal
var
  Start, Later: Chrono.TDateTime;
  Age: Chrono.TPeriod;
begin
  Start := Chrono.TDateTime.Create(Chrono.TDate.Create(2024, 3, 30), Chrono.TTime.Create(22, 0, 0));
  Later := Start + Chrono.TPeriod.FromMonths(1);    // 2024-04-30 22:00 — calendar arithmetic
  Later := Start + Chrono.TDuration.FromDays(30);   // 2024-04-29 22:00 — exact arithmetic
  Later := Start + Chrono.TDuration.FromHours(36);  // 2024-04-01 10:00
  Writeln((Later - Start).TotalHours:0:1);          // 36.0

  Age := Chrono.TPeriod.Between(Chrono.TDate.Create(1990, 8, 31), Chrono.TDate.Create(2024, 3, 1));
  Writeln(Age.Years, 'y ', Age.Months, 'm ', Age.Days, 'd');  // 33y 6m 1d
end;
```

When you schedule something "every month", add `N` months to the original
date instead of adding one month repeatedly: January 31 + 2 months is March 31,
but January 31 + 1 month + 1 month is March 29.

### Iteration

```pascal
for var Day in Chrono.February.Sequence(2024) do
  if Day.Weekday = Chrono.Friday then
    Writeln(Day.ISO);

for var Month in Chrono.TQuarterOfYear.Create(2024, Chrono.Quarter4).Months do
  Writeln(Month.Month.ToString, ': ', Month.Days, ' days');

for var Weekday in Chrono.WeekDays(Chrono.Monday) do
  Write(Weekday.ShortName, ' ');                       // Mon Tue Wed Thu Fri Sat Sun (names come from FormatSettings)
```

### Working days

```pascal
var
  Company: Chrono.TBasicCalendar;
  Calendar: Chrono.ICalendarProvider;
begin
  Company := Chrono.TBasicCalendar.Create;
  Calendar := Company;                                 // the interface owns the object
  Company.Holiday[Chrono.TDate.Create(2024, 12, 25)] := True;
  Company.WorkDay[Chrono.TDate.Create(2024, 12, 28)] := True; // a working Saturday

  Writeln(Calendar.IsWorkDay(Chrono.TDate.Create(2024, 12, 25))); // FALSE
  Writeln(Calendar.IsWorkDay(Chrono.TDate.Create(2024, 12, 28))); // TRUE
end;
```

Override `IsWeekEnd`, `IsHoliday` or `IsWorkDay` in a `TBasicCalendar`
descendant, or implement `ICalendarProvider` yourself, to plug in your own rules.

The [Examples](Examples) folder contains three complete console programs:
[Basics](Examples/Basics.dpr), [DateArithmetic](Examples/DateArithmetic.dpr)
and [WorkingDays](Examples/WorkingDays.dpr).

## Things to know

- **Weekday numbering is fixed**: `Sunday = 1` .. `Saturday = 7`, the same as
  `System.SysUtils.DayOfWeek`. `TWeekday.Day` and `TWeekday.DayOfWeek[First]`
  give the position relative to a first day of the week.
- **`Chrono.FirstDayOfWeek`** is used by methods without an explicit first-day
  parameter (`StartOfWeek`, `EndOfWeek`, `WeekDays`, `TWeekday.Day`). It is read
  from the user locale on Windows and is Sunday on other platforms; assign it
  to override.
- **Components are not validated.** `TDate.Create(2023, 2, 30)` does not raise;
  in the lookup-table range (1970–2100) it produces `TDate.Zero`. Setting
  `Month` clamps the day to the month length, but setting `Day` does not.
  `TDate.Zero` (the default value of an uninitialized `TDate`) is not a real
  date; it decodes as 0000-12-31.
- **`TTime` arithmetic does not wrap around midnight.** Use `TDateTime` with a
  `TDuration` when a calculation can cross midnight.
- **`TTimeZone.Bias` is in minutes west of UTC** (the Windows convention), so
  `+03:00` has `Bias = -180`. Local time is `UTC - Bias`.
- **Variant to `Chrono.TDateTime`** has no direct conversion because of a
  compiler issue (see the comment in the source); convert through
  `System.TDateTime`: `Chrono.TDateTime(System.TDateTime(V))`.
- **`TPeriod.ToString` and `TDatePart.GetName`** use English or Russian unit
  names, depending on the language of the current thread locale (Windows only;
  English elsewhere).
- **Supported years** are 1..9999. The lookup tables add about 0.5 MB of data
  to the executable.

## Building and running the tests

The tests use [DUnitX](https://github.com/VSoft-Technologies/DUnitX), which
ships with Delphi. Open `Tests/ChronoTests.dpr` in the IDE, or use the build
script, which finds Delphi through the `BDS` environment variable or the registry:

```powershell
.\Build.ps1                                          # tests for Win32 and Win64
.\Build.ps1 -Platform Linux64                        # tests for Linux64, run in WSL
.\Build.ps1 -Platform Win32, Win64, Linux64 -Examples
```

For Linux64 the script needs a Linux sysroot to link against. By default it
creates `Build/Linux64/sysroot` from a WSL distribution that has `libc6-dev`
installed (`sudo apt install libc6-dev gcc`) and runs the binaries in WSL.
Use `-WslDistro` to choose the distribution, `-LinuxSysroot` to link against an
existing SDK (for example one imported through PAServer), and `-NoRun` to only
build. A sysroot taken from an older distribution produces binaries that also
run on newer ones.

## License

[MIT](LICENSE) © 2026 Alexey Pokroy