# Changelog

Notable changes to Chrono. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Until version 1.0 the
API may still change.

## Unreleased

### Breaking changes

- **Invalid values raise `EConvertError`.** `TDate.Create`/`Encode`,
  `TTime.Create`/`Encode`, the component setters and the component types
  (`TYear` 1..9999, `TMonth`, `TDay`, `TQuarter`, `TWeekday`) check their input,
  and day arithmetic on `TDate`, `TYear` and `TDay` raises when the result leaves
  0001-01-01..9999-12-31. Impossible dates used to turn silently into other dates
  or into `TDate.Zero`.
- **Implicit conversions are narrower.**
  - Numbers still convert to `TYear`, `TMonth`, `TDay`, `TQuarter` and
    `TWeekday` implicitly (validated), but getting a number back needs a cast:
    `Word(Date.Day)`. A day can no longer be passed where a month is expected.
  - Conversions that drop a part are explicit: `Chrono.TDate(SomeDateTime)`,
    `Chrono.TTime(SomeDateTime)`, the same from `TTimeStamp` and `Variant`, and
    `TMonthOfYear` to `TMonth`.
  - The operators to `Variant` are explicit; `V := Date` still compiles through
    `System.TDateTime`. As a result `Date + OtherDate`, `Date + Time`,
    `Count := Date` and `Text := Date` no longer compile.
- **Cyclic types wrap around**: `Saturday + 1` is Sunday, `December + 1` is
  January, `Quarter4 + 1` is Quarter 1, and `TTime` wraps around midnight.
- **`TTime + TTime` is removed**: add a `TDuration` or `THours`/`TMinutes`/`TSeconds`.
- **`TDateTime.Create(Date)`** gives midnight instead of the current time of day.
- **Assigning `TDate.Weekday`** moves the date within the week that starts on
  `Chrono.FirstDayOfWeek`, as `StartOfWeek` does; it used a Sunday-based week.
- **`TTimePart`** is `Hour, Minute, Second, Millisecond`: the order is fixed, and
  `Microsecond` and `Nanosecond` are gone (the library has millisecond precision).
- **`TTime.MSecond`** is renamed to `Millisecond`.
- **`TTime.MIME`** returns `HH:MM:SS` (RFC 5322) instead of `HHMMSS`, so the
  value read back can be assigned again.
- **`TDate.Zero`, `TTime.Zero` and `TDateTime.Zero`** are class functions of the
  records. The `TDateHelper`, `TTimeHelper` and `TDateTimeHelper` helpers that
  held them are gone, so a helper of your own for these types no longer hides `Zero`.
- **`TBasicCalendar.Holidays` and `WorkDays`** (protected) are `Chrono.TDateFlags`
  instead of `TDictionary<Integer, Boolean>`. `TryGetValue`, `AddOrSetValue`,
  `ContainsKey`, `Remove`, `Clear` and `Count` keep their names.
- **Internal tables and helpers are no longer public**: `Chrono.YearIsLeap`,
  `Chrono.DateYMD`, `Chrono.MonthOffset` and the other lookup tables,
  `TDateParts`, `MSecsPerHour`, `MSecsPerMinute`, `FMSecsPerDay`, `IMSecsPerDay`,
  `S24`, `S60`, `MIMEWeekdays`, `MIMEMonths`, `ISO8601DateFormatSettings`,
  `Localize` with its state.
- **Texts come from `Chrono.Locale`** in the methods without a `FormatSettings`
  parameter: month and weekday names (`TMonth.ToString`, `string(Month)`,
  `TWeekday.ToString`/`LongName`/`ShortName`, parsing names), unit names
  (`TDatePart.GetName`, `TPeriod.ToString`) and error messages, which are no
  longer resource strings. With the default `TLocale.System` month and weekday
  names are still those of the global `FormatSettings`.
- **Russian is a separate unit.** Unit names no longer switch to Russian on a
  Russian Windows: add `ChronoTypes.Russian` and set `Chrono.Locale := RussianLocale`.
  The Russian short unit names are the common abbreviations (`дн`, `мин`) and the
  time units are singular (`Минута`); the English `Milliseconds` is `Millisecond`.
- **Named time zones** are found regardless of case (`'utc'`, `'z'`).
- **`Chrono.Date` is removed**: it duplicated `Chrono.Today`.

### Added

- `Chrono.TLocale` and `Chrono.Locale`: the texts of the library in one language,
  built from any dictionary by key (`TLocale.Keys`); `TLocale.English` and
  `TLocale.System`. A translated error message with other `Format` arguments
  than the English one is ignored; `MissingKeys` lists what a translation lacks.
- Locales for 13 languages, one unit each: `ChronoTypes.Russian`, `Ukrainian`,
  `Belarusian`, `Polish`, `Czech`, `German`, `French`, `Italian`, `Spanish`,
  `Portuguese`, `Dutch`, `Danish` and `Swedish`. The month and weekday names are
  those of Windows; `ChronoTypes.Russian` is also a template for another language.
- Genitive month names: `TDate.Format`, `TDateTime.Format` and `ToString` put a
  full month name next to a day number in the genitive case ("27 октября 2026"),
  and month names are parsed in it too.
- `TDate.IsValid`/`TryCreate` and `TTime.IsValid`/`TryCreate`.
- `Chrono.TDateFlags`, dates with a flag each in a sorted array.
- `Tests/CompileFail.dpr`, checked by `Build.ps1`: statements that must not
  compile are verified to fail with the expected compiler error.

### Fixed

- A `System.TDateTime` less than half a millisecond before midnight converts to
  midnight of the next day instead of an invalid time of the same day.
- Converting a `TTimeZone` east of UTC to `TTime` raises `EConvertError` instead
  of returning an invalid time.
- `TDate.Zero.ISO` gives `0000-12-31`, as `Decode` does, instead of `0000-00-00`.
- `TWeekday.Parse` reports an invalid day of week name instead of an invalid date.
- Unit names were English on every platform but Windows.

### Performance and size

- No lookup tables: dates are encoded and decoded with integer arithmetic (after
  Neri and Schneider), so their cost does not depend on the CPU cache. In a tight
  loop decoding a date of 1970..2100 is about 0.6 ns slower than with the old
  285 KB table, decoding other years is 2.5 times faster, and in real code, where
  other work pushes the tables out of the cache, the old lookups cost 40–400 ns.
- No `System.Classes`, `System.Generics.Collections` or `System.SyncObjs`: a
  minimal program that uses Chrono shrinks from 2.18 MB to 0.35 MB on Win64
  (1.52 MB to 0.23 MB on Win32).
- `TDuration` and `TDateTime` arithmetic is 1.6–2.8 times faster.
- The library is a single file, `Source/ChronoTypes.pas`; the `.inc` files are gone.

## 2026-10-26

- First public version.
