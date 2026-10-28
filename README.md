# Chrono

A date and time library for Delphi: dedicated types for dates, times, durations
and calendar periods, month-end-aware arithmetic, date ranges and iteration,
months and quarters of a year, weekdays with a configurable first day of the week,
business calendars with holidays, time zone offsets, ISO 8601 formatting and
fast table-free date conversion — all in a single unit.

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
- **Validated values**: impossible dates and times (February 30, 24:00, month 13)
  raise `EConvertError` instead of turning into garbage; `IsValid` and `TryCreate`
  check without raising.
- **Interoperability**: conversions to and from `System.TDateTime`, `TTimeStamp`
  and `Variant` — implicit where nothing is lost, explicit where a part is dropped.
- **Business calendars**: weekends, holidays and moved working days through the
  `ICalendarProvider` interface and the `TBasicCalendar` class.
- **Time zone offsets** in `+HH:MM`, `+HHMM` and RFC 5322 named forms.
- **Translatable**: month and weekday names, names of date and time units and
  error messages come from a `Chrono.TLocale`, with month names in the genitive
  case where a language needs it ("27 октября 2026"). A Russian locale is
  included, and a locale for any other language can be built from any
  dictionary.
- **Fast without lookup tables**: dates are encoded and decoded with a few
  integer multiplications, so the speed does not depend on what else the program
  keeps in the CPU cache.
- **Small**: a single file that needs only `System.SysUtils` and
  `System.Variants` from the RTL — no `System.Classes` or generic collections —
  so it adds about 55 KB to an executable.

## Background

Chrono is used in production and has been in use since Delphi 10.4 Sydney.

It is the successor of `Ext.Types.Date`, my experimental unit from
[Ext.Types](https://github.com/apokroy/Ext.Types), which is now archived: that unit mixed
its own types with the system `TDateTime`. Chrono keeps all its types separate,
inside the `Chrono` namespace, and converts to and from `System.TDateTime`
through dedicated conversion operators.

## Requirements

- Delphi 10.4 Sydney or later.
- Platforms: Windows 32/64-bit and Linux 64-bit are tested; the unit also
  compiles for macOS (x64 and ARM64), but that is not tested.

## Installation

Copy `Source/ChronoTypes.pas` into your project (or add the `Source` folder to
the library or project search path) and add the unit to the `uses` clause:

```pascal
uses
  ChronoTypes;
```

All types are nested in the `Chrono` record, which acts as a namespace, so they
do not clash with `System.TDate`, `System.TTime` or `System.TDateTime`:
write `Chrono.TDate`, `Chrono.TTime`, `Chrono.Monday`, `Chrono.February` and so on.

For Russian texts, also copy `Source/ChronoTypes.Russian.pas` (see
[Languages](#languages)).

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

  if not Chrono.TDate.TryCreate(2023, 2, 29, Date) then
    Writeln('2023-02-29 does not exist');              // Chrono.TDate.Create would raise EConvertError
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
  Write(Weekday.ShortName, ' ');                       // Mon Tue Wed Thu Fri Sat Sun (names come from Chrono.Locale)
```

### Languages

The texts that Chrono produces itself — month and weekday names, names of date
and time units, error messages — come from `Chrono.Locale`. By default it is
`Chrono.TLocale.System`: month and weekday names of the global `FormatSettings`
(that is, of the OS) and English for the rest. The Russian locale is in a
separate unit:

```pascal
uses
  ChronoTypes, ChronoTypes.Russian;
...
  Chrono.Locale := RussianLocale;
  Writeln(Chrono.TDate.Create(2026, 10, 27).Format('d mmmm yyyy')); // 27 октября 2026
  Writeln(Chrono.TDate.Create(2026, 10, 27).Format('mmmm yyyy'));   // Октябрь 2026
  Writeln(Chrono.TPeriod.Create(1, 3, 10).ToString);                // 1г 3мес 10дн
  Chrono.TDate.Create(2023, 2, 29);                                 // EConvertError: Неверная дата: год 2023, месяц 2, день 29
```

A full month name next to a day number is put in the genitive case, the rule
Windows uses: `d mmmm` gives "27 октября", `mmmm yyyy` gives "Октябрь 2026".

Every text has a key — `month.october`, `month.october.genitive`,
`month.october.short`, `weekday.monday`, `part.year.short`, `error.date-range`
and so on; `Chrono.TLocale.Keys` lists all 82. A locale of your own asks a
lookup function for each key, so the texts can come from a file, a database
table or a hash table:

```pascal
var
  German: Chrono.TLocale;
begin
  German := Chrono.TLocale.Create('de', Chrono.TLocale.English,
    function(Key: string): string        // no const: the signature of TFunc<string, string>
    begin
      if not Dictionary.TryGetValue(Key, Result) then
        Result := '';                    // empty: the text of the base locale (English here)
    end);
  Chrono.Locale := German;
```

A translated error message must take the same `Format` arguments as the English
one (in any order, `%1:d`); otherwise the base text is used, so a bad translation
cannot break raising the error. `ChronoTypes.Russian.pas` lists every key and
serves as a template for another language.

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
  parameter (`StartOfWeek`, `EndOfWeek`, `WeekDays`, `TWeekday.Day`), and by
  assigning `TDate.Weekday`, which moves the date within that week. It is read
  from the user locale on Windows and is Sunday on other platforms; assign it
  to override.
- **Invalid values raise `EConvertError`**: `TDate.Create(2023, 2, 30)`,
  `TTime.Create(24, 0, 0)`, `Chrono.TMonth(13)`, a date beyond 9999-12-31 after
  arithmetic, and so on. Use `TDate.IsValid`/`TryCreate` and `TTime.IsValid`/`TryCreate`
  to check input without exceptions. Setting `Month` (or `WithMonth`) clamps the
  day to the month length (January 31 → February 29), while setting `Day` to a day
  that does not exist in the month raises. `TDate.Zero` (the default value of an
  uninitialized `TDate`) is not a real date; it decodes, and `ISO` prints it, as
  0000-12-31.
- **Numbers convert to the component types implicitly, but not back.**
  `Date.WithYear(2025)`, `Date.WithDay(1)` and `if Date.Month = 12` work with
  plain numbers (validated); getting a number out takes an explicit cast:
  `Word(Date.Day)`, `Integer(Date.Month)`. Because of that, a day cannot be passed
  where a month is expected: `TDate.Create(Year, Day, Month)` with typed values
  does not compile.
- **Conversions that drop information are explicit.** `Chrono.TDate(SomeDateTime)`
  drops the time and `Chrono.TTime(SomeDateTime)` drops the date; converting
  `TDate`/`TTime`/`TDateTime` to `System.TDateTime`, and `System.TDateTime` to
  `Chrono.TDateTime`, stays implicit. In a cast, Delphi does not call a function
  named without parentheses, so write `Chrono.TDate(Now())` or
  `Chrono.TDate.Create(Now)` (or simply `Chrono.Today`).
- **Dates and times do not silently become numbers.** `Date + OtherDate`,
  `Date + Time`, `Date + DateTime`, `Count := Date` and `Text := Date` do not
  compile. Combine a date and a time with `TDateTime.Create(Date, Time)`, and use
  `Date.ISO` or `Date.ToString` for text. `Integer(Date)` gives the day number on
  the `TTimeStamp.Date` scale, not the `System.TDateTime` serial number.
- **Arithmetic wraps where the type is cyclic**: `Chrono.Saturday + 1` is Sunday,
  `Chrono.December + 1` is January, `Chrono.Quarter4 + 1` is Quarter 1, and a
  `TTime` wraps around midnight (23:00 + 2 hours = 01:00). Use `TDateTime` with a
  `TDuration` when the date must change too. `TYear` and `TDay` arithmetic, and
  day arithmetic on `TDate`, raise when the result leaves the valid range.
  There is no `TTime + TTime`: two times of day cannot be added, add a `TDuration`
  (or `THours`/`TMinutes`/`TSeconds`) instead; `TTime - TTime` gives the `TDuration`
  between them.
- **`TDateTime.Create(Date)`** gives midnight of that date.
- **Adding a plain number to a `TTime`** means milliseconds, and it must be a typed
  `Integer` value: an untyped constant (`Time + 500`) is ambiguous with the
  `THours`/`TMinutes`/`TSeconds` overloads. Prefer the named units or a `TDuration`.
- **`TTimeZone.Bias` is in minutes west of UTC** (the Windows convention), so
  `+03:00` has `Bias = -180`. Local time is `UTC - Bias`.
- **Variants**: assigning a `TDate`, `TTime` or `TDateTime` to a `Variant` (or
  to `TField.Value`) needs no cast and gives a `varDate` value; `Variant(Date)`
  does the same explicitly. Reading one back is explicit: `Chrono.TDate(V)`,
  `Chrono.TTime(V)`. There is no direct conversion from a `Variant` to
  `Chrono.TDateTime` because of a compiler issue (see the comment in the source);
  convert through `System.TDateTime`: `Chrono.TDateTime(System.TDateTime(V))`.
- **Names come from `Chrono.Locale`** in the methods without a `FormatSettings`
  parameter: `TMonth.ToString`, `TWeekday.LongName`, `TDatePart.GetName`,
  `TPeriod.ToString`, `TDate.Format`, parsing month and weekday names, error
  messages. The overloads with a `FormatSettings` parameter use its names as
  they are. A locale never changes after it is created, so threads read it
  without locking; free your own locale only after it stops being
  `Chrono.Locale` (freeing the current one switches back to `TLocale.System`).
- **`TBasicCalendar.Holidays` and `WorkDays`** (protected, for descendants) are
  `Chrono.TDateFlags`, a sorted array with `TDictionary`-like methods
  (`TryGetValue`, `AddOrSetValue`, `ContainsKey`, `Remove`, `Clear`, `Count`).
- **Supported years** are 1..9999.

## Building and running the tests

The tests use [DUnitX](https://github.com/VSoft-Technologies/DUnitX), which
ships with Delphi. Open `Tests/ChronoTests.dpr` in the IDE, or use the build
script, which finds Delphi through the `BDS` environment variable or the registry:

```powershell
.\Build.ps1                                          # tests for Win32 and Win64
.\Build.ps1 -Platform Linux64                        # tests for Linux64, run in WSL
.\Build.ps1 -Platform Win32, Win64, Linux64 -Examples
```

Before the tests, the script compiles [Tests/CompileFail.dpr](Tests/CompileFail.dpr)
once per check to make sure that statements which must not compile —
`Date + OtherDate`, `Date + Time`, `Date := Now` and others — are rejected with
the expected compiler error. To add a check, add a line there in the same form.

For Linux64 the script needs a Linux sysroot to link against. By default it
creates `Build/Linux64/sysroot` from a WSL distribution that has `libc6-dev`
installed (`sudo apt install libc6-dev gcc`) and runs the binaries in WSL.
Use `-WslDistro` to choose the distribution, `-LinuxSysroot` to link against an
existing SDK (for example one imported through PAServer), and `-NoRun` to only
build. A sysroot taken from an older distribution produces binaries that also
run on newer ones.

## Changes

See [CHANGELOG.md](CHANGELOG.md).

## License

[MIT](LICENSE) © 2026 Alexey Pokroy