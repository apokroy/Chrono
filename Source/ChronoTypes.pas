{ ---------------------------------------------------------------------------
  Chrono — a date and time library for Delphi: value types for dates, times,
  durations and calendar periods, ranges and iteration, months, quarters,
  weekdays, business calendars and time zone offsets.

  All public types live inside the `Chrono` record, which acts as a namespace:
  Chrono.TDate, Chrono.TTime, Chrono.TDateTime, Chrono.TDuration,
  Chrono.TPeriod, Chrono.TMonth, Chrono.TWeekday, ...

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)

  Note: the unit name must not start with "Chrono." — otherwise the compiler
  would read `Chrono.TDate` in user code as a reference to a unit named
  "Chrono.TDate" instead of the nested type.
  --------------------------------------------------------------------------- }
unit ChronoTypes;

{$SCOPEDENUMS ON}

interface

uses
  System.Types, System.SysUtils, System.Variants, System.Generics.Collections
  {$IFDEF MSWINDOWS}, Winapi.Windows{$ENDIF}
  {$IFDEF POSIX}, Posix.SysTypes, Posix.Time, Posix.SysTime{$ENDIF};

type
  Chrono = record
  public type
    /// <summary>Month number: 1 = January, 12 = December.</summary>
    TMonthNum   = 1..12;
    /// <summary>Day-of-week number in Chrono numbering: 1 = Sunday, 7 = Saturday
    /// (see <see cref="TWeekday"/>), regardless of <see cref="Chrono.FirstDayOfWeek"/>.</summary>
    TWeekdayNum = 1..7;
    /// <summary>Quarter of the year: 1..4.</summary>
    TQuarterNum = 1..4;
    /// <summary>Day of the month: 1..31.</summary>
    TMonthDay   = 1..31;
    /// <summary>Ordinal day of the year: 1..366 (366 only in leap years).</summary>
    TDayOfYear  = 1..366;

    /// <summary>Signed number of years (for differences and intervals, not an absolute year — see <see cref="TYear"/>).</summary>
    TYears   = type Integer;
    TMonths  = type Integer;
    TDays    = type Integer;
    THours   = type Integer;
    TMinutes = type Integer;
    TSeconds = type Integer;
    TMilliseconds = type Integer;

    TSetOfWeekdays = set of TWeekdayNum;

    /// <summary>Date component used for rounding/truncation (used together with <see cref="TTimePart"/> by APIs that work with date granularity).</summary>
    TDatePart = (
      Year,
      Quarter,
      Month,
      Week,
      Day
    );

    /// <summary>Time component used for rounding/truncation.</summary>
    TTimePart = (
      Second,
      Hour,
      Minute,
      Millisecond,
      Microsecond,
      Nanosecond
    );

    /// <summary>Decoded calendar date components with no range validation
    /// (a lightweight DTO for the internal <c>DateYMD</c>/<c>YMDDate</c> lookup tables).</summary>
    TDateParts = record
      Y: Word;
      M: Word;
      D: Word;
    end;

  {$region 'Duration'}
    /// <summary>
    ///  An exact physical time span in milliseconds. Unlike TPeriod it has NO
    ///  notion of "month" or "year" and does not depend on the calendar.
    ///  "24 hours" is ALWAYS exactly 86,400,000 ms here, regardless of daylight
    ///  saving transitions. Use TDuration for precise measurements
    ///  (timeouts, polling intervals, benchmarks).
    /// </summary>
    TDuration = record
    private
      FMilliseconds: Int64;
      function  GetDays: TDays; inline;
      function  GetHours: THours; inline;
      function  GetMinutes: TMinutes; inline;
      function  GetSeconds: TSeconds; inline;
      function  GetMilliseconds: TMilliseconds; inline;
    public
      class function FromMilliseconds(const Value: Int64): TDuration; static; inline;
      class function FromSeconds(const Value: Int64): TDuration; static; inline;
      class function FromMinutes(const Value: Int64): TDuration; static; inline;
      class function FromHours(const Value: Int64): TDuration; static; inline;
      class function FromDays(const Value: Int64): TDuration; static; inline;
      class function Zero: TDuration; static; inline;
      /// <summary>Total duration in whole milliseconds.</summary>
      function  TotalMilliseconds: Int64; inline;
      /// <summary>Total duration in seconds (with fractional part).</summary>
      function  TotalSeconds: Double; inline;
      function  TotalMinutes: Double; inline;
      function  TotalHours: Double; inline;
      function  TotalDays: Double; inline;
      /// <summary>The "days" component of the "D HH:MM:SS.mmm" breakdown (absolute value).</summary>
      property  Days: TDays read GetDays;
      /// <summary>The "hours" component (0..23), what remains after removing Days.</summary>
      property  Hours: THours read GetHours;
      property  Minutes: TMinutes read GetMinutes;
      property  Seconds: TSeconds read GetSeconds;
      property  Milliseconds: TMilliseconds read GetMilliseconds;
      function  IsZero: Boolean; inline;
      function  IsNegative: Boolean; inline;
      function  Negate: TDuration; inline;
      function  Abs: TDuration; inline;
      function  ToString: string;
    public
      class operator Add(const A, B: TDuration): TDuration; inline;
      class operator Subtract(const A, B: TDuration): TDuration; inline;
      class operator Multiply(const A: TDuration; const B: Double): TDuration; inline;
      class operator IntDivide(const A: TDuration; const B: Int64): TDuration; inline;
      class operator Negative(const A: TDuration): TDuration; inline;
      class operator Equal(const A, B: TDuration): Boolean; inline;
      class operator NotEqual(const A, B: TDuration): Boolean; inline;
      class operator GreaterThan(const A, B: TDuration): Boolean; inline;
      class operator GreaterThanOrEqual(const A, B: TDuration): Boolean; inline;
      class operator LessThan(const A, B: TDuration): Boolean; inline;
      class operator LessThanOrEqual(const A, B: TDuration): Boolean; inline;
    end;
  {$endregion}

  {$region 'Period'}
    /// <summary>
    ///  A calendar interval: a number of years, months and days. Unlike
    ///  TDuration, the physical length of a TPeriod varies — "1 month" can be
    ///  anywhere from 28 to 31 days depending on the date it is added to.
    ///  Use TPeriod for business logic ("extend the contract by 1 year",
    ///  "defer by 3 months"), not for precise time measurement.
    /// </summary>
    TPeriod = record
    private
      FYears: TYears;
      FMonths: TMonths;
      FDays: TDays;
    public
      class function Create(const Years: TYears; Months: TMonths; Days: TDays): TPeriod; overload; static;
      class function FromYears(const Value: TYears): TPeriod; static; inline;
      class function FromMonths(const Value: TMonths): TPeriod; static; inline;
      class function FromDays(const Value: TDays): TPeriod; static; inline;
      class function Zero: TPeriod; static; inline;
      function  IsZero: Boolean; inline;
      function  Negate: TPeriod; inline;
      function  ToString: string;
      property  Years: TYears read FYears;
      property  Months: TMonths read FMonths;
      property  Days: TDays read FDays;
    public
      class operator Add(const A, B: TPeriod): TPeriod; inline;
      class operator Subtract(const A, B: TPeriod): TPeriod; inline;
      class operator Negative(const A: TPeriod): TPeriod; inline;
      class operator Equal(const A, B: TPeriod): Boolean; inline;
      class operator NotEqual(const A, B: TPeriod): Boolean; inline;
    end;
  {$endregion}

  {$region 'Weeks'}

    PWeekday = ^TWeekday;

    /// <summary>
    ///  Represents a day of the week, numbered from Sunday (1) to Saturday (7).
    /// </summary>
    /// <remarks>
    ///  The internal <c>FDay</c> value ALWAYS uses the fixed numbering
    ///  "Sunday=1..Saturday=7", regardless of locale. The <see cref="Day"/> property and
    ///  the <see cref="DayOfWeek"/> indexer return a "localized" ordinal relative
    ///  to a first day of week (<see cref="Chrono.FirstDayOfWeek"/>) — do not mix the two up.
    /// </remarks>
    TWeekday = record
    private
      FDay: TWeekdayNum;
      function  GetDayOfWeek(const FirstDayOfWeek: TWeekday): TWeekdayNum; inline;
      procedure SetDayOfWeek(const FirstDayOfWeek: TWeekday; const Value: TWeekdayNum); inline;
      function  GetDay: TWeekdayNum; inline;
      procedure SetDay(const Value: TWeekdayNum);  inline;
    public
      /// <summary>Name of the day as in LongDayNames of the global FormatSettings.</summary>
      function  ToString: string; overload; inline;
      ///<summary>
      ///  Name of the day as in LongDayNames of FormatSettings parameter
      ///</summary>
      function  ToString(const FormatSettings: TFormatSettings): string; overload; inline;
      ///<summary>
      ///  Name of the day as in LongDayNames of system global FormatSettings
      ///</summary>
      function  LongName: string; overload; inline;
      ///<summary>
      ///  Name of the day as in LongDayNames of FormatSettings parameter
      ///</summary>
      function  LongName(const FormatSettings: TFormatSettings): string; overload; inline;
      ///<summary>
      ///  Name of the day as in ShortDayNames of system global FormatSettings
      ///</summary>
      function  ShortName: string; overload; inline;
      ///<summary>
      ///  Name of the day as in ShortDayNames of FormatSettings parameter
      ///</summary>
      function  ShortName(const FormatSettings: TFormatSettings): string; overload; inline;
      ///<summary>
      ///  Try parse Value using system global FormatSettings properties LongDayNames and ShortDayNames.
      ///  Case insensitive
      ///</summary>
      procedure Parse(const Value: string); overload;
      ///<summary>
      ///  Try parse Value using FormatSettings properties LongDayNames and ShortDayNames.
      ///  Case insensitive
      ///</summary>
      procedure Parse(const Value: string; const FormatSettings: TFormatSettings); overload;
      function  TryParse(const Value: string): Boolean; overload; inline;
      function  TryParse(const Value: string; const FormatSettings: TFormatSettings): Boolean; overload; inline;
      /// <summary>
      ///  Ordinal of the day (1..7) relative to an arbitrary "first day of week"
      ///  passed as the index. Not to be confused with <see cref="Day"/>, which uses
      ///  the global <see cref="Chrono.FirstDayOfWeek"/> setting.
      /// </summary>
      /// <code>
      ///  Monday.DayOfWeek[Monday] returns 1
      ///  Monday.DayOfWeek[Sunday] returns 2
      /// </code>
      property  DayOfWeek[const FirstDayOfWeek: TWeekday]: TWeekdayNum read GetDayOfWeek write SetDayOfWeek;
      /// <summary>
      ///  Same as <see cref="DayOfWeek"/>, but the reference "first day of week"
      ///  is taken from the global <see cref="Chrono.FirstDayOfWeek"/> setting.
      ///  IMPORTANT: the result depends on the current value of that setting and
      ///  changes when it changes — do not cache it indefinitely.
      /// </summary>
      property  Day: TWeekdayNum read GetDay write SetDay;
    public
      // The comparison/arithmetic operators below work on the internal FDay
      // directly (fixed numbering Sun=1..Sat=7), so Monday + 1 = Tuesday
      // regardless of FirstDayOfWeek — this is arithmetic on the "absolute" day
      // number. There is no wrap-around: Saturday + 1 is out of range.
      function GetHashCode: Integer;
      class operator Add(const a: TWeekday; b: Word): TWeekday; inline;
      class operator Subtract(const a, b: TWeekday): Integer; inline;
      class operator Subtract(const a: TWeekday; const b: Word): TWeekday; inline;
      class operator Implicit(const a: Word): TWeekday; inline;
      class operator Implicit(const a: TWeekday): Word; inline;
      class operator Implicit(const a: TWeekdayNum): TWeekday; inline;
      class operator Implicit(const a: TWeekday): TWeekdayNum; inline;
      class operator Explicit(const a: TWeekday): string; inline;
      class operator Explicit(const a: string): TWeekday; inline;
      class operator Equal(const a, b: TWeekday) : Boolean; inline;
      class operator NotEqual(const a, b: TWeekday) : Boolean; inline;
      class operator GreaterThan(const a, b: TWeekday) : Boolean; inline;
      class operator GreaterThanOrEqual(const a, b: TWeekday) : Boolean; inline;
      class operator LessThan(const a, b: TWeekday) : Boolean; inline;
      class operator LessThanOrEqual(const a, b: TWeekday) : Boolean; inline;
    end;

    PWeek = ^TWeek;

    /// <summary>
    ///  The 7 days of the week, starting from the given FirstDayOfWeek.
    ///  Use it for iteration: <c>for D in Chrono.WeekDays do ...</c>.
    /// </summary>
    TWeek = record
    private type
      TEnumerator = class
      private
        FFirstDayOfWeek: TWeekday;
        FCurrentIndex: Integer;
      public
        function GetCurrent: TWeekday; inline;
        function MoveNext:   Boolean; inline;
        property Current:    TWeekday read GetCurrent;
      end;
    private
      FFirstDayOfWeek: TWeekday;
      function  Get(const Index: TWeekdayNum): TWeekday; inline;
    public
      constructor Create(const FirstDayOfWeek: TWeekday); overload;
      function  GetEnumerator: TEnumerator; inline;
      property  FirstDayOfWeek: TWeekday read FFirstDayOfWeek;
      property  DayOfWeek[const Index: TWeekdayNum]: TWeekday read Get; default;
    end;

    /// <summary>Returns the days of the week starting from the given FirstDayOfWeek.</summary>
    class function  WeekDays(const FirstDayOfWeek: Chrono.TWeekday): Chrono.TWeek; overload; inline; static;
    /// <summary>Returns the days of the week starting from the global <see cref="Chrono.FirstDayOfWeek"/>.</summary>
    class function  WeekDays: Chrono.TWeek; overload; inline; static;

  const
    Sunday: TWeekday = (FDay: 1);
    Monday: TWeekday = (FDay: 2);
    Tuesday: TWeekday = (FDay: 3);
    Wednesday: TWeekday = (FDay: 4);
    Thursday: TWeekday = (FDay: 5);
    Friday: TWeekday = (FDay: 6);
    Saturday: TWeekday = (FDay: 7);

  {$endregion}

  {$region 'Day'}

  type
    PDay = ^TDay;
    /// <summary>
    ///  A day of the month (1..31), not bound to any particular month or year.
    ///  The range is not validated on assignment — that is the caller's
    ///  responsibility. Note that <see cref="TDate.Day"/> does NOT clamp the value
    ///  to the length of the month either (unlike <see cref="TDate.Month"/>).
    /// </summary>
    TDay = record
    private
      FDay: Word;
    public
      function ToString: string;
      function GetHashCode: Integer;
    public
      // The standard set of implicit/explicit conversions and comparison/arithmetic
      // operators, with the same meaning for TDay/TYear/TMonth/TQuarter:
      //  - Implicit(Word) both ways — lossless conversion;
      //  - Explicit(string) both ways — formatting/parsing via IntToStr/StrToInt,
      //    may raise EConvertError on an invalid string;
      //  - Add/Subtract/Multiply/IntDivide — arithmetic without range validation of the result.
      class operator Implicit(const a: Word): TDay; inline;
      class operator Implicit(const a: TDay): Word; inline;
      class operator Explicit(const a: string): TDay; inline;
      class operator Explicit(const a: TDay): string; inline;
      class operator Add(const a: TDay; const b: Word): TDay; inline;
      class operator Subtract(const a: TDay; const b: Word): TDay; inline;
      class operator Multiply(const a: TDay; const b: Word): TDay; inline;
      class operator IntDivide(const a: TDay; const b: Word): TDay; inline;
      class operator Inc(const a: TDay): TDay; inline;
      class operator Dec(const a: TDay): TDay; inline;
      class operator Equal(const a, b: TDay) : Boolean; inline;
      class operator NotEqual(const a, b: TDay) : Boolean; inline;
      class operator GreaterThan(const a, b: TDay) : Boolean; inline;
      class operator GreaterThanOrEqual(const a, b: TDay) : Boolean; inline;
      class operator LessThan(const a, b: TDay) : Boolean; inline;
      class operator LessThanOrEqual(const a, b: TDay) : Boolean; inline;
    end;
  {$endregion}

  {$region 'Year'}
    PYear = ^TYear;

    /// <summary>
    ///  A calendar year.
    ///  Implicitly compatible with Word.
    /// </summary>
    /// <remarks>
    ///  The year is stored as an unsigned Word (0..65535). In particular,
    ///  <c>TYear(0) - 1</c> (via Dec/Subtract) overflows the Word instead of
    ///  producing a negative year — years BC are not supported by this type at all.
    ///  Leap-year lookup (<see cref="IsLeap"/>) is table-driven and covers years 0..10000.
    /// </remarks>
    TYear = record
    private
      FYear: Word;
    public
      /// <summary>Year of the current system date.</summary>
      class function Current: TYear; static;
      /// <summary>
      ///  True if the year is a leap year under the proleptic Gregorian rule
      ///  (divisible by 4 but not by 100, or divisible by 400).
      ///  Implemented as a lookup in the precomputed <c>YearIsLeap</c> table
      ///  (see Chrono.Leap.inc) instead of computing it on the fly — for speed.
      /// </summary>
      function  IsLeap: Boolean; inline;
      function  ToString: string;
      function  GetHashCode: Integer;
    public
      class operator Implicit(const a: Word): TYear; inline;
      class operator Implicit(const a: TYear): Word; inline;
      class operator Explicit(const a: string): TYear; inline;
      class operator Explicit(const a: TYear): string; inline;
      class operator Add(const a: TYear; const b: Word): TYear; inline;
      class operator Subtract(const a: TYear; const b: Word): TYear; inline;
      class operator Subtract(const a, b: TYear): Integer; inline;
      class operator Multiply(const a: TYear; const b: Word): TYear; inline;
      class operator IntDivide(const a: TYear; const b: Word): TYear; inline;
      class operator Inc(const a: TYear): TYear; inline;
      class operator Dec(const a: TYear): TYear; inline;
      class operator Equal(const a, b: TYear) : Boolean; inline;
      class operator NotEqual(const a, b: TYear) : Boolean; inline;
      class operator GreaterThan(const a, b: TYear) : Boolean; inline;
      class operator GreaterThanOrEqual(const a, b: TYear) : Boolean; inline;
      class operator LessThan(const a, b: TYear) : Boolean; inline;
      class operator LessThanOrEqual(const a, b: TYear) : Boolean; inline;
    end;

  {$endregion}

  {$region 'Quarter'}

    PQuarter = ^TQuarter;

    TQuarter = record
    private
      FQuarter: Word;
    private type
      TSequenceEnumerator = class
      private
        FLast, FCurrent: Word;
        function  GetCurrent: TQuarter; inline;
      public
        constructor Create(const First, Last: TQuarterNum);
        function  MoveNext: Boolean; inline;
        property  Current: TQuarter read GetCurrent;
      end;
    public type
      TSequence = record
      private
        FFirst: TQuarterNum;
        FLast: TQuarterNum;
        FCount: Integer;
      public
        constructor Create(const First, Last: TQuarter);
        function  GetEnumerator: TSequenceEnumerator; inline;
        property  Count: Integer read FCount;
      end;
    public const
      Roman: array[TQuarterNum] of string = ('I', 'II', 'III', 'IV');
      Arabic: array[TQuarterNum] of string = ('1', '2', '3', '4');
      /// <summary>
      ///  Unicode Roman numeral characters (U+2160..U+2163: Ⅰ, Ⅱ, Ⅲ, Ⅳ),
      ///  recognized by the <see cref="Explicit(const a: string): TQuarter"/> parser.
      /// </summary>
      Unicode: array[TQuarterNum] of string = (#$2160, #$2161, #$2162, #$2163);
    public
      /// <summary>Creates a sequence of quarters from First to Last inclusive (for iteration).</summary>
      class function Range(const First, Last: TQuarter): TSequence; static; inline;
    public
      class operator Add(const a: TQuarter; b: Word): TQuarter; inline;
      class operator Subtract(const a, b: TQuarter): Integer; inline;
      class operator Subtract(const a: TQuarter; const b: Word): TQuarter; inline;
      class operator Implicit(const a: Word): TQuarter; inline;
      class operator Implicit(const a: TQuarter): Word; inline;
      class operator Implicit(const a: TQuarterNum): TQuarter; inline;
      class operator Implicit(const a: TQuarter): TQuarterNum; inline;
      class operator Explicit(const a: string): TQuarter; inline;
      class operator Explicit(const a: TQuarter): string; inline;
      class operator Equal(const a, b: TQuarter) : Boolean; inline;
      class operator NotEqual(const a, b: TQuarter) : Boolean; inline;
      class operator GreaterThan(const a, b: TQuarter) : Boolean; inline;
      class operator GreaterThanOrEqual(const a, b: TQuarter) : Boolean; inline;
      class operator LessThan(const a, b: TQuarter) : Boolean; inline;
      class operator LessThanOrEqual(const a, b: TQuarter) : Boolean; inline;
    end;

    TQuarters = type TQuarter.TSequence;

  const
    Quarter1: TQuarter = (FQuarter: 1);
    Quarter2: TQuarter = (FQuarter: 2);
    Quarter3: TQuarter = (FQuarter: 3);
    Quarter4: TQuarter = (FQuarter: 4);

  type
    PQuarterOfYear = ^TQuarterOfYear;

    /// <summary>
    ///  A "year + quarter" pair that supports increment/decrement to walk
    ///  quarters across year boundaries (Q4 2024 + 1 = Q1 2025).
    /// </summary>
    /// <remarks>
    ///  The private <c>Index</c> property is a linear "quarters since year 0" index:
    ///  <c>Year * 4 + Quarter - 1</c>. Add/Subtract/Inc/Dec and comparisons are
    ///  implemented on top of it, which gives seamless crossing of year boundaries.
    /// </remarks>
    TQuarterOfYear = record
    private
      FYear: TYear;
      FQuarter: TQuarter;
      procedure SetQuarter(const Value: TQuarter); inline;
      procedure SetYear(const Value: TYear); inline;
      function  GetIndex: Integer; inline;
      procedure SetIndex(const Value: Integer); inline;
      property  Index: Integer read GetIndex write SetIndex;
    public
      constructor Create(const Date: System.TDateTime); overload;
      constructor Create(const Year: TYear; const Quarter: TQuarter); overload;
      /// <summary>Quarter of the current system date.</summary>
      class function Current: TQuarterOfYear; static;
      property  Year: TYear read FYear write SetYear;
      property  Quarter: TQuarter read FQuarter write SetQuarter;
    public
      class operator Explicit(const a: System.TDateTime): TQuarterOfYear; inline;
      class operator Add(const a: TQuarterOfYear; b: Word): TQuarterOfYear; inline;
      class operator Subtract(const a, b: TQuarterOfYear): Integer; inline;
      class operator Subtract(const a: TQuarterOfYear; const b: Word): TQuarterOfYear; inline;
      class operator Inc(const a: TQuarterOfYear): TQuarterOfYear; inline;
      class operator Dec(const a: TQuarterOfYear): TQuarterOfYear; inline;
      class operator Equal(const a, b: TQuarterOfYear) : Boolean; inline;
      class operator NotEqual(const a, b: TQuarterOfYear) : Boolean; inline;
      class operator GreaterThan(const a, b: TQuarterOfYear) : Boolean; inline;
      class operator GreaterThanOrEqual(const a, b: TQuarterOfYear) : Boolean; inline;
      class operator LessThan(const a, b: TQuarterOfYear) : Boolean; inline;
      class operator LessThanOrEqual(const a, b: TQuarterOfYear) : Boolean; inline;
    end;

  {$endregion}

  {$region 'Month'}

  type
    PMonth = ^TMonth;

    ///<summary>
    ///  A month of the year (1..12), not bound to a particular year.
    ///</summary>
    TMonth = record
    private
      FMonth: Word;
    private type
      TSequenceEnumerator = class
      private
        FLast, FCurrent: Word;
        function  GetCurrent: TMonth; inline;
      public
        constructor Create(const First, Last: TMonthNum);
        function  MoveNext: Boolean; inline;
        property  Current: TMonth read GetCurrent;
      end;
    public type
      TSequence = record
      private
        FFirst: TMonthNum;
        FLast: TMonthNum;
        FCount: Integer;
      public
        constructor Create(const First, Last: TMonth);
        function  GetEnumerator: TSequenceEnumerator; inline;
        property  Count: Integer read FCount;
      end;
    public
      /// <summary>Full month name (LongMonthNames of the global FormatSettings).</summary>
      function  ToString: string; overload; inline;
      /// <summary>Full month name (LongMonthNames of the given FormatSettings).</summary>
      function  ToString(const FormatSettings: TFormatSettings): string; overload; inline;
      /// <summary>Month name: short (Short=True, ShortMonthNames) or full (LongMonthNames).</summary>
      function  ToString(Short: Boolean): string; overload; inline;
      function  ToString(Short: Boolean; const FormatSettings: TFormatSettings): string; overload; inline;
      /// <summary>Number of days in this month for the given year (accounts for leap-year February).</summary>
      function  Days(const Year: TYear): TDays; inline;
    public
      class operator Add(const a: TMonth; b: Word): TMonth; inline;
      class operator Subtract(const a, b: TMonth): Integer; inline;
      class operator Subtract(const a: TMonth; const b: Word): TMonth; inline;
      class operator Implicit(const a: Word): TMonth; inline;
      class operator Implicit(const a: TMonth): Word; inline;
      class operator Implicit(const a: TMonth): TMonthNum; inline;
      class operator Explicit(const a: string): TMonth; inline;
      class operator Explicit(const a: TMonth): string; inline;
      class operator Equal(const a, b: TMonth) : Boolean; inline;
      class operator NotEqual(const a, b: TMonth) : Boolean; inline;
      class operator GreaterThan(const a, b: TMonth) : Boolean; inline;
      class operator GreaterThanOrEqual(const a, b: TMonth) : Boolean; inline;
      class operator LessThan(const a, b: TMonth) : Boolean; inline;
      class operator LessThanOrEqual(const a, b: TMonth) : Boolean; inline;
    end;

  const
    January  : TMonth = (FMonth: 1);
    February : TMonth = (FMonth: 2);
    March    : TMonth = (FMonth: 3);
    April    : TMonth = (FMonth: 4);
    May      : TMonth = (FMonth: 5);
    June     : TMonth = (FMonth: 6);
    July     : TMonth = (FMonth: 7);
    August   : TMonth = (FMonth: 8);
    September: TMonth = (FMonth: 9);
    October  : TMonth = (FMonth: 10);
    November : TMonth = (FMonth: 11);
    December : TMonth = (FMonth: 12);

  type
    PMonthOfYear = ^TMonthOfYear;

    /// <summary>
    ///  A "year + month" pair with increment/decrement across year boundaries
    ///  (December 2024 + 1 = January 2025). See also <see cref="TQuarterOfYear"/> —
    ///  the same idea for quarters.
    /// </summary>
    TMonthOfYear = record
    private
      FYear: TYear;
      FMonth: TMonth;
      function  GetDays: TDays; inline;
      procedure SetMonth(const Value: TMonth); inline;
      procedure SetYear(const Value: TYear); inline;
      function  GetIndex: Integer; inline;
      procedure SetIndex(const Value: Integer); inline;
      property  Index: Integer read GetIndex write SetIndex;
    private type
      TSequenceEnumerator = class
      private
        FCurrent: Integer;
        FLast: Integer;
        function  GetCurrent: TMonthOfYear; inline;
      public
        constructor Create(const FirstMonth: TMonth; const FirstYear: TYear; const LastMonth: TMonth; const LastYear: TYear);
        function  MoveNext: Boolean; inline;
        property  Current: TMonthOfYear read GetCurrent;
      end;
    public type
      TSequence = record
      private
        FFirstYear: TYear;
        FFirstMonth: TMonth;
        FLastYear: TYear;
        FLastMonth: TMonth;
        FCount: Integer;
      public
        constructor Create(const First, Last: TMonthOfYear);
        function  GetEnumerator: TSequenceEnumerator; inline;
      end;
    public
      constructor Create(const Date: System.TDateTime); overload;
      constructor Create(const Year: TYear; const Month: TMonth); overload;
      class function Current: TMonthOfYear; static;
      function  ToString: string;
      function  GetHashCode: Integer;
      property  Year: TYear read FYear write SetYear;
      property  Month: TMonth read FMonth write SetMonth;
      property  Days: TDays read GetDays;
    public
      class operator Implicit(const a: TMonthOfYear): TMonth; inline;
      class operator Implicit(const a: TMonthOfYear): TMonthNum; inline;
      class operator Explicit(const a: System.TDateTime): TMonthOfYear; inline;
      class operator Add(const a: TMonthOfYear; b: Word): TMonthOfYear; inline;
      class operator Subtract(const a, b: TMonthOfYear): Integer; inline;
      class operator Subtract(const a: TMonthOfYear; const b: Word): TMonthOfYear; inline;
      class operator Inc(const a: TMonthOfYear): TMonthOfYear; inline;
      class operator Dec(const a: TMonthOfYear): TMonthOfYear; inline;
      class operator Equal(const a, b: TMonthOfYear) : Boolean; inline;
      class operator NotEqual(const a, b: TMonthOfYear) : Boolean; inline;
      class operator GreaterThan(const a, b: TMonthOfYear) : Boolean; inline;
      class operator GreaterThanOrEqual(const a, b: TMonthOfYear) : Boolean; inline;
      class operator LessThan(const a, b: TMonthOfYear) : Boolean; inline;
      class operator LessThanOrEqual(const a, b: TMonthOfYear) : Boolean; inline;
    end;

    TDayOfMonth = record
    private
      FMonth: TMonth;
      FDay: TDay;
      procedure SetDay(const Value: TDay);
      procedure SetMonth(const Value: TMonth);
    public
      function ToString: string;
      function GetHashCode: Integer;
    public
      class operator Equal(const a, b: TDayOfMonth) : Boolean; inline;
      class operator NotEqual(const a, b: TDayOfMonth) : Boolean; inline;
      class operator GreaterThan(const a, b: TDayOfMonth) : Boolean; inline;
      class operator GreaterThanOrEqual(const a, b: TDayOfMonth) : Boolean; inline;
      class operator LessThan(const a, b: TDayOfMonth) : Boolean; inline;
      class operator LessThanOrEqual(const a, b: TDayOfMonth) : Boolean; inline;
    public
      property  Month: TMonth read FMonth write SetMonth;
      property  Day: TDay read FDay write SetDay;
    end;

  {$endregion}

  {$region 'Date'}
  type
    PDate = ^TDate;

    TDate = record
    private type
      TSequenceEnumerator = class
      private
        FStart, FLast: Integer;
        function  GetCurrent: Chrono.TDate; inline;
      public
        constructor Create(const First, Last: Integer);
        function  MoveNext: Boolean; inline;
        property  Current: Chrono.TDate read GetCurrent;
      end;
    public type
      TSequence = record
      private
        FFirst: Integer;
        FLast: Integer;
        FCount: Integer;
      public
        constructor Create(const First, Last: Chrono.TDate);
        function  GetEnumerator: TSequenceEnumerator; inline;
        property  Count: Integer read FCount;
      end;
    private
      // Internal "date stamp" — day number in the proleptic Gregorian calendar,
      // the same scale as TTimeStamp.Date. IMPORTANT: FDate = 1 is 0001-01-01
      // (see Encode(1,1,1)). FDate = 0 is a special case, see the comment in Decode.
      FDate: Integer;
      function  GetDay: TDay; inline;
      function  GetISO: string; inline;
      function  GetMonth: TMonth; inline;
      function  GetWeekday: TWeekday; inline;
      function  GetQuarter: TQuarter; inline;
      function  GetQuarterOfYear: TQuarterOfYear; inline;
      function  GetYear: TYear; inline;
      procedure SetDay(const Value: TDay); inline;
      procedure SetISO(const Value: string);
      procedure SetMonth(const Value: TMonth); inline;
      procedure SetWeekday(const Value: TWeekday); inline;
      procedure SetYear(const Value: TYear); inline;
      function  GetMonthOfYear: TMonthOfYear; inline;
      procedure SetMonthOfYear(const Value: TMonthOfYear); inline;
      function  GetDayOfYear: TDayOfYear;
      procedure SetDayOfYear(const Value: TDayOfYear);
      function  GetDayOfMonth: TDayOfMonth;
    public
      /// <summary>The date in the default format (ShortDateFormat of the global FormatSettings).</summary>
      function  ToString: string; overload; inline;
      function  ToString(const FormatSettings: TFormatSettings): string; overload; inline;
      /// <summary>The date formatted with the Format mask (see FormatDateTime).</summary>
      function  Format(const Format: string): string; overload; inline;
      function  Format(const Format: string; const FormatSettings: TFormatSettings): string; overload; inline;
      /// <summary>Parses a string as a date; raises EConvertError on failure.</summary>
      procedure Parse(const Value: string); overload; inline;
      procedure Parse(const Value: string; const FormatSettings: TFormatSettings); overload; inline;
      /// <summary>Tries to parse a string as a date; returns False on failure (no exception).</summary>
      function  TryParse(const Value: string): Boolean; overload; inline;
      function  TryParse(const Value: string; const FormatSettings: TFormatSettings): Boolean; overload; inline;
      /// <summary>First day of the week containing this date, using the global Chrono.FirstDayOfWeek.</summary>
      function  StartOfWeek: Chrono.TDate; overload; inline;
      /// <summary>First day of the week containing this date, using the given FirstDayOfWeek.</summary>
      function  StartOfWeek(const FirstDayOfWeek: TWeekday): Chrono.TDate; overload; inline;
      function  EndOfWeek: Chrono.TDate; overload; inline;
      function  EndOfWeek(const FirstDayOfWeek: TWeekday): Chrono.TDate; overload; inline;
      /// <summary>A new date with the year replaced (day and month are kept, except February 29 — see SetYear).</summary>
      function  WithYear(const Value: TYear): Chrono.TDate; inline;
      /// <summary>A new date with the month replaced (the day is clamped to the last day of the month if needed).</summary>
      function  WithMonth(const Value: TMonth): Chrono.TDate; inline;
      /// <summary>A new date with the day of month replaced (not clamped — pass a valid day).</summary>
      function  WithDay(const Value: TDay): Chrono.TDate; inline;
      /// <summary>The nearest given weekday on or after this date (the date itself if it already matches).</summary>
      function  NextWeekday(const Day: Chrono.TWeekday): Chrono.TDate;
      /// <summary>The nearest given weekday on or before this date (the date itself if it already matches).</summary>
      function  PreviousWeekday(const Day: Chrono.TWeekday): Chrono.TDate;
      /// <summary>Adds a calendar period (years/months/days) and returns a new date.</summary>
      function  Plus(const Period: Chrono.TPeriod): Chrono.TDate; overload; inline;
      /// <summary>Adds N days and returns a new date.</summary>
      function  Plus(const Days: Integer): Chrono.TDate; overload; inline;
      /// <summary>Subtracts a calendar period and returns a new date.</summary>
      function  Minus(const Period: Chrono.TPeriod): Chrono.TDate; overload; inline;
      function  Minus(const Days: Integer): Chrono.TDate; overload; inline;
      /// <summary>Sets the full date (year/month/day). Uses the YMDDate table for 1970..2100 and a formula otherwise.
      /// Components are not validated: within the table range an impossible date (e.g. February 30) yields <c>TDate.Zero</c>.</summary>
      procedure Encode(const Year, Month, Day: Word); overload; inline;
      /// <summary>Sets the first day of the given month and year.</summary>
      procedure Encode(const Year, Month: Word); overload; inline;
      /// <summary>Sets the first day (January 1) of the given year.</summary>
      procedure Encode(const Year: Word); overload; inline;
      procedure Encode(const Year: TYear; const Month: TMonth; const Day: TDay); overload; inline;
      /// <summary>Splits the date into year/month/day. Uses the DateYMD table for 1970..2100 and cycle arithmetic otherwise.</summary>
      procedure Decode(var Year, Month, Day: Word); overload;
      procedure Decode(var Year, Month: Word); overload; inline;
      procedure Decode(var Year: Word); overload; inline;
      procedure Decode(var Year: TYear; var Month: TMonth; var Day: TDay); overload; inline;
      property  Day: TDay read GetDay write SetDay;
      property  DayOfMonth: TDayOfMonth read GetDayOfMonth;
      property  DayOfYear: TDayOfYear read GetDayOfYear write SetDayOfYear;
      property  Month: TMonth read GetMonth write SetMonth;
      property  Quarter: TQuarter read GetQuarter;
      property  Year: TYear read GetYear write SetYear;
      /// <summary>Day of the week of this date (fixed numbering Sun=1..Sat=7, see <see cref="TWeekday"/>).
      /// Assigning moves the date within the same Sunday-based week.</summary>
      property  Weekday: TWeekday read GetWeekday write SetWeekday;
      property  MonthOfYear: TMonthOfYear read GetMonthOfYear write SetMonthOfYear;
      property  QuarterOfYear: TQuarterOfYear read GetQuarterOfYear;
      /// <summary>The date in ISO 8601 format (YYYY-MM-DD).</summary>
      property  ISO: string read GetISO write SetISO;
    public
      constructor Create(const Date: Chrono.TDate); overload;
      constructor Create(const Date: System.TDateTime); overload;
      constructor Create(const Year: TYear; const Month: TMonth; const Day: TDay); overload;
      constructor Create(const Year, Month, Day: Word); overload;
      /// <summary>The current system date (without time).</summary>
      class function Today: Chrono.TDate; overload; static;
      /// <summary>An array of all dates from First to Last inclusive (materialized; prefer Sequence for large ranges).</summary>
      class function Range(const First, Last: Chrono.TDate): TArray<Chrono.TDate>; static;
      /// <summary>A lazy (not materialized) sequence of dates from First to Last inclusive — preferred for large ranges.</summary>
      class function Sequence(const First, Last: Chrono.TDate): TSequence; static;
    public
      class operator Add(const a: Chrono.TDate; const b: Integer): Chrono.TDate; inline;
      class operator Subtract(const a: Chrono.TDate; const b: Integer): Chrono.TDate; inline;
      class operator Subtract(const a, b: Chrono.TDate): Integer; inline;
      class operator Add(const A: Chrono.TDate; const B: Chrono.TPeriod): Chrono.TDate; inline;
      class operator Subtract(const A: Chrono.TDate; const B: Chrono.TPeriod): Chrono.TDate; inline;
      class operator Implicit(const a: System.TDateTime): Chrono.TDate; inline;
      class operator Implicit(const a: Chrono.TDate): System.TDateTime; inline;
      class operator Implicit(const a: TTimeStamp): Chrono.TDate; inline;
      class operator Implicit(const a: Chrono.TDate): TTimeStamp; inline;
      class operator Implicit(const a: Variant): Chrono.TDate; inline;
      class operator Implicit(const a: Chrono.TDate): Variant; inline;
      class operator Explicit(const a: Integer): Chrono.TDate; inline;
      class operator Explicit(const a: Chrono.TDate): Integer; inline;
      class operator Explicit(const a: Chrono.TDate): string; inline;
      class operator Explicit(const a: string): Chrono.TDate; inline;
      class operator Inc(const a: Chrono.TDate): Chrono.TDate; inline;
      class operator Dec(const a: Chrono.TDate): Chrono.TDate; inline;
      class operator Equal(const a, b: Chrono.TDate) : Boolean; inline;
      class operator NotEqual(const a, b: Chrono.TDate) : Boolean; inline;
      class operator GreaterThan(const a, b: Chrono.TDate) : Boolean; inline;
      class operator GreaterThanOrEqual(const a, b: Chrono.TDate) : Boolean; inline;
      class operator LessThan(const a, b: Chrono.TDate) : Boolean; inline;
      class operator LessThanOrEqual(const a, b: Chrono.TDate) : Boolean; inline;
    end;

    TDates = type Chrono.TDate.TSequence;

  {$endregion}

  {$region 'Time'}
    PTime = ^TTime;

    /// <summary>
    ///  Time of day with millisecond precision, in the range [00:00:00.000, 24:00:00.000).
    /// </summary>
    /// <remarks>
    ///  The internal <c>FTime</c> value is an integer number of milliseconds since
    ///  midnight (0..86399999), the same scale as TTimeStamp.Time. This differs from
    ///  System.TDateTime, where time is the fractional part of a day count (Double) —
    ///  see the Implicit operators for conversions between the two. Arithmetic
    ///  operators do NOT wrap around midnight; use TDateTime + TDuration for that.
    /// </remarks>
    TTime = record
    private
      FTime: Integer;
      function  GetISO: string; inline;
      procedure SetISO(const Value: string);
      function  GetMIME: string; inline;
      procedure SetMIME(const Value: string);
      function  GetHour: Word; inline;
      function  GetMinute: Word; inline;
      function  GetMSecond: Word; inline;
      function  GetSecond: Word; inline;
      procedure SetHour(const Value: Word); inline;
      procedure SetMinute(const Value: Word); inline;
      procedure SetMSecond(const Value: Word); inline;
      procedure SetSecond(const Value: Word); inline;
    public
      function  ToString: string; overload; inline;
      function  ToString(const FormatSettings: TFormatSettings): string; overload; inline;
      function  Format(const Format: string): string; overload; inline;
      function  Format(const Format: string; const FormatSettings: TFormatSettings): string; overload; inline;
      procedure Parse(const Value: string); overload; inline;
      procedure Parse(const Value: string; const FormatSettings: TFormatSettings); overload; inline;
      function  TryParse(const Value: string): Boolean; overload; inline;
      function  TryParse(const Value: string; const FormatSettings: TFormatSettings): Boolean; overload; inline;
      procedure Encode(Hour, Min, Sec: Word; MSec: Word = 0); inline;
      procedure Decode(var Hour, Min, Sec, MSec: Word); overload;
      procedure Decode(var Hour, Min, Sec: Word); overload;
      /// <summary>The time in ISO 8601 format (HH:MM:SS).</summary>
      property  ISO: string read GetISO write SetISO;
      /// <summary>
      ///  Reading returns a compact form without separators (HHMMSS).
      ///  Writing accepts "HH[:MM[:SS]][ AM|PM]" — note that the two directions use
      ///  different formats, so the value read back cannot be assigned again as is.
      /// </summary>
      property  MIME: string read GetMIME write SetMIME;
      property  Hour: Word read GetHour write SetHour;
      property  Minute: Word read GetMinute write SetMinute;
      property  Second: Word read GetSecond write SetSecond;
      property  MSecond: Word read GetMSecond write SetMSecond;
    public
      constructor Create(const Time: Chrono.TTime); overload;
      constructor Create(const Time: System.TDateTime); overload;
      constructor Create(Hour, Min, Sec: Word; MSec: Word = 0); overload;
      /// <summary>The current system time (time of day only, without the date).</summary>
      class function Now: Chrono.TTime; static;
    public
      // Add/Subtract with THours/TMinutes/TSeconds are "named units" for readable
      // arithmetic (Time + THours(2) instead of magic millisecond numbers).
      // Comparison operators with the same types (the 'Hours' block etc. below)
      // allow writing `if SomeTime > THours(8) then` without manual conversion.
      class operator Add(const L: Chrono.TTime; R: Integer): Chrono.TTime; inline;
      class operator Add(const L, R: Chrono.TTime): Chrono.TTime; inline;
      class operator Add(const L: Chrono.TTime; R: THours): Chrono.TTime; inline;
      class operator Add(const L: Chrono.TTime; R: TMinutes): Chrono.TTime; inline;
      class operator Add(const L: Chrono.TTime; R: TSeconds): Chrono.TTime; inline;
      class operator Subtract(const L: Chrono.TTime; R: Integer): Chrono.TTime; inline;
      class operator Subtract(const L, R: Chrono.TTime): TDuration; inline;
      class operator Subtract(const L: Chrono.TTime; R: THours): Chrono.TTime; inline;
      class operator Subtract(const L: Chrono.TTime; R: TMinutes): Chrono.TTime; inline;
      class operator Subtract(const L: Chrono.TTime; R: TSeconds): Chrono.TTime; inline;
      class operator Implicit(const a: System.TDateTime): Chrono.TTime; inline;
      class operator Implicit(const a: Chrono.TTime): System.TDateTime; inline;
      class operator Implicit(const a: TTimeStamp): Chrono.TTime; inline;
      class operator Implicit(const a: Chrono.TTime): TTimeStamp; inline;
      class operator Implicit(const a: Variant): Chrono.TTime; inline;
      class operator Implicit(const a: Chrono.TTime): Variant; inline;
      class operator Explicit(const a: Integer): Chrono.TTime; inline;
      class operator Explicit(const a: Chrono.TTime): Integer; inline;
      class operator Explicit(const a: Chrono.TTime): string; inline;
      class operator Explicit(const a: string): Chrono.TTime; inline;
      class operator Inc(const a: Chrono.TTime): Chrono.TTime; inline;
      class operator Dec(const a: Chrono.TTime): Chrono.TTime; inline;
      class operator Equal(const a, b: Chrono.TTime) : Boolean; inline;
      class operator NotEqual(const a, b: Chrono.TTime) : Boolean; inline;
      class operator GreaterThan(const a, b: Chrono.TTime) : Boolean; inline;
      class operator GreaterThanOrEqual(const a, b: Chrono.TTime) : Boolean; inline;
      class operator LessThan(const a, b: Chrono.TTime) : Boolean; inline;
      class operator LessThanOrEqual(const a, b: Chrono.TTime) : Boolean; inline;

      { Hours }
      class operator Explicit(const a: THours): Chrono.TTime; inline; static;
      class operator Explicit(const a: Chrono.TTime): THours; inline; static;
      class operator Equal(const a: Chrono.TTime; b: THours): Boolean; inline; static;
      class operator NotEqual(const a: Chrono.TTime; b: THours): Boolean; inline; static;
      class operator GreaterThan(const a: Chrono.TTime; b: THours): Boolean; inline; static;
      class operator GreaterThanOrEqual(const a: Chrono.TTime; b: THours): Boolean; inline; static;
      class operator LessThan(const a: Chrono.TTime; b: THours): Boolean; inline; static;
      class operator LessThanOrEqual(const a: Chrono.TTime; b: THours): Boolean; inline; static;
      class operator GreaterThan(const a: THours; b: Chrono.TTime): Boolean; inline; static;
      class operator GreaterThanOrEqual(const a: THours; b: Chrono.TTime): Boolean; inline; static;
      class operator LessThan(const a: THours; b: Chrono.TTime): Boolean; inline; static;
      class operator LessThanOrEqual(const a: THours; b: Chrono.TTime): Boolean; inline; static;

      { Minutes }
      class operator Explicit(const a: Chrono.TMinutes): Chrono.TTime; inline; static;
      class operator Explicit(const a: Chrono.TTime): TMinutes; inline; static;
      class operator Equal(const a: Chrono.TTime; b: TMinutes): Boolean; inline; static;
      class operator NotEqual(const a: Chrono.TTime; b: TMinutes): Boolean; inline; static;
      class operator GreaterThan(const a: Chrono.TTime; b: TMinutes): Boolean; inline; static;
      class operator GreaterThanOrEqual(const a: Chrono.TTime; b: TMinutes): Boolean; inline; static;
      class operator LessThan(const a: Chrono.TTime; b: TMinutes): Boolean; inline; static;
      class operator LessThanOrEqual(const a: Chrono.TTime; b: TMinutes): Boolean; inline; static;
      class operator GreaterThan(const a: TMinutes; b: Chrono.TTime): Boolean; inline; static;
      class operator GreaterThanOrEqual(const a: TMinutes; b: Chrono.TTime): Boolean; inline; static;
      class operator LessThan(const a: TMinutes; b: Chrono.TTime): Boolean; inline; static;
      class operator LessThanOrEqual(const a: TMinutes; b: Chrono.TTime): Boolean; inline; static;

      { Seconds }
      class operator Explicit(const a: TSeconds): Chrono.TTime; inline; static;
      class operator Explicit(const a: Chrono.TTime): TSeconds; inline; static;
      class operator Equal(const a: Chrono.TTime; b: TSeconds): Boolean; inline; static;
      class operator NotEqual(const a: Chrono.TTime; b: TSeconds): Boolean; inline; static;
      class operator GreaterThan(const a: Chrono.TTime; b: TSeconds): Boolean; inline; static;
      class operator GreaterThanOrEqual(const a: Chrono.TTime; b: TSeconds): Boolean; inline; static;
      class operator LessThan(const a: Chrono.TTime; b: TSeconds): Boolean; inline; static;
      class operator LessThanOrEqual(const a: Chrono.TTime; b: TSeconds): Boolean; inline; static;
      class operator GreaterThan(const a: TSeconds; b: Chrono.TTime): Boolean; inline; static;
      class operator GreaterThanOrEqual(const a: TSeconds; b: Chrono.TTime): Boolean; inline; static;
      class operator LessThan(const a: TSeconds; b: Chrono.TTime): Boolean; inline; static;
      class operator LessThanOrEqual(const a: TSeconds; b: Chrono.TTime): Boolean; inline; static;

      { Milliseconds }
      class operator Explicit(const a: TMilliseconds): Chrono.TTime; inline; static;
      class operator Explicit(const a: Chrono.TTime): TMilliseconds; inline; static;
      class operator Equal(const a: Chrono.TTime; b: TMilliseconds): Boolean; inline; static;
      class operator NotEqual(const a: Chrono.TTime; b: TMilliseconds): Boolean; inline; static;
      class operator GreaterThan(const a: Chrono.TTime; b: TMilliseconds): Boolean; inline; static;
      class operator GreaterThanOrEqual(const a: Chrono.TTime; b: TMilliseconds): Boolean; inline; static;
      class operator LessThan(const a: Chrono.TTime; b: TMilliseconds): Boolean; inline; static;
      class operator LessThanOrEqual(const a: Chrono.TTime; b: TMilliseconds): Boolean; inline; static;
      class operator GreaterThan(const a: TMilliseconds; b: Chrono.TTime): Boolean; inline; static;
      class operator GreaterThanOrEqual(const a: TMilliseconds; b: Chrono.TTime): Boolean; inline; static;
      class operator LessThan(const a: TMilliseconds; b: Chrono.TTime): Boolean; inline; static;
      class operator LessThanOrEqual(const a: TMilliseconds; b: Chrono.TTime): Boolean; inline; static;
    end;

  {$endregion}

  {$region 'DateTime'}

    PDateTime = ^TDateTime;

    /// <summary>
    ///  Date and time stored as a separate <see cref="TDate"/> + <see cref="TTime"/>
    ///  pair (unlike System.TDateTime, which is a single floating-point number).
    ///  The split avoids Double rounding errors when working with time at
    ///  millisecond precision.
    /// </summary>
    TDateTime = record
    private
      FDate: Chrono.TDate;
      FTime: Chrono.TTime;
      procedure SetDate(const Value: Chrono.TDate); inline;
      procedure SetTime(const Value: Chrono.TTime); inline;
    public
      function  ToString: string; overload; inline;
      function  ToString(const FormatSettings: TFormatSettings): string; overload; inline;
      function  Format(const Format: string): string; overload; inline;
      function  Format(const Format: string; const FormatSettings: TFormatSettings): string; overload; inline;
      procedure Parse(const Value: string); overload; inline;
      procedure Parse(const Value: string; const FormatSettings: TFormatSettings); overload; inline;
      function  TryParse(const Value: string): Boolean; overload; inline;
      function  TryParse(const Value: string; const FormatSettings: TFormatSettings): Boolean; overload; inline;
      /// <summary>A new value with the date replaced; the time is unchanged.</summary>
      function  WithDate(const Value: Chrono.TDate): Chrono.TDateTime; inline;
      /// <summary>A new value with the time replaced; the date is unchanged.</summary>
      function  WithTime(const Value: Chrono.TTime): Chrono.TDateTime; inline;
      /// <summary>Start of the day (00:00:00.000) on the same date.</summary>
      function  StartOfDay: Chrono.TDateTime; inline;
      /// <summary>End of the day (23:59:59.999) on the same date — handy for inclusive range queries.</summary>
      function  EndOfDay: Chrono.TDateTime; inline;
      function  Plus(const D: Chrono.TDuration): Chrono.TDateTime; overload; inline;
      function  Plus(const P: Chrono.TPeriod): Chrono.TDateTime; overload; inline;
      function  Minus(const D: Chrono.TDuration): Chrono.TDateTime; overload; inline;
      function  Minus(const P: Chrono.TPeriod): Chrono.TDateTime; overload; inline;
      property  Date: Chrono.TDate read FDate write SetDate;
      property  Time: Chrono.TTime read FTime write SetTime;
    public
      constructor Create(const Value: Chrono.TDateTime); overload;
      constructor Create(const Date: Chrono.TDate; const Time: Chrono.TTime); overload;
      constructor Create(const Value: Chrono.TDate); overload;
      constructor Create(const Value: Chrono.TTime); overload;
      constructor Create(const Value: System.TDateTime); overload;
      class function Now: Chrono.TDateTime; static;
    public
      class operator Add(const A: Chrono.TDateTime; const B: Chrono.TDuration): Chrono.TDateTime; inline;
      class operator Subtract(const A: Chrono.TDateTime; const B: Chrono.TDuration): Chrono.TDateTime; inline;
      class operator Subtract(const A, B: Chrono.TDateTime): Chrono.TDuration; inline;
      class operator Add(const A: Chrono.TDateTime; const B: Chrono.TPeriod): Chrono.TDateTime; inline;
      class operator Subtract(const A: Chrono.TDateTime; const B: Chrono.TPeriod): Chrono.TDateTime; inline;
      class operator Implicit(const a: System.TDateTime): Chrono.TDateTime; inline;
      class operator Implicit(const a: Chrono.TDateTime): System.TDateTime; inline;
      class operator Implicit(const a: TTimeStamp): Chrono.TDateTime; inline;
      class operator Implicit(const a: Chrono.TDateTime): TTimeStamp; inline;
      // IMPORTANT: there is intentionally NO Variant -> Chrono.TDateTime operator
      // (neither Implicit nor Explicit) — only the opposite direction below. Declaring
      // ANY such operator (even Explicit) triggers a Delphi compiler code-generation
      // bug (reproduced with compiler version 37.0): since System.TDateTime (= Double)
      // converts implicitly to Variant, the compiler sees TWO competing paths to
      // Chrono.TDateTime — the direct one via Implicit(System.TDateTime) and an
      // indirect one via Variant — and mixes them up. As a result the Date
      // component gets DateDelta added twice (see
      // Chrono.TDate.Implicit(System.TDateTime)), as if the conversion were applied
      // twice. This reproduces both for a plain Implicit(System.TDateTime) (while
      // Implicit(Variant) existed) and for an explicit Chrono.TDateTime(SomeVariant)
      // cast (while Explicit(Variant) existed) — so switching Implicit to Explicit
      // does NOT help; the only reliable workaround is not to declare the operator
      // at all. The regression is covered by the TSystemDateTimeConversionTests
      // fixture in Tests/ChronoTypes.Tests.pas. To get a Chrono.TDateTime from a
      // Variant, convert explicitly through System.TDateTime:
      // Chrono.TDateTime(System.TDateTime(SomeVariant)).
      class operator Implicit(const a: Chrono.TDateTime): Variant; inline;
      class operator Explicit(const a: Chrono.TDateTime): string; inline;
      class operator Explicit(const a: string): Chrono.TDateTime; inline;
      class operator Explicit(const a: Chrono.TDateTime): Chrono.TDate; inline;
      class operator Explicit(const a: Chrono.TDate): Chrono.TDateTime; inline;
      class operator Explicit(const a: Chrono.TDateTime): Chrono.TTime; inline;
      class operator Equal(const a, b: Chrono.TDateTime): Boolean; inline;
      class operator NotEqual(const a, b: Chrono.TDateTime): Boolean; inline;
      class operator GreaterThan(const a, b: Chrono.TDateTime): Boolean; inline;
      class operator GreaterThanOrEqual(const a, b: Chrono.TDateTime): Boolean; inline;
      class operator LessThan(const a, b: Chrono.TDateTime): Boolean; inline;
      class operator LessThanOrEqual(const a, b: Chrono.TDateTime): Boolean; inline;
    end;
  {$endregion}

  {$region 'Time zone'}
    TTimeZoneBias = -24 * 60..24 * 60;

    /// <summary>A time zone offset from UTC in minutes, within ±24 hours.</summary>
    /// <remarks>
    ///  The sign of Bias is the opposite of what you might expect: a positive Bias
    ///  means a zone WEST of UTC (shown with a "minus" sign, see GetMIME and
    ///  Explicit(string)). This matches the Bias field of the Windows
    ///  TIME_ZONE_INFORMATION structure (positive offset = local time is BEHIND
    ///  UTC). Keep this in mind when comparing with the ISO "+HH:MM" notation.
    /// </remarks>
    TTimeZone = record
    private class var
      /// <summary>Registry of named time zones (military letters A..Y, plus UT/UTC/GMT/Z), filled in the class constructor.</summary>
      Timezones: TDictionary<string, TTimeZoneBias>;
      class constructor Create;
      class destructor Destroy;
      /// <summary>Parses 2 digits of S starting at Index as a number (00..99). No bounds or digit checks — the caller must guarantee both.</summary>
      class function  SNum(const S: string; const Index: Integer): Integer; inline; static;
    private
      FBias: TTimeZoneBias;
      function  GetMIME: string;
    public
      /// <summary>The time zone of the current OS settings (takes daylight saving time into account).</summary>
      class function System: TTimeZone; static;
      /// <summary>Registers or overrides a named time zone (a letter code or a name such as "UTC"/"GMT"/"Z"). Names are case-sensitive.</summary>
      class procedure Register(const Code: string; Bias: TTimeZoneBias); static;
      /// <summary>The offset in RFC 5322 (e-mail/MIME) form "+HHMM"/"-HHMM", without a colon.
      /// Use <c>string(TimeZone)</c> for the "+HH:MM" form.</summary>
      property  MIME: string read GetMIME;
      property  Bias: TTimeZoneBias read FBias write FBias;
    public
      class operator Explicit(const A: Chrono.TTimeZone): Chrono.TTime; inline;
      class operator Explicit(const A: Chrono.TTime): Chrono.TTimeZone; inline;
      class operator Explicit(const A: Chrono.TTimeZone): string;
      class operator Explicit(const A: string): Chrono.TTimeZone;
      class operator Explicit(const A: Chrono.TTimeZone): Chrono.TTimeZoneBias; inline;
      class operator Explicit(const A: Chrono.TTimeZoneBias): Chrono.TTimeZone; inline;
      class operator Subtract(const L, R: TTimeZone): Chrono.TMinutes; inline;
    end;
  {$endregion}

  {$region 'Helpers'}
    // The helpers exist for purely technical reasons: Delphi does not allow
    // forward declarations of record types, yet types such as TQuarter/TMonth/TYear
    // need methods (First/Last/Dates/Sequence) that return TDate — a type declared
    // LATER in this file. Moving those methods into record helpers breaks the
    // circular dependency without reordering the declarations.

    TDatePartHelper = record helper for TDatePart
    public
      function GetName: string; inline;
      function GetShortName: string; inline;
    end;

    TTimePartHelper = record helper for TTimePart
    public
      function GetName: string; inline;
      function GetShortName: string; inline;
    end;

    TDurationHelper = record helper for TDuration
    public
      /// <summary>The exact physical difference B - A between two points in time.</summary>
      class function Between(const A, B: Chrono.TDateTime): TDuration; static;
    end;

    TPeriodHelper = record helper for TPeriod
    public
      /// <summary>
      ///  The calendar difference B - A between two dates as "years, months, days".
      ///  Example: from 2024-01-31 to 2024-03-01 it is "0 years, 1 month, 1 day".
      ///  If B is earlier than A, all three components are negative.
      /// </summary>
      class function Between(const A, B: Chrono.TDate): TPeriod; static;
    end;

    TQuarterHelper = record helper for TQuarter
    public const
      /// <summary>All 4 quarters — for iteration: <c>for Q in TQuarter.Each do ...</c>.</summary>
      Each: array[1..4] of TQuarter = ((FQuarter: 1), (FQuarter: 2), (FQuarter: 3), (FQuarter: 4));
    public
      /// <summary>First month of this quarter (Q1 -> January, Q2 -> April, ...).</summary>
      function  First: TMonth; inline;
      /// <summary>Last month of this quarter (Q1 -> March, Q2 -> June, ...).</summary>
      function  Last: TMonth; inline;
      /// <summary>All dates of this quarter in the given year.</summary>
      function  Dates(const Year: TYear): Chrono.TDate.TSequence; inline;
      function  Months: TMonth.TSequence; inline;
    end;

    TQuarterSequenceHelper = record helper for TQuarter.TSequence
    public
      function  First: TQuarter; inline;
      function  Last: TQuarter; inline;
      function  Months: TMonth.TSequence; inline;
    end;

    TQuarterOfYearHelper = record helper for TQuarterOfYear
    public
      function  First: TMonthOfYear; inline;
      function  Last: TMonthOfYear; inline;
      function  Dates: Chrono.TDate.TSequence; inline;
      function  Months: TMonthOfYear.TSequence; inline;
    end;

    TMonthHelper = record helper for TMonth
    public const
      Each: array[1..12] of TMonth = ((FMonth: 1), (FMonth: 2), (FMonth: 3), (FMonth: 4), (FMonth: 5), (FMonth: 6), (FMonth: 7), (FMonth: 8), (FMonth: 9), (FMonth: 10), (FMonth: 11), (FMonth: 12));
    public
      function  First(const Year: TYear): Chrono.TDate; inline;
      function  Last(const Year: TYear): Chrono.TDate; inline;
      function  Sequence(const Year: TYear): Chrono.TDate.TSequence; inline;
    end;

    TMonthOfYearHelper = record helper for TMonthOfYear
    public
      function  First: Chrono.TDate; inline;
      function  Last: Chrono.TDate; inline;
      function  Dates: Chrono.TDate.TSequence; inline;
    end;

    TYearHelper = record helper for TYear
    public
      function  First: Chrono.TDate; inline;
      function  Last: Chrono.TDate; inline;
      function  Dates: Chrono.TDate.TSequence; inline;
    end;

    TDateSequenceHelper = record helper for Chrono.TDate.TSequence
    private
      function  GetFirst: Chrono.TDate; inline;
      function  GetLast: Chrono.TDate; inline;
    public
      property  First: Chrono.TDate read GetFirst;
      property  Last: Chrono.TDate read GetLast;
    end;

    TDateHelper = record helper for Chrono.TDate
    public const
      Zero: Chrono.TDate = (FDate: 0);
    end;

    TTimeHelper = record helper for Chrono.TTime
    public const
      Zero: Chrono.TTime = (FTime: 0);
    end;

    TDateTimeHelper = record helper for Chrono.TDateTime
    public const
      Zero: Chrono.TDateTime = (FDate: (FDate: 0); FTime: (FTime: 0));
    end;

  {$endregion}

  {$region 'Calendar'}
    /// <summary>
    ///  A provider of calendar information: working day, weekend or holiday.
    ///  Implement this interface to plug in your own business calendar
    ///  (for example, one that knows regional holidays and moved working days).
    /// </summary>
    ICalendarProvider = interface
      ['{12C1FBB9-A4DC-439B-B39F-5ACB6B3210F6}']
      function IsWorkDay(const Date: Chrono.TDate): Boolean;
      function IsWeekEnd(const Date: Chrono.TDate): Boolean;
      function IsHoliday(const Date: Chrono.TDate): Boolean;
    end;

    /// <summary>
    ///  The basic "default" calendar: weekends are Saturday and Sunday
    ///  (see IsWeekEnd); holidays and explicit working-day overrides are kept in
    ///  internal dictionaries and set through Holiday[] / WorkDay[].
    /// </summary>
    /// <remarks>
    ///  IsWorkDay first checks for an explicit override in WorkDays (e.g. a
    ///  "working Saturday"), and only if there is none falls back to the rule
    ///  "not a weekend and not a holiday". The order matters: an explicit
    ///  override takes precedence over both automatic checks.
    /// </remarks>
    TBasicCalendar = class(TInterfacedObject, ICalendarProvider)
    private
      FHolidays: TDictionary<Integer, Boolean>;
      FWorkDays: TDictionary<Integer, Boolean>;
      function  GetHoliday(const Date: Chrono.TDate): Boolean;
      procedure SetHoliday(const Date: Chrono.TDate; const Value: Boolean);
      function  GetWorkDay(const Date: Chrono.TDate): Boolean;
      procedure SetWorkDay(const Date: Chrono.TDate; const Value: Boolean);
    protected
      property  Holidays: TDictionary<Integer, Boolean> read FHolidays;
      property  WorkDays: TDictionary<Integer, Boolean> read FWorkDays;
    public
      constructor Create;
      destructor Destroy; override;
      function  IsWorkDay(const Date: Chrono.TDate): Boolean; virtual;
      function  IsWeekEnd(const Date: Chrono.TDate): Boolean; virtual;
      function  IsHoliday(const Date: Chrono.TDate): Boolean; virtual;
      property  Holiday[const Date: Chrono.TDate]: Boolean read GetHoliday write SetHoliday;
      /// <summary>Explicit working/non-working override for a specific date (takes precedence over the automatic IsWorkDay logic).</summary>
      property  WorkDay[const Date: Chrono.TDate]: Boolean read GetWorkDay write SetWorkDay;
    end;
  {$endregion}

  // Predefined constants for fast calculations
  {$include Chrono.FastCalc.inc}
  {$include Chrono.Leap.inc}
  {$include Chrono.DateYMD.inc} //predefined for dates from 1970 to 2100 years
  {$include Chrono.YMDDate.inc} //predefined for dates from 1970 to 2100 years

  public class var
    /// <summary>
    ///  The default first day of the week for methods without an explicit parameter
    ///  (StartOfWeek, EndOfWeek, WeekDays, Weekday, Day). Set to Sunday in the
    ///  unit's initialization section and then (on Windows only) refined from
    ///  the OS locale settings. You may assign it at any time.
    /// </summary>
    /// <remarks>
    ///  IMPORTANT: do not rely on the zero default of this field — without
    ///  explicit initialization FDay=0 is outside TWeekdayNum (1..7) and would
    ///  index past the internal WeekdaysArray/DaysOfWeekArray tables. The unit's
    ///  initialization section always sets it — see below.
    /// </remarks>
    FirstDayOfWeek: Chrono.TWeekday;

  public
    class function Today: Chrono.TDate; inline; static;
    class function Date: Chrono.TDate; inline; static;
    class function Time: Chrono.TTime; inline; static;
    class function Now: Chrono.TDateTime; inline; static;
    class function Weekday(const Day: TWeekdayNum; const FirstDayOfWeek: TWeekday): TWeekday; overload; static;
    class function Weekday(const Day: TWeekdayNum): TWeekday; overload; static;
end;

  TChronoDate = Chrono.TDate;

const
  MSecsPerHour = MinsPerHour * SecsPerMin * MSecsPerSec;
  MSecsPerMinute = SecsPerMin * MSecsPerSec;

  S24: array[0..24] of string = (
    '00', '01', '02', '03', '04', '05', '06', '07', '08', '09',
    '10', '11', '12', '13', '14', '15', '16', '17', '18', '19',
    '20', '21', '22', '23', '24'
  );

  S60: array[0..60] of string = (
    '00', '01', '02', '03', '04', '05', '06', '07', '08', '09',
    '10', '11', '12', '13', '14', '15', '16', '17', '18', '19',
    '20', '21', '22', '23', '24', '25', '26', '27', '28', '29',
    '30', '31', '32', '33', '34', '35', '36', '37', '38', '39',
    '40', '41', '42', '43', '44', '45', '46', '47', '48', '49',
    '50', '51', '52', '53', '54', '55', '56', '57', '58', '59',
    '60'
  );

  MIMEWeekdays: array[1..7] of string = ('Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat');
  MIMEMonths:   array[1..12] of string = ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');

  ISO8601DateFormatSettings: TFormatSettings = (
    DateSeparator: '-';
    TimeSeparator: ':';
    ShortDateFormat: 'YYYY-MM-DD';
    LongDateFormat: 'YYYY-MM-DD';
    ShortTimeFormat: 'HH:NN:SS';
    LongTimeFormat: 'HH:NN:SS.ZZZ';
    ThousandSeparator: #0;
    DecimalSeparator: '.'
  );

/// <summary>The default calendar: a TBasicCalendar until replaced via SetDefaultCalendar.</summary>
function DefaultCalendar: Chrono.ICalendarProvider;
/// <summary>Replaces the default calendar; nil restores a fresh TBasicCalendar.</summary>
procedure SetDefaultCalendar(const Value: Chrono.ICalendarProvider);

const
  FMSecsPerDay: Single  = MSecsPerDay;
  IMSecsPerDay: Integer = MSecsPerDay;

procedure Localize;

type
  TLocalizeState = (Idle = 0, Initializing = 1, Done = 2);

var
  gLocalizeState: Integer = Ord(TLocalizeState.Idle);
  gLocalizedDatePart:      array[Chrono.TDatePart] of string;
  gLocalizedDatePartShort: array[Chrono.TDatePart] of string;
  gLocalizedTimePart:      array[Chrono.TTimePart] of string;
  gLocalizedTimePartShort: array[Chrono.TTimePart] of string;

resourcestring
  SInvalidTimeZone = 'Invalid time zone "%s"';
  SInvalidQuarter  = 'Invalid quarter format "%s"';

resourcestring
  SYear_ru         = 'Год';
  SQuarter_ru      = 'Квартал';
  SMonth_ru        = 'Месяц';
  SWeek_ru         = 'Неделя';
  SDay_ru          = 'День';
  SHour_ru         = 'Час';
  SMinute_ru       = 'Минут';
  SSecond_ru       = 'Секунд';
  SMillis_ru       = 'Миллисекунд';
  SMicros_ru       = 'Микросекунд';
  SNanos_ru        = 'Наносекунд';
  SYearShort_ru    = 'г';
  SQuarterShort_ru = 'кв';
  SMonthShort_ru   = 'мес';
  SWeekShort_ru    = 'нед';
  SDayShort_ru     = 'д';
  SHourShort_ru    = 'ч';
  SMinuteShort_ru  = 'м';
  SSecondShort_ru  = 'с';
  SMillisShort_ru  = 'мс';
  SMicrosShort_ru  = 'мкс';
  SNanosShort_ru   = 'нс';

  SYear            = 'Year';
  SQuarter         = 'Quarter';
  SMonth           = 'Month';
  SWeek            = 'Week';
  SDay             = 'Day';
  SHour            = 'Hour';
  SMinute          = 'Minute';
  SSecond          = 'Second';
  SMillis          = 'Milliseconds';
  SMicros          = 'Microseconds';
  SNanos           = 'Nanoseconds';
  SYearShort       = 'y';
  SQuarterShort    = 'q';
  SMonthShort      = 'm';
  SWeekShort       = 'w';
  SDayShort        = 'd';
  SHourShort       = 'h';
  SMinuteShort     = 'm';
  SSecondShort     = 's';
  SMillisShort     = 'ms';
  SMicrosShort     = 'mcs';
  SNanosShort      = 'ns';

implementation

uses
  System.SysConst, System.Math, System.Classes, System.SyncObjs;

var
  gDefaultCalendar: Chrono.ICalendarProvider;

function DefaultCalendar: Chrono.ICalendarProvider;
begin
  Result := gDefaultCalendar;
end;

procedure SetDefaultCalendar(const Value: Chrono.ICalendarProvider);
begin
  if Value = nil then
    gDefaultCalendar := Chrono.TBasicCalendar.Create
  else
    gDefaultCalendar := Value;
end;

class function Chrono.Today: Chrono.TDate;
begin
  Result := Chrono.TDate.Today;
end;

class function Chrono.Date: Chrono.TDate;
begin
  Result := Chrono.TDate.Today;
end;

class function Chrono.Time: Chrono.TTime;
begin
  Result := TTime.Now;
end;

class function Chrono.Now: Chrono.TDateTime;
begin
  Result := Chrono.TDateTime.Now;
end;

class function Chrono.Weekday(const Day: Chrono.TWeekdayNum; const FirstDayOfWeek: Chrono.TWeekday): Chrono.TWeekday;
begin
  Result := TWeekday(WeekdaysArray[Word(FirstDayOfWeek), Day]);
end;

class function Chrono.Weekday(const Day: TWeekdayNum): TWeekday;
begin
  Result := TWeekday(WeekdaysArray[Word(FirstDayOfWeek), Day]);
end;

{ Chrono.TDuration }

class function Chrono.TDuration.FromMilliseconds(const Value: Int64): TDuration;
begin
  Result.FMilliseconds := Value;
end;

class function Chrono.TDuration.FromSeconds(const Value: Int64): TDuration;
begin
  Result.FMilliseconds := Value * MSecsPerSec;
end;

class function Chrono.TDuration.FromMinutes(const Value: Int64): TDuration;
begin
  Result.FMilliseconds := Value * MSecsPerMinute;
end;

class function Chrono.TDuration.FromHours(const Value: Int64): TDuration;
begin
  Result.FMilliseconds := Value * MSecsPerHour;
end;

class function Chrono.TDuration.FromDays(const Value: Int64): TDuration;
begin
  Result.FMilliseconds := Value * Int64(IMSecsPerDay);
end;

class function Chrono.TDuration.Zero: TDuration;
begin
  Result.FMilliseconds := 0;
end;

class function Chrono.TDurationHelper.Between(const A, B: Chrono.TDateTime): TDuration;
var
  DaysDiff: Integer;
  MSecDiff: Int64;
begin
  // The date difference (whole days) is converted to milliseconds and added to
  // the time-of-day difference (also in milliseconds) — this handles crossing
  // midnight correctly without losing precision through System.TDateTime (Double).
  DaysDiff := Integer(B.Date) - Integer(A.Date);
  MSecDiff := Integer(B.Time) - Integer(A.Time);
  Result.FMilliseconds := Int64(DaysDiff) * IMSecsPerDay + MSecDiff;
end;

function Chrono.TDuration.TotalMilliseconds: Int64;
begin
  Result := FMilliseconds;
end;

function Chrono.TDuration.TotalSeconds: Double;
begin
  Result := FMilliseconds / MSecsPerSec;
end;

function Chrono.TDuration.TotalMinutes: Double;
begin
  Result := FMilliseconds / MSecsPerMinute;
end;

function Chrono.TDuration.TotalHours: Double;
begin
  Result := FMilliseconds / MSecsPerHour;
end;

function Chrono.TDuration.TotalDays: Double;
begin
  Result := FMilliseconds / IMSecsPerDay;
end;

function Chrono.TDuration.GetDays: TDays;
begin
  Result := System.Abs(FMilliseconds div IMSecsPerDay);
end;

function Chrono.TDuration.GetHours: THours;
begin
  Result := System.Abs((FMilliseconds mod IMSecsPerDay) div MSecsPerHour);
end;

function Chrono.TDuration.GetMinutes: TMinutes;
begin
  Result := System.Abs((FMilliseconds mod MSecsPerHour) div MSecsPerMinute);
end;

function Chrono.TDuration.GetSeconds: TSeconds;
begin
  Result := System.Abs((FMilliseconds mod MSecsPerMinute) div MSecsPerSec);
end;

function Chrono.TDuration.GetMilliseconds: TMilliseconds;
begin
  Result := System.Abs(FMilliseconds mod MSecsPerSec);
end;

function Chrono.TDuration.IsZero: Boolean;
begin
  Result := FMilliseconds = 0;
end;

function Chrono.TDuration.IsNegative: Boolean;
begin
  Result := FMilliseconds < 0;
end;

function Chrono.TDuration.Negate: TDuration;
begin
  Result.FMilliseconds := -FMilliseconds;
end;

function Chrono.TDuration.Abs: TDuration;
begin
  Result.FMilliseconds := System.Abs(FMilliseconds);
end;

function Chrono.TDuration.ToString: string;
begin
  if Days <> 0 then
    Result := Format('%d %.2d:%.2d:%.2d.%.3d', [Days, Hours, Minutes, Seconds, Milliseconds])
  else
    Result := Format('%.2d:%.2d:%.2d.%.3d', [Hours, Minutes, Seconds, Milliseconds]);

  if IsNegative then
    Result := '-' + Result;
end;

class operator Chrono.TDuration.Add(const A, B: TDuration): TDuration;
begin
  Result.FMilliseconds := A.FMilliseconds + B.FMilliseconds;
end;

class operator Chrono.TDuration.Subtract(const A, B: TDuration): TDuration;
begin
  Result.FMilliseconds := A.FMilliseconds - B.FMilliseconds;
end;

class operator Chrono.TDuration.Multiply(const A: TDuration; const B: Double): TDuration;
begin
  Result.FMilliseconds := Round(A.FMilliseconds * B);
end;

class operator Chrono.TDuration.IntDivide(const A: TDuration; const B: Int64): TDuration;
begin
  Result.FMilliseconds := A.FMilliseconds div B;
end;

class operator Chrono.TDuration.Negative(const A: TDuration): TDuration;
begin
  Result.FMilliseconds := -A.FMilliseconds;
end;

class operator Chrono.TDuration.Equal(const A, B: TDuration): Boolean;
begin
  Result := A.FMilliseconds = B.FMilliseconds;
end;

class operator Chrono.TDuration.NotEqual(const A, B: TDuration): Boolean;
begin
  Result := A.FMilliseconds <> B.FMilliseconds;
end;

class operator Chrono.TDuration.GreaterThan(const A, B: TDuration): Boolean;
begin
  Result := A.FMilliseconds > B.FMilliseconds;
end;

class operator Chrono.TDuration.GreaterThanOrEqual(const A, B: TDuration): Boolean;
begin
  Result := A.FMilliseconds >= B.FMilliseconds;
end;

class operator Chrono.TDuration.LessThan(const A, B: TDuration): Boolean;
begin
  Result := A.FMilliseconds < B.FMilliseconds;
end;

class operator Chrono.TDuration.LessThanOrEqual(const A, B: TDuration): Boolean;
begin
  Result := A.FMilliseconds <= B.FMilliseconds;
end;

{ Chrono.TPeriod }

class function Chrono.TPeriod.Create(const Years: TYears; Months: TMonths; Days: TDays): TPeriod;
begin
  Result.FYears := Years;
  Result.FMonths := Months;
  Result.FDays := Days;
end;

class function Chrono.TPeriod.FromYears(const Value: TYears): TPeriod;
begin
  Result := Create(Value, 0, 0);
end;

class function Chrono.TPeriod.FromMonths(const Value: TMonths): TPeriod;
begin
  Result := Create(0, Value, 0);
end;

class function Chrono.TPeriod.FromDays(const Value: TDays): TPeriod;
begin
  Result := Create(0, 0, Value);
end;

class function Chrono.TPeriod.Zero: TPeriod;
begin
  Result := Create(0, 0, 0);
end;

class function Chrono.TPeriodHelper.Between(const A, B: Chrono.TDate): TPeriod;
var
  Sign: Integer;
  Lo, Hi: Chrono.TDate;
  Y, M: Integer;
  CalcDate: Chrono.TDate;
  Days: Integer;
begin
  if A <= B then
  begin
    Lo := A; Hi := B; Sign := 1;
  end
  else
  begin
    Lo := B; Hi := A; Sign := -1;
  end;

  Y := Integer(Hi.Year) - Integer(Lo.Year);
  M := Integer(Hi.Month) - Integer(Lo.Month);

  // Preliminary month count including Y, without the day-of-month correction:
  var TotalMonths := Y * 12 + M;

  // Add TotalMonths months to Lo and check whether we overshot Hi
  CalcDate := Lo + Chrono.TPeriod.Create(0, TotalMonths, 0);
  if CalcDate > Hi then
  begin
    Dec(TotalMonths);
    CalcDate := Lo + Chrono.TPeriod.Create(0, TotalMonths, 0);
  end;

  Days := Hi - CalcDate; // whole days of the date stamp — exact, no heuristics

  Result.FYears := Sign * (TotalMonths div 12);
  Result.FMonths := Sign * (TotalMonths mod 12);
  Result.FDays := Sign * Days;
end;

function Chrono.TPeriod.IsZero: Boolean;
begin
  Result := (FYears = 0) and (FMonths = 0) and (FDays = 0);
end;

function Chrono.TPeriod.Negate: TPeriod;
begin
  Result.FYears := -FYears;
  Result.FMonths := -FMonths;
  Result.FDays := -FDays;
end;

function Chrono.TPeriod.ToString: string;
begin
  Result := '';
  if FYears <> 0 then
    Result := Result + Format('%d' + TDatePart.Year.GetShortName + ' ', [FYears]);
  if FMonths <> 0 then
    Result := Result + Format('%d' + TDatePart.Month.GetShortName + ' ', [FMonths]);
  if (FDays <> 0) or (Result = '') then
    Result := Result + Format('%d' + TDatePart.Day.GetShortName, [FDays]);
  Result := Trim(Result);
end;

class operator Chrono.TPeriod.Add(const A, B: TPeriod): TPeriod;
begin
  Result.FYears := A.FYears + B.FYears;
  Result.FMonths := A.FMonths + B.FMonths;
  Result.FDays := A.FDays + B.FDays;
end;

class operator Chrono.TPeriod.Subtract(const A, B: TPeriod): TPeriod;
begin
  Result.FYears := A.FYears - B.FYears;
  Result.FMonths := A.FMonths - B.FMonths;
  Result.FDays := A.FDays - B.FDays;
end;

class operator Chrono.TPeriod.Negative(const A: TPeriod): TPeriod;
begin
  Result := A.Negate;
end;

class operator Chrono.TPeriod.Equal(const A, B: TPeriod): Boolean;
begin
  Result := (A.FYears = B.FYears) and (A.FMonths = B.FMonths) and (A.FDays = B.FDays);
end;

class operator Chrono.TPeriod.NotEqual(const A, B: TPeriod): Boolean;
begin
  Result := (A.FYears <> B.FYears) or (A.FMonths <> B.FMonths) or (A.FDays <> B.FDays);
end;

{ Chrono.TTimeZone }

class constructor Chrono.TTimeZone.Create;
begin
  Timezones := TDictionary<string, TTimeZoneBias>.Create;
  Register('UT',   0);
  Register('UTC',  0);
  Register('GMT',  0);
  Register('Z',    0);
  // Military zones (RFC 5322): A..M are east of UTC, N..Y are west (J is not used).
  // Bias counts minutes west of UTC, hence the inverted signs.
  Register('A',   -1 * 60);
  Register('B',   -2 * 60);
  Register('C',   -3 * 60);
  Register('D',   -4 * 60);
  Register('E',   -5 * 60);
  Register('F',   -6 * 60);
  Register('G',   -7 * 60);
  Register('H',   -8 * 60);
  Register('I',   -9 * 60);
  Register('K',   -10 * 60);
  Register('L',   -11 * 60);
  Register('M',   -12 * 60);
  Register('N',    1 * 60);
  Register('O',    2 * 60);
  Register('P',    3 * 60);
  Register('Q',    4 * 60);
  Register('R',    5 * 60);
  Register('S',    6 * 60);
  Register('T',    7 * 60);
  Register('U',    8 * 60);
  Register('V',    9 * 60);
  Register('W',    10 * 60);
  Register('X',    11 * 60);
  Register('Y',    12 * 60);
end;

class destructor Chrono.TTimeZone.Destroy;
begin
  FreeAndNil(Timezones);
end;

class procedure Chrono.TTimeZone.Register(const Code: string; Bias: TTimeZoneBias);
begin
  Timezones.AddOrSetValue(Code, Bias);
end;

class function Chrono.TTimeZone.System: TTimeZone;
{$IFDEF MSWINDOWS}
var
  Info: TTimeZoneInformation;
begin
  case GetTimeZoneInformation(Info) of
    TIME_ZONE_ID_DAYLIGHT:
      Result.Bias := Info.Bias + Info.DaylightBias;
    TIME_ZONE_ID_UNKNOWN, TIME_ZONE_ID_STANDARD:
      Result.Bias := Info.Bias;
    else
      Result.Bias := 0;
  end;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  T: time_t;
  UT: tm;
begin
  // tm_gmtoff is seconds east of UTC, Bias is minutes west of it.
  __time(T);
  localtime_r(T, UT);
  Result.Bias := -(UT.tm_gmtoff div 60);
end;
{$ENDIF POSIX}

function Chrono.TTimeZone.GetMIME: string;
begin
  // See the note on the inverted sign of Bias above: Bias > 0 means "west of
  // UTC", which the MIME format shows with a MINUS sign, not a plus.
  if Bias > 0 then
    Result := '-' + S60[Bias div 60] + S60[Bias mod 60]
  else
    Result := '+' + S60[Abs(Bias) div 60] + S60[Abs(Bias) mod 60];
end;

class operator Chrono.TTimeZone.Explicit(const A: TTimeZone): string;
begin
  if A.Bias > 0 then
    Result := '-' + S60[A.Bias div 60] + ':' + S60[A.Bias mod 60]
  else
    // Abs() is required here: for a negative Bias (zones east of UTC)
    // Bias div 60 and Bias mod 60 are negative (truncation towards zero),
    // while S60 is indexed 0..60. Without Abs the index would be out of bounds.
    Result := '+' + S60[Abs(A.Bias) div 60] + ':' + S60[Abs(A.Bias) mod 60];
end;

class operator Chrono.TTimeZone.Explicit(const A: string): TTimeZone;
begin
  // Parses three positional formats: "+HH" (3 chars), "+HHMM" (5 chars) and
  // "+HH:MM" (6 chars, colon checked at position 4). If the string matches none
  // of them by length/content, we fall through to the named-zone lookup
  // (Timezones.TryGetValue) and raise EConvertError if the name is not found
  // there either. Note: a length matching no case branch (e.g. 4) goes STRAIGHT
  // to the dictionary lookup without an intermediate raise — this is
  // intentional, not a forgotten case. An empty string means UTC.
  case Length(A) of
    0:
      Exit(TTimeZone(0));
    3: //+HH
      case A[1] of
        '+': Exit(TTimeZone(-(SNum(A, 2) * 60)));
        '-': Exit(TTimeZone(+(SNum(A, 2) * 60)));
      end;
    5: //+HHMM
      case A[1] of
        '+': Exit(TTimeZone(-(SNum(A, 2) * 60 + SNum(A, 4))));
        '-': Exit(TTimeZone(+(SNum(A, 2) * 60 + SNum(A, 4))));
      end;
    6: //+HH:MM
      if A[4] = ':' then
        case A[1] of
          '+': Exit(TTimeZone(-(SNum(A, 2) * 60 + SNum(A, 5))));
          '-': Exit(TTimeZone(+(SNum(A, 2) * 60 + SNum(A, 5))));
        end;
  end;

  if not Timezones.TryGetValue(A, Result.FBias) then
    raise EConvertError.CreateResFmt(@SInvalidTimeZone, [A]);
end;

class operator Chrono.TTimeZone.Explicit(const A: TTimeZone): Chrono.TTime;
begin
  Result.Encode(A.Bias div 60, A.Bias mod 60, 0);
end;

class operator Chrono.TTimeZone.Explicit(const A: Chrono.TTime): TTimeZone;
var
  H, M, S: Word;
begin
  A.Decode(H, M, S);
  Result.FBias := H * 60 + M;
end;

class operator Chrono.TTimeZone.Explicit(const A: Chrono.TTimeZone): TTimeZoneBias;
begin
  Result := A.Bias;
end;

class operator Chrono.TTimeZone.Explicit(const A: TTimeZoneBias): Chrono.TTimeZone;
begin
  Result.Bias := A;
end;

class function Chrono.TTimeZone.SNum(const S: string; const Index: Integer): Integer;
begin
  Result := (Ord(S[Index]) - Ord('0')) * 10 + (Ord(S[Index + 1]) - Ord('0'));
end;

class operator Chrono.TTimeZone.Subtract(const L, R: Chrono.TTimeZone): TMinutes;
begin
  Result := L.Bias - R.Bias;
end;

{$region 'Date routine'}

{ Date }

constructor Chrono.TDate.Create(const Date: Chrono.TDate);
begin
  FDate := Date.FDate;
end;

constructor Chrono.TDate.Create(const Date: System.TDateTime);
begin
  FDate := Trunc(Date) + DateDelta;
end;

constructor Chrono.TDate.Create(const Year: TYear; const Month: TMonth; const Day: TDay);
begin
  Encode(Year, Month, Day);
end;

constructor Chrono.TDate.Create(const Year, Month, Day: Word);
begin
  Encode(Year, Month, Day);
end;

class operator Chrono.TDate.Implicit(const a: System.TDateTime): Chrono.TDate;
begin
  Result.FDate := Trunc(a) + DateDelta;
end;

class operator Chrono.TDate.Implicit(const a: Chrono.TDate): System.TDateTime;
begin
  Result := a.FDate - DateDelta;
end;

class operator Chrono.TDate.Explicit(const a: Integer): Chrono.TDate;
begin
  Result.FDate := a;
end;

class operator Chrono.TDate.Explicit(const a: Chrono.TDate): Integer;
begin
  Result := a.FDate;
end;

class operator Chrono.TDate.Explicit(const a: Chrono.TDate): string;
begin
  Result := a.ToString;
end;

class operator Chrono.TDate.Explicit(const a: string): Chrono.TDate;
begin
  Result.Parse(a);
end;

class operator Chrono.TDate.Add(const a: Chrono.TDate; const b: Integer): Chrono.TDate;
begin
  Result.FDate := a.FDate + b;
end;

class operator Chrono.TDate.Subtract(const a, b: Chrono.TDate): Integer;
begin
  Result := a.FDate - b.FDate;
end;

class operator Chrono.TDate.Subtract(const a: Chrono.TDate; const b: Integer): Chrono.TDate;
begin
  Result.FDate := a.FDate - b;
end;

class operator Chrono.TDate.Implicit(const a: TTimeStamp): Chrono.TDate;
begin
  Result.FDate := a.Date;
end;

class operator Chrono.TDate.Implicit(const a: Chrono.TDate): TTimeStamp;
begin
  Result.Time := 0;
  Result.Date := a.FDate;
end;

class operator Chrono.TDate.Implicit(const a: Variant): Chrono.TDate;
begin
  Result.FDate := Trunc(VarToDateTime(a)) + DateDelta;
end;

class operator Chrono.TDate.Implicit(const a: Chrono.TDate): Variant;
begin
  // Writing TVarData directly instead of going through the standard Variant
  // conversion is an optimization that avoids an intermediate copy/rounding.
  // Result is a fresh (unassigned) Variant here, so nothing needs to be cleared.

  TVarData(Result).VType := varDate;
  TVarData(Result).VDate := a.FDate - DateDelta;
end;

class operator Chrono.TDate.Inc(const a: Chrono.TDate): Chrono.TDate;
begin
  Result.FDate := a.FDate + 1;
end;

class operator Chrono.TDate.Dec(const a: Chrono.TDate): Chrono.TDate;
begin
  Result.FDate := a.FDate - 1;
end;

class operator Chrono.TDate.Equal(const a, b: Chrono.TDate): Boolean;
begin
  Result := a.FDate = b.FDate;
end;

class operator Chrono.TDate.NotEqual(const a, b: Chrono.TDate): Boolean;
begin
  Result := a.FDate <> b.FDate;
end;

class operator Chrono.TDate.GreaterThan(const a, b: Chrono.TDate): Boolean;
begin
  Result := a.FDate > b.FDate;
end;

class operator Chrono.TDate.GreaterThanOrEqual(const a, b: Chrono.TDate): Boolean;
begin
  Result := a.FDate >= b.FDate;
end;

class operator Chrono.TDate.LessThan(const a, b: Chrono.TDate): Boolean;
begin
  Result := a.FDate < b.FDate;
end;

class operator Chrono.TDate.LessThanOrEqual(const a, b: Chrono.TDate): Boolean;
begin
  Result := a.FDate <= b.FDate;
end;

class operator Chrono.TDate.Add(const a: Chrono.TDate; const b: Chrono.TPeriod): Chrono.TDate;
var
  TotalMonths, NewYear, NewMonth: Integer;
  Y: TYear;
  M: TMonth;
  D: TDay;
begin
  a.Decode(Y, M, D);

  // Normalize year+month into a single linear month index, add B.Months,
  // then split back into (year, month) carrying over 12.
  TotalMonths := Integer(Y) * 12 + (Integer(M) - 1) + b.Months;
  NewYear := TotalMonths div 12;
  NewMonth := TotalMonths mod 12;
  if NewMonth < 0 then
  begin
    Inc(NewMonth, 12);
    Dec(NewYear);
  end;
  Inc(NewMonth); // back to the 1..12 range

  Y := NewYear + b.Years; // NewYear already includes the month carry; now add the period's years

  // Clamp the day if the new month is shorter (same as SetMonth)
  var MaxDay := TMonth(Word(NewMonth)).Days(Y);
  if Integer(D) > MaxDay then
    D := MaxDay;

  Result.Encode(Y, NewMonth, Word(D));
  Result.FDate := Result.FDate + B.Days;
end;

class operator Chrono.TDate.Subtract(const A: Chrono.TDate; const B: Chrono.TPeriod): Chrono.TDate;
begin
  Result := A + B.Negate;
end;

class function Chrono.TDate.Range(const First, Last: Chrono.TDate): TArray<Chrono.TDate>;
var
  D, I: Integer;
begin
  SetLength(Result, Last - First + 1);
  I := 0;
  for D := Integer(First) to Integer(Last) do
  begin
    Result[I].FDate := D;
    Inc(I);
  end;
end;

class function Chrono.TDate.Sequence(const First, Last: Chrono.TDate): TSequence;
begin
  Result := TSequence.Create(First, Last);
end;

class function Chrono.TDate.Today: Chrono.TDate;
{$IFDEF MSWINDOWS}
var
  SystemTime: TSystemTime;
begin
  GetLocalTime(SystemTime);
  Result.Encode(SystemTime.wYear, SystemTime.wMonth, SystemTime.wDay);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  T: time_t;
  UT: tm;
begin
  __time(T);
  localtime_r(T, UT);
  Result.Encode(UT.tm_year + 1900, UT.tm_mon + 1, UT.tm_mday);
end;
{$ENDIF POSIX}

function Chrono.TDate.GetISO: string;
begin
  Result := ToString(ISO8601DateFormatSettings);
end;

procedure Chrono.TDate.SetISO(const Value: string);
begin
  Parse(Value, ISO8601DateFormatSettings);
end;

procedure Chrono.TDate.Decode(var Year, Month, Day: Word);
const
  D1 = 365;
  D4 = D1 * 4 + 1;    // days in a 4-year cycle with one leap year
  D100 = D4 * 25 - 1; // days in a 100-year cycle (minus 1: a year divisible by 100 is not leap)
  D400 = D100 * 4 + 1;// days in a 400-year cycle (plus 1: a year divisible by 400 is leap)
var
  I: Word;
  T: Integer;
begin
  // Special case: FDate = 0 is not a real date in this numbering
  // (see Encode: 0001-01-01 => FDate = 1). 0 is the value of an uninitialized
  // TDate (default(TDate), TDate.Zero). It is treated as "the day before the
  // era" and decoded as December 31 of year 0 (proleptically).
  // NOTE: this is NOT System.TDateTime(0), which is 1899-12-30 — do not mix up
  // the "zero" dates of the two systems when converting.
  if FDate = 0 then
  begin
    Year := 0;
    Month := 12;
    Day := 31;
    Exit;
  end;

  // Fast path: for 1970..2100 use the precomputed DateYMD table
  // (Chrono.DateYMD.inc) instead of arithmetic — a single array lookup.
  if (FDate >= Low(DateYMD)) and (FDate <= High(DateYMD)) then
  begin
    Year := DateYMD[FDate].Y;
    Month := DateYMD[FDate].M;
    Day := DateYMD[FDate].D;
    Exit;
  end;

  // Otherwise split the linear day number into (year, day-of-year) by dividing
  // successively by the 400-, 100-, 4- and 1-year cycles, correcting the "extra"
  // 4th sub-cycle (the edge case on the last day of a 400-year or 4-year cycle,
  // when DivMod returns I=4 instead of the expected 0..3).

  T := FDate - 1;

  Year := (T div D400) * 400 + 1;
  T := T mod D400;

  DivMod(T, D100, I, Day);
  if I = 4 then
  begin
    Dec(I);
    Inc(Day, D100);
  end;
  Inc(Year, I * 100);
  DivMod(Day, D4, I, Day);
  Inc(Year, I * 4);
  DivMod(Day, D1, I, Day);
  if I = 4 then
  begin
    Dec(I);
    Inc(Day, D1);
  end;
  Inc(Year, I);
  Month := MonthOfDay[YearIsLeap[Year], Day + 1];
  Day := MonthDayOfDay[YearIsLeap[Year], Day + 1];
end;

procedure Chrono.TDate.Decode(var Year, Month: Word);
var
  D: Word;
begin
  Decode(Year, Month, D);
end;

procedure Chrono.TDate.Decode(var Year: Word);
var
  M, D: Word;
begin
  Decode(Year, M, D);
end;

procedure Chrono.TDate.Decode(var Year: TYear; var Month: TMonth; var Day: TDay);
begin
  Decode(Year.FYear, Month.FMonth, Day.FDay);
end;

procedure Chrono.TDate.Encode(const Year, Month, Day: Word);
var
  I: Integer;
begin
  if (Year >= Low(YMDDate)) and (Year <= High(YMDDate)) then
  begin
    FDate := YMDDate[Year, Month, Day];
    Exit;
  end;
  I := Year - 1;
  FDate := I * 365 + I div 4 - I div 100 + I div 400 + MonthOffset[TYear(Year).IsLeap, Month] + Day;
end;

procedure Chrono.TDate.Encode(const Year, Month: Word);
var
  I: Integer;
begin
  if (Year >= Low(YMDDate)) and (Year <= High(YMDDate)) then
  begin
    FDate := YMDDate[Year, Month, 1];
    Exit;
  end;
  I := Year - 1;
  FDate := I * 365 + I div 4 - I div 100 + I div 400 + MonthOffset[TYear(Year).IsLeap, Month] + 1;
end;

procedure Chrono.TDate.Encode(const Year: Word);
var
  I: Integer;
begin
  if (Year >= Low(YMDDate)) and (Year <= High(YMDDate)) then
  begin
    FDate := YMDDate[Year, 1, 1];
    Exit;
  end;

  I := Year - 1;
  FDate := I * 365 + I div 4 - I div 100 + I div 400 + 1;
end;

procedure Chrono.TDate.Encode(const Year: TYear; const Month: TMonth; const Day: TDay);
begin
  Encode(Year.FYear, Month.FMonth, Day.FDay);
end;

function Chrono.TDate.GetDay: TDay;
var
  Y, M, D: Word;
begin
  Decode(Y, M, D);
  Result.FDay := D;
end;

function Chrono.TDate.GetDayOfYear: TDayOfYear;
begin
  Result := FDate - Year.First.FDate + 1;
end;

procedure Chrono.TDate.SetDayOfYear(const Value: TDayOfYear);
begin
  FDate := Year.First.FDate + Value - 1;
end;

function Chrono.TDate.GetDayOfMonth: TDayOfMonth;
begin
  Result.FMonth := Month;
  Result.FDay := Day;
end;

procedure Chrono.TDate.SetDay(const Value: TDay);
var
  Y, M, D: Word;
begin
  Decode(Y, M, D);
  Encode(Y, M, Value.FDay);
end;

function Chrono.TDate.GetMonth: TMonth;
var
  Y, M, D: Word;
begin
  Decode(Y, M, D);
  Result.FMonth := M;
end;

procedure Chrono.TDate.SetMonth(const Value: TMonth);
var
  Y: TYear;
  M: TMonth;
  D, L: TDay;
begin
  Decode(Y, M, D);

  if M = Value then
    Exit;

  L := MonthDayCount[Y.IsLeap, Word(Value)];
  if L < D then
    D := L;

  Encode(Y, Value, D);
end;

function Chrono.TDate.GetQuarter: TQuarter;
var
  Y, M, D: Word;
begin
  Decode(Y, M, D);
  Result.FQuarter := MonthQuarter[M];
end;

function Chrono.TDate.GetYear: TYear;
begin
  Decode(Result.FYear);
end;

procedure Chrono.TDate.SetYear(const Value: TYear);
var
  Y: TYear;
  M: TMonth;
  D: TDay;
begin
  Decode(Y, M, D);

  if Y = Value then
    Exit;

  if (M = 2) and (D = 29) and Y.IsLeap then
  begin
    if Value.IsLeap then
      Encode(Value, M, D)
    else
      Encode(Value, M, 28);
  end
  else
    Encode(Value, M, D);
end;

function Chrono.TDate.GetWeekday: TWeekday;
begin
  // The formula relies on 0001-01-01 (FDate=1) being a Monday in the
  // proleptic Gregorian calendar and is fitted to the fixed TWeekday
  // numbering (Sun=1..Sat=7). If DateDelta or the base epoch ever changes,
  // ALWAYS re-verify it with tests on known dates (e.g. 2024-01-01 is a Monday).
  Result.FDay := FDate mod 7 + 1;
end;

procedure Chrono.TDate.SetWeekday(const Value: TWeekday);
begin
  FDate := FDate + Integer(Value - Weekday);
end;

function Chrono.TDate.GetQuarterOfYear: TQuarterOfYear;
var
  Y, M: Word;
begin
  Decode(Y, M);
  Result.FYear := Y;
  Result.FQuarter := MonthQuarter[M];
end;

function Chrono.TDate.GetMonthOfYear: TMonthOfYear;
var
  Y, M: Word;
begin
  Decode(Y, M);
  Result.FYear := Y;
  Result.FMonth := M;
end;

procedure Chrono.TDate.SetMonthOfYear(const Value: TMonthOfYear);
begin
  Year := Value.Year;
  Month := Value.Month;
end;

function Chrono.TDate.StartOfWeek: Chrono.TDate;
begin
  Result := StartOfWeek(FirstDayOfWeek);
end;

function Chrono.TDate.StartOfWeek(const FirstDayOfWeek: TWeekday): Chrono.TDate;
begin
  Result.FDate := FDate - (Weekday.DayOfWeek[FirstDayOfWeek] - 1);
end;

function Chrono.TDate.EndOfWeek: Chrono.TDate;
begin
  Result := EndOfWeek(FirstDayOfWeek);
end;

function Chrono.TDate.EndOfWeek(const FirstDayOfWeek: TWeekday): Chrono.TDate;
begin
  Result.FDate := FDate + (7 - Weekday.DayOfWeek[FirstDayOfWeek]);
end;

function Chrono.TDate.ToString: string;
begin
  Result := DateToStr(FDate - DateDelta);
end;

function Chrono.TDate.ToString(const FormatSettings: TFormatSettings): string;
begin
  Result := DateToStr(FDate - DateDelta, FormatSettings);
end;

function Chrono.TDate.Format(const Format: string): string;
begin
  Result := FormatDateTime(Format, FDate - DateDelta);
end;

function Chrono.TDate.Format(const Format: string; const FormatSettings: TFormatSettings): string;
begin
  Result := FormatDateTime(Format, FDate - DateDelta, FormatSettings);
end;

procedure Chrono.TDate.Parse(const Value: string);
begin
  FDate := Trunc(StrToDate(Value)) + DateDelta;
end;

procedure Chrono.TDate.Parse(const Value: string; const FormatSettings: TFormatSettings);
begin
  FDate := Trunc(StrToDate(Value, FormatSettings)) + DateDelta;
end;

function Chrono.TDate.TryParse(const Value: string): Boolean;
var
  D: System.TDateTime;
begin
  Result := TryStrToDate(Value, D);
  if Result then
    Self := D;
end;

function Chrono.TDate.TryParse(const Value: string; const FormatSettings: TFormatSettings): Boolean;
var
  D: System.TDateTime;
begin
  Result := TryStrToDate(Value, D, FormatSettings);
  if Result then
    Self := D;
end;

function Chrono.TDate.WithYear(const Value: TYear): Chrono.TDate;
begin
  Result := Self;
  Result.Year := Value;
end;

function Chrono.TDate.WithMonth(const Value: TMonth): Chrono.TDate;
begin
  Result := Self;
  Result.Month := Value;
end;

function Chrono.TDate.WithDay(const Value: TDay): Chrono.TDate;
begin
  Result := Self;
  Result.Day := Value;
end;

function Chrono.TDate.NextWeekday(const Day: Chrono.TWeekday): Chrono.TDate;
var
  Delta: Integer;
begin
  Delta := Integer(Day) - Integer(Self.Weekday);
  if Delta < 0 then
    Inc(Delta, 7);
  Result := Self + Delta;
end;

function Chrono.TDate.PreviousWeekday(const Day: Chrono.TWeekday): Chrono.TDate;
var
  Delta: Integer;
begin
  Delta := Integer(Self.Weekday) - Integer(Day);
  if Delta < 0 then
    Inc(Delta, 7);
  Result := Self - Delta;
end;

function Chrono.TDate.Plus(const Period: Chrono.TPeriod): Chrono.TDate;
begin
  Result := Self + Period;
end;

function Chrono.TDate.Plus(const Days: Integer): Chrono.TDate;
begin
  Result := Self + Days;
end;

function Chrono.TDate.Minus(const Period: Chrono.TPeriod): Chrono.TDate;
begin
  Result := Self - Period;
end;

function Chrono.TDate.Minus(const Days: Integer): Chrono.TDate;
begin
  Result := Self - Days;
end;

{$endregion}

{$region 'Time routine'}

{ Time }

constructor Chrono.TTime.Create(const Time: Chrono.TTime);
begin
  FTime := Time.FTime;
end;

constructor Chrono.TTime.Create(const Time: System.TDateTime);
begin
  Self := Time;
end;

constructor Chrono.TTime.Create(Hour, Min, Sec, MSec: Word);
begin
  Encode(Hour, Min, Sec, MSec);
end;

class function Chrono.TTime.Now: Chrono.TTime;
{$IFDEF MSWINDOWS}
var
  SystemTime: TSystemTime;
begin
  GetLocalTime(SystemTime);
  Result.Encode(SystemTime.wHour, SystemTime.wMinute, SystemTime.wSecond, SystemTime.wMilliseconds);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  T: time_t;
  TV: timeval;
  UT: tm;
begin
  gettimeofday(TV, nil);
  T := TV.tv_sec;
  localtime_r(T, UT);
  Result.Encode(UT.tm_hour, UT.tm_min, UT.tm_sec, TV.tv_usec div 1000);
end;
{$ENDIF POSIX}

class operator Chrono.TTime.Add(const L: Chrono.TTime; R: Integer): Chrono.TTime;
begin
  Result.FTime := L.FTime + R;
end;

class operator Chrono.TTime.Add(const L, R: Chrono.TTime): Chrono.TTime;
begin
  Result.FTime := L.FTime + R.FTime;
end;

class operator Chrono.TTime.Subtract(const L, R: Chrono.TTime): TDuration;
begin
  Result := TDuration.FromMilliseconds(L.FTime - R.FTime);
end;

class operator Chrono.TTime.Subtract(const L: Chrono.TTime; R: Integer): Chrono.TTime;
begin
  Result.FTime:= L.FTime - R;
end;

class operator Chrono.TTime.Add(const L: Chrono.TTime; R: TSeconds): Chrono.TTime;
begin
  Result.FTime := L.FTime + R * MSecsPerSec;
end;

class operator Chrono.TTime.Add(const L: Chrono.TTime; R: TMinutes): Chrono.TTime;
begin
  Result.FTime := L.FTime + R * SecsPerMin * MSecsPerSec;
end;

class operator Chrono.TTime.Add(const L: Chrono.TTime; R: THours): Chrono.TTime;
begin
  Result.FTime := L.FTime + R * MSecsPerHour;
end;

class operator Chrono.TTime.Subtract(const L: Chrono.TTime; R: TSeconds): Chrono.TTime;
begin
  Result.FTime := L.FTime - R * MSecsPerSec;
end;

class operator Chrono.TTime.Subtract(const L: Chrono.TTime; R: TMinutes): Chrono.TTime;
begin
  Result.FTime := L.FTime - R * SecsPerMin * MSecsPerSec;
end;

class operator Chrono.TTime.Subtract(const L: Chrono.TTime; R: THours): Chrono.TTime;
begin
  Result.FTime := L.FTime - R * MSecsPerHour;
end;

class operator Chrono.TTime.Dec(const a: Chrono.TTime): Chrono.TTime;
begin
  Result.FTime := a.FTime - 1;
end;

class operator Chrono.TTime.Inc(const a: Chrono.TTime): Chrono.TTime;
begin
  Result.FTime := a.FTime + 1;
end;

class operator Chrono.TTime.Equal(const a, b: Chrono.TTime): Boolean;
begin
  Result := a.FTime = b.FTime;
end;

class operator Chrono.TTime.NotEqual(const a, b: Chrono.TTime): Boolean;
begin
  Result := a.FTime <> b.FTime;
end;

class operator Chrono.TTime.LessThan(const a, b: Chrono.TTime): Boolean;
begin
  Result := a.FTime < b.FTime;
end;

class operator Chrono.TTime.LessThanOrEqual(const a, b: Chrono.TTime): Boolean;
begin
  Result := a.FTime <= b.FTime;
end;

class operator Chrono.TTime.GreaterThan(const a, b: Chrono.TTime): Boolean;
begin
  Result := a.FTime > b.FTime;
end;

class operator Chrono.TTime.GreaterThanOrEqual(const a, b: Chrono.TTime): Boolean;
begin
  Result := a.FTime >= b.FTime;
end;

class operator Chrono.TTime.Explicit(const a: Chrono.TTime): string;
begin
  Result := TimeToStr(a);
end;

class operator Chrono.TTime.Explicit(const a: string): Chrono.TTime;
begin
  Result := StrToTime(a);
end;

class operator Chrono.TTime.Implicit(const a: Chrono.TTime): System.TDateTime;
begin
  Result := a.FTime / FMSecsPerDay;
end;

class operator Chrono.TTime.Implicit(const a: System.TDateTime): Chrono.TTime;
begin
  // Abs() drops the sign of the System.TDateTime fraction. For NEGATIVE
  // TDateTime values (dates BEFORE 1899-12-30) Delphi treats the fractional part
  // as a time of day whose sign is ignored (e.g. -1.25 is 1899-12-29 06:00),
  // so taking Abs of the whole value already rounded to milliseconds may give
  // an incorrect result for such dates when the integer part is large.
  Result.FTime := Abs(Round(a * FMSecsPerDay)) mod IMSecsPerDay;
end;

class operator Chrono.TTime.Implicit(const a: TTimeStamp): Chrono.TTime;
begin
  Result.FTime := a.Time;
end;

class operator Chrono.TTime.Implicit(const a: Chrono.TTime): TTimeStamp;
begin
  Result.Time := a.FTime;
  Result.Date := 0;
end;

class operator Chrono.TTime.Implicit(const a: Variant): Chrono.TTime;
begin
  Result := VarToDateTime(a);
end;

class operator Chrono.TTime.Implicit(const a: Chrono.TTime): Variant;
begin
  TVarData(Result).VType := varDate;
  TVarData(Result).VDate := a.FTime / FMSecsPerDay;
end;

class operator Chrono.TTime.Explicit(const a: Chrono.TTime): Integer;
begin
  Result := a.FTime;
end;

class operator Chrono.TTime.Explicit(const a: Integer): Chrono.TTime;
begin
  Result.FTime := a;
end;

{$region 'Hours'}

class operator Chrono.TTime.Explicit(const a: THours): Chrono.TTime;
begin
  Result.FTime := a * MSecsPerHour;
end;

class operator Chrono.TTime.Explicit(const a: Chrono.TTime): THours;
begin
  Result := a.FTime div MSecsPerHour;
end;

class operator Chrono.TTime.Equal(const a: Chrono.TTime; b: THours): Boolean;
begin
  Result := a.FTime = (b * MSecsPerHour);
end;

class operator Chrono.TTime.NotEqual(const a: Chrono.TTime; b: THours): Boolean;
begin
  Result := a.FTime <> (b * MSecsPerHour);
end;

class operator Chrono.TTime.GreaterThan(const a: Chrono.TTime; b: THours): Boolean;
begin
  Result := a.FTime > (b * MSecsPerHour);
end;

class operator Chrono.TTime.GreaterThan(const a: THours; b: Chrono.TTime): Boolean;
begin
  Result := (a * MSecsPerHour) > b.FTime;
end;

class operator Chrono.TTime.GreaterThanOrEqual(const a: Chrono.TTime; b: THours): Boolean;
begin
  Result := a.FTime >= (b * MSecsPerHour);
end;

class operator Chrono.TTime.GreaterThanOrEqual(const a: THours; b: Chrono.TTime): Boolean;
begin
  Result := (a * MSecsPerHour) >= b.FTime;
end;

class operator Chrono.TTime.LessThan(const a: Chrono.TTime; b: THours): Boolean;
begin
  Result := a.FTime < (b * MSecsPerHour);
end;

class operator Chrono.TTime.LessThan(const a: THours; b: Chrono.TTime): Boolean;
begin
  Result := (a * MSecsPerHour) < b.FTime;
end;

class operator Chrono.TTime.LessThanOrEqual(const a: Chrono.TTime; b: THours): Boolean;
begin
  Result := a.FTime <= (b * MSecsPerHour);
end;

class operator Chrono.TTime.LessThanOrEqual(const a: THours; b: Chrono.TTime): Boolean;
begin
  Result := (a * MSecsPerHour) <= b.FTime;
end;

{$endregion}

{$region 'Minutes'}

class operator Chrono.TTime.Explicit(const a: TMinutes): Chrono.TTime;
begin
  Result.FTime := a * MSecsPerMinute;
end;

class operator Chrono.TTime.Explicit(const a: Chrono.TTime): TMinutes;
begin
  Result := a.FTime div MSecsPerMinute;
end;

class operator Chrono.TTime.Equal(const a: Chrono.TTime; b: TMinutes): Boolean;
begin
  Result := a.FTime = (b * MSecsPerMinute);
end;

class operator Chrono.TTime.NotEqual(const a: Chrono.TTime; b: TMinutes): Boolean;
begin
  Result := a.FTime <> (b * MSecsPerMinute);
end;

class operator Chrono.TTime.GreaterThan(const a: Chrono.TTime; b: TMinutes): Boolean;
begin
  Result := a.FTime > (b * MSecsPerMinute);
end;

class operator Chrono.TTime.GreaterThan(const a: TMinutes; b: Chrono.TTime): Boolean;
begin
  Result := (a * MSecsPerMinute) > b.FTime;
end;

class operator Chrono.TTime.GreaterThanOrEqual(const a: Chrono.TTime; b: TMinutes): Boolean;
begin
  Result := a.FTime >= (b * MSecsPerMinute);
end;

class operator Chrono.TTime.GreaterThanOrEqual(const a: TMinutes; b: Chrono.TTime): Boolean;
begin
  Result := (a * MSecsPerMinute) >= b.FTime;
end;

class operator Chrono.TTime.LessThan(const a: Chrono.TTime; b: TMinutes): Boolean;
begin
  Result := a.FTime < (b * MSecsPerMinute);
end;

class operator Chrono.TTime.LessThan(const a: TMinutes; b: Chrono.TTime): Boolean;
begin
  Result := (a * MSecsPerMinute) < b.FTime;
end;

class operator Chrono.TTime.LessThanOrEqual(const a: Chrono.TTime; b: TMinutes): Boolean;
begin
  Result := a.FTime <= (b * MSecsPerMinute);
end;

class operator Chrono.TTime.LessThanOrEqual(const a: TMinutes; b: Chrono.TTime): Boolean;
begin
  Result := (a * MSecsPerMinute) <= b.FTime;
end;

{$endregion}

{$region 'Seconds'}

class operator Chrono.TTime.Explicit(const a: TSeconds): Chrono.TTime;
begin
  Result.FTime := a * MSecsPerSec;
end;

class operator Chrono.TTime.Explicit(const a: Chrono.TTime): TSeconds;
begin
  Result := a.FTime div MSecsPerSec;
end;

class operator Chrono.TTime.Equal(const a: Chrono.TTime; b: TSeconds): Boolean;
begin
  Result := a.FTime = (b * MSecsPerSec);
end;

class operator Chrono.TTime.NotEqual(const a: Chrono.TTime; b: TSeconds): Boolean;
begin
  Result := a.FTime <> (b * MSecsPerSec);
end;

class operator Chrono.TTime.GreaterThan(const a: Chrono.TTime; b: TSeconds): Boolean;
begin
  Result := a.FTime > (b * MSecsPerSec);
end;

class operator Chrono.TTime.GreaterThan(const a: TSeconds; b: Chrono.TTime): Boolean;
begin
  Result := (a * MSecsPerSec) > b.FTime;
end;

class operator Chrono.TTime.GreaterThanOrEqual(const a: Chrono.TTime; b: TSeconds): Boolean;
begin
  Result := a.FTime >= (b * MSecsPerSec);
end;

class operator Chrono.TTime.GreaterThanOrEqual(const a: TSeconds; b: Chrono.TTime): Boolean;
begin
  Result := (a * MSecsPerSec) >= b.FTime;
end;

class operator Chrono.TTime.LessThan(const a: Chrono.TTime; b: TSeconds): Boolean;
begin
  Result := a.FTime < (b * MSecsPerSec);
end;

class operator Chrono.TTime.LessThan(const a: TSeconds; b: Chrono.TTime): Boolean;
begin
  Result := (a * MSecsPerSec) < b.FTime;
end;

class operator Chrono.TTime.LessThanOrEqual(const a: Chrono.TTime; b: TSeconds): Boolean;
begin
  Result := a.FTime <= (b * MSecsPerSec);
end;

class operator Chrono.TTime.LessThanOrEqual(const a: TSeconds; b: Chrono.TTime): Boolean;
begin
  Result := (a * MSecsPerSec) <= b.FTime;
end;

{$endregion}

{$region 'Milliseconds'}

class operator Chrono.TTime.Explicit(const a: TMilliseconds): Chrono.TTime;
begin
  Result.FTime := a;
end;

class operator Chrono.TTime.Explicit(const a: Chrono.TTime): TMilliseconds;
begin
  Result := a.FTime;
end;

class operator Chrono.TTime.Equal(const a: Chrono.TTime; b: TMilliseconds): Boolean;
begin
  Result := a.FTime = b;
end;

class operator Chrono.TTime.NotEqual(const a: Chrono.TTime; b: TMilliseconds): Boolean;
begin
  Result := a.FTime <> b;
end;

class operator Chrono.TTime.GreaterThan(const a: Chrono.TTime; b: TMilliseconds): Boolean;
begin
  Result := a.FTime > b;
end;

class operator Chrono.TTime.GreaterThan(const a: TMilliseconds; b: Chrono.TTime): Boolean;
begin
  Result := a > b.FTime;
end;

class operator Chrono.TTime.GreaterThanOrEqual(const a: Chrono.TTime; b: TMilliseconds): Boolean;
begin
  Result := a.FTime >= b;
end;

class operator Chrono.TTime.GreaterThanOrEqual(const a: TMilliseconds; b: Chrono.TTime): Boolean;
begin
  Result := a >= b.FTime;
end;

class operator Chrono.TTime.LessThan(const a: Chrono.TTime; b: TMilliseconds): Boolean;
begin
  Result := a.FTime < b;
end;

class operator Chrono.TTime.LessThan(const a: TMilliseconds; b: Chrono.TTime): Boolean;
begin
  Result := a < b.FTime;
end;

class operator Chrono.TTime.LessThanOrEqual(const a: Chrono.TTime; b: TMilliseconds): Boolean;
begin
  Result := a.FTime <= b;
end;

class operator Chrono.TTime.LessThanOrEqual(const a: TMilliseconds; b: Chrono.TTime): Boolean;
begin
  Result := a <= b.FTime;
end;

{$endregion}

function Chrono.TTime.GetISO: string;
begin
  Result := FormatDateTime('HH:NN:SS', Self);
end;

procedure Chrono.TTime.SetISO(const Value: string);
begin
  Parse(Value, ISO8601DateFormatSettings);
end;

function Chrono.TTime.GetMIME: string;
var
  H, M, S: Word;
begin
  Decode(H, M, S);
  Result := S24[H] + S60[M] + S60[S];
end;

procedure Chrono.TTime.SetMIME(const Value: string);
var
  pm, am: Integer;
  Src: string;
  H, M, S: Word;
begin
  // Parses three formats in one function: "HH[:MM[:SS]][ AM|PM]".
  // Steps: cut off the AM/PM suffix (if any), split the rest by ':' into 1-3
  // parts, then adjust the hour for AM/PM AFTER parsing (12 AM -> hour 0,
  // X PM with X < 12 -> X + 12 — the classic 12-hour clock rule). On invalid
  // input (not a number) StrToIntDef silently substitutes 0 — no exception is
  // raised, so validate untrusted input yourself.

  Src := UpperCase(Value);
  pm := Pos('PM', Src);
  am := Pos('AM', Src);

  if pm > 0 then
    Src := Copy(Src, 1, pm - 1)
  else if am > 0 then
    Src := Copy(Src, 1, am - 1);
  Src := Trim(Src);

  var Parts := Src.Split([':']);
  case Length(Parts) of
    1: begin H := StrToIntDef(Parts[0], 0); M := 0; S := 0; end;
    2: begin H := StrToIntDef(Parts[0], 0); M := StrToIntDef(Parts[1], 0); S := 0; end;
    3: begin H := StrToIntDef(Parts[0], 0); M := StrToIntDef(Parts[1], 0); S := StrToIntDef(Parts[2], 0); end;
  else
    begin H := 0; M := 0; S := 0; end;
  end;

  if (pm > 0) and (H < 12) then
    H := H + 12
  else if (am > 0) and (H = 12) then
    H := 0;

  Encode(H, M, S);
end;

procedure Chrono.TTime.Encode(Hour, Min, Sec, MSec: Word);
begin
  FTime :=  (Hour * MSecsPerHour)
            + (Min * SecsPerMin * MSecsPerSec)
            + (Sec * MSecsPerSec)
            +  MSec;
end;

procedure Chrono.TTime.Decode(var Hour, Min, Sec: Word);
var
  MinCount, MSecCount, MSec: Word;
begin
  DivMod(FTime, SecsPerMin * MSecsPerSec, MinCount, MSecCount);
  DivMod(MinCount, MinsPerHour, Hour, Min);
  DivMod(MSecCount, MSecsPerSec, Sec, MSec);
end;

procedure Chrono.TTime.Decode(var Hour, Min, Sec, MSec: Word);
var
  MinCount, MSecCount: Word;
begin
  DivMod(FTime, SecsPerMin * MSecsPerSec, MinCount, MSecCount);
  DivMod(MinCount, MinsPerHour, Hour, Min);
  DivMod(MSecCount, MSecsPerSec, Sec, MSec);
end;

function Chrono.TTime.GetHour: Word;
begin
  Result := FTime div MSecsPerHour;
end;

function Chrono.TTime.GetMinute: Word;
begin
  Result := (FTime div (MSecsPerSec * SecsPerMin)) mod MinsPerHour;
end;

function Chrono.TTime.GetSecond: Word;
begin
  Result := (FTime mod (MSecsPerSec * SecsPerMin)) div MSecsPerSec;
end;

function Chrono.TTime.GetMSecond: Word;
begin
  Result := (FTime mod (MSecsPerSec * SecsPerMin)) mod MSecsPerSec;
end;

procedure Chrono.TTime.SetHour(const Value: Word);
begin
  Encode(Value, Minute, Second, MSecond);
end;

procedure Chrono.TTime.SetMinute(const Value: Word);
begin
  Encode(Hour, Value, Second, MSecond);
end;

procedure Chrono.TTime.SetSecond(const Value: Word);
begin
  Encode(Hour, Minute, Value, MSecond);
end;

procedure Chrono.TTime.SetMSecond(const Value: Word);
begin
  Encode(Hour, Minute, Second, Value);
end;

function Chrono.TTime.ToString: string;
begin
  Result := TimeToStr(Self);
end;

function Chrono.TTime.ToString(const FormatSettings: TFormatSettings): string;
begin
  Result := TimeToStr(Self, FormatSettings);
end;

function Chrono.TTime.Format(const Format: string): string;
begin
  Result := FormatDateTime(Format, Self);
end;

function Chrono.TTime.Format(const Format: string; const FormatSettings: TFormatSettings): string;
begin
  Result := FormatDateTime(Format, Self, FormatSettings);
end;

procedure Chrono.TTime.Parse(const Value: string; const FormatSettings: TFormatSettings);
begin
  Self := StrToDateTime(Value, FormatSettings);
end;

procedure Chrono.TTime.Parse(const Value: string);
begin
  Self := StrToDateTime(Value);
end;

function Chrono.TTime.TryParse(const Value: string; const FormatSettings: TFormatSettings): Boolean;
var
  D: System.TDateTime;
begin
  Result := TryStrToDateTime(Value, D, FormatSettings);
  if Result then
    Self := D;
end;

function Chrono.TTime.TryParse(const Value: string): Boolean;
var
  D: System.TDateTime;
begin
  Result := TryStrToDateTime(Value, D);
  if Result then
    Self := D;
end;

{$endregion}

{ Chrono.TWeekday }

function Chrono.TWeekday.GetHashCode: Integer;
begin
  Result := FDay;
end;

class operator Chrono.TWeekday.Implicit(const a: Word): Chrono.TWeekday;
begin
  Result.FDay := a;
end;

class operator Chrono.TWeekday.Implicit(const a: Chrono.TWeekday): Word;
begin
  Result := a.FDay;
end;

class operator Chrono.TWeekday.Explicit(const a: Chrono.TWeekday): string;
begin
  Result := a.ToString;
end;

class operator Chrono.TWeekday.Explicit(const a: string): Chrono.TWeekday;
begin
  Result.Parse(a);
end;

class operator Chrono.TWeekday.Equal(const a, b: Chrono.TWeekday): Boolean;
begin
  Result := a.FDay = b.FDay;
end;

class operator Chrono.TWeekday.LessThan(const a, b: Chrono.TWeekday): Boolean;
begin
  Result := a.FDay < b.FDay;
end;

class operator Chrono.TWeekday.LessThanOrEqual(const a, b: Chrono.TWeekday): Boolean;
begin
  Result := a.FDay <= b.FDay;
end;

class operator Chrono.TWeekday.NotEqual(const a, b: Chrono.TWeekday): Boolean;
begin
  Result := a.FDay <> b.FDay;
end;

class operator Chrono.TWeekday.GreaterThan(const a, b: Chrono.TWeekday): Boolean;
begin
  Result := a.FDay > b.FDay;
end;

class operator Chrono.TWeekday.GreaterThanOrEqual(const a, b: Chrono.TWeekday): Boolean;
begin
  Result := a.FDay >= b.FDay;
end;

class operator Chrono.TWeekday.Add(const a: Chrono.TWeekday; b: Word): Chrono.TWeekday;
begin
  Result.FDay := a.FDay + b;
end;

class operator Chrono.TWeekday.Subtract(const a: Chrono.TWeekday; const b: Word): Chrono.TWeekday;
begin
  Result.FDay := a.FDay - b;
end;

class operator Chrono.TWeekday.Subtract(const a, b: Chrono.TWeekday): Integer;
begin
  Result := a.FDay - b.FDay;
end;

function Chrono.TWeekday.ToString(const FormatSettings: TFormatSettings): string;
begin
  Result := FormatSettings.LongDayNames[FDay];
end;

function Chrono.TWeekday.ToString: string;
begin
  Result := FormatSettings.LongDayNames[FDay];
end;

function Chrono.TWeekday.ShortName(const FormatSettings: TFormatSettings): string;
begin
  Result := FormatSettings.ShortDayNames[FDay];
end;

function Chrono.TWeekday.ShortName: string;
begin
  Result := FormatSettings.ShortDayNames[FDay];
end;

function Chrono.TWeekday.LongName(const FormatSettings: TFormatSettings): string;
begin
  Result := FormatSettings.LongDayNames[FDay];
end;

function Chrono.TWeekday.LongName: string;
begin
  Result := FormatSettings.LongDayNames[FDay];
end;

procedure Chrono.TWeekday.Parse(const Value: string; const FormatSettings: TFormatSettings);
begin
  if not TryParse(Value, FormatSettings) then
    raise EConvertError.CreateResFmt(@System.SysConst.SInvalidDate, [Value]);
end;

procedure Chrono.TWeekday.Parse(const Value: string);
begin
  Parse(Value, FormatSettings);
end;

function Chrono.TWeekday.TryParse(const Value: string; const FormatSettings: TFormatSettings): Boolean;
var
  I: Integer;
begin
  for I := 1 to 7 do
    if AnsiSameText(Value, FormatSettings.LongDayNames[I]) then
    begin
      FDay := I;
      Exit(True);
    end;

  for I := 1 to 7 do
    if AnsiSameText(Value, FormatSettings.ShortDayNames[I]) then
    begin
      FDay := I;
      Exit(True);
    end;

  Result := False;
end;

function Chrono.TWeekday.TryParse(const Value: string): Boolean;
begin
  Result := TryParse(Value, FormatSettings)
end;

function Chrono.TWeekday.GetDay: TWeekdayNum;
begin
  Result := DaysOfWeekArray[Word(FirstDayOfWeek), FDay];
end;

procedure Chrono.TWeekday.SetDay(const Value: TWeekdayNum);
begin
  FDay := WeekdaysArray[Word(FirstDayOfWeek), Value];
end;

function Chrono.TWeekday.GetDayOfWeek(const FirstDayOfWeek: Chrono.TWeekday): TWeekdayNum;
begin
  Result := DaysOfWeekArray[Word(FirstDayOfWeek), FDay];
end;

procedure Chrono.TWeekday.SetDayOfWeek(const FirstDayOfWeek: Chrono.TWeekday; const Value: TWeekdayNum);
begin
  FDay := WeekdaysArray[Word(FirstDayOfWeek), Value];
end;

class operator Chrono.TWeekday.Implicit(const a: Chrono.TWeekday): TWeekdayNum;
begin
  Result := a.FDay;
end;

class operator Chrono.TWeekday.Implicit(const a: TWeekdayNum): Chrono.TWeekday;
begin
  Result.FDay := a;
end;

{ Chrono.TWeek.TEnumerator }

function Chrono.TWeek.TEnumerator.GetCurrent: Chrono.TWeekday;
begin
  Result := WeekdaysArray[FFirstDayOfWeek.FDay, FCurrentIndex];
end;

function Chrono.TWeek.TEnumerator.MoveNext: Boolean;
begin
  Result := FCurrentIndex < 7;
  if Result then
    Inc(FCurrentIndex);
end;

{ Chrono.TWeek }

constructor Chrono.TWeek.Create(const FirstDayOfWeek: Chrono.TWeekday);
begin
  FFirstDayOfWeek := FirstDayOfWeek;
end;

function Chrono.TWeek.Get(const Index: TWeekdayNum): Chrono.TWeekday;
begin
  Result := WeekdaysArray[Word(FirstDayOfWeek), Index];
end;

function Chrono.TWeek.GetEnumerator: TEnumerator;
begin
  Result := TEnumerator.Create;
  Result.FFirstDayOfWeek := FirstDayOfWeek;
  Result.FCurrentIndex := 0;
end;

class function Chrono.WeekDays(const FirstDayOfWeek: Chrono.TWeekday): Chrono.TWeek;
begin
  Result := Chrono.TWeek.Create(FirstDayOfWeek);
end;

class function Chrono.WeekDays: Chrono.TWeek;
begin
  Result := WeekDays(FirstDayOfWeek);
end;

{ Chrono.TYear }

function Chrono.TYear.GetHashCode: Integer;
begin
  Result := FYear;
end;

class function Chrono.TYear.Current: Chrono.TYear;
begin
  Result := Chrono.TDate.Today.Year;
end;

class operator Chrono.TYear.Explicit(const a: Chrono.TYear): string;
begin
  Result := IntToStr(a);
end;

class operator Chrono.TYear.Explicit(const a: string): Chrono.TYear;
begin
  Result.FYear := StrToInt(a);
end;

class operator Chrono.TYear.Implicit(const a: Word): Chrono.TYear;
begin
  Result.FYear := a;
end;

class operator Chrono.TYear.Implicit(const a: Chrono.TYear): Word;
begin
  Result := a.FYear;
end;

class operator Chrono.TYear.Equal(const a, b: Chrono.TYear): Boolean;
begin
  Result := a.FYear = b.FYear;
end;

class operator Chrono.TYear.NotEqual(const a, b: Chrono.TYear): Boolean;
begin
  Result := a.FYear <> b.FYear;
end;

class operator Chrono.TYear.GreaterThan(const a, b: Chrono.TYear): Boolean;
begin
  Result := a.FYear > b.FYear;
end;

class operator Chrono.TYear.GreaterThanOrEqual(const a, b: Chrono.TYear): Boolean;
begin
  Result := a.FYear >= b.FYear;
end;

class operator Chrono.TYear.LessThan(const a, b: Chrono.TYear): Boolean;
begin
    Result := a.FYear < b.FYear;
end;

class operator Chrono.TYear.LessThanOrEqual(const a, b: Chrono.TYear): Boolean;
begin
    Result := a.FYear <= b.FYear;
end;

class operator Chrono.TYear.Add(const a: Chrono.TYear; const b: Word): Chrono.TYear;
begin
  Result.FYear := a.FYear + b;
end;

class operator Chrono.TYear.Dec(const a: Chrono.TYear): Chrono.TYear;
begin
  Result.FYear := a.FYear - 1;
end;

class operator Chrono.TYear.Inc(const a: Chrono.TYear): Chrono.TYear;
begin
  Result.FYear := a.FYear + 1;
end;

class operator Chrono.TYear.IntDivide(const a: Chrono.TYear; const b: Word): Chrono.TYear;
begin
  Result.FYear := a.FYear div b;
end;

function Chrono.TYear.IsLeap: Boolean;
begin
  Result := YearIsLeap[FYear];
//  Result := (FYear mod 4 = 0) and ((FYear mod 100 <> 0) or (FYear mod 400 = 0));
end;

class operator Chrono.TYear.Multiply(const a: Chrono.TYear; const b: Word): Chrono.TYear;
begin
  Result.FYear := a.FYear * b;
end;

class operator Chrono.TYear.Subtract(const a: Chrono.TYear; const b: Word): Chrono.TYear;
begin
  Result.FYear := a.FYear - b;
end;

class operator Chrono.TYear.Subtract(const a, b: Chrono.TYear): Integer;
begin
  Result := a.FYear - b.FYear;
end;

function Chrono.TYear.ToString: string;
begin
  Result := FYear.ToString;
end;

{ Chrono.TYearHelper }

function Chrono.TYearHelper.First: Chrono.TDate;
begin
  Result.Encode(FYear);
end;

function Chrono.TYearHelper.Last: Chrono.TDate;
begin
  Result.Encode(FYear, 12, 31);
end;

function Chrono.TYearHelper.Dates: Chrono.TDate.TSequence;
begin
  Result := Chrono.TDate.Sequence(First, Last);
end;

{ Chrono.TQuarter.TSequenceEnumerator }

constructor Chrono.TQuarter.TSequenceEnumerator.Create(const First, Last: TQuarterNum);
begin
  FCurrent := First - 1;
  FLast := Last;
end;

function Chrono.TQuarter.TSequenceEnumerator.GetCurrent: Chrono.TQuarter;
begin
  Result.FQuarter := FCurrent;
end;

function Chrono.TQuarter.TSequenceEnumerator.MoveNext: Boolean;
begin
  Inc(FCurrent);
  Result := FCurrent <= FLast;
end;

{ Chrono.TQuarter.TSequence }

constructor Chrono.TQuarter.TSequence.Create(const First, Last: Chrono.TQuarter);
begin
  FFirst := First;
  FLast := Last;
  FCount := FLast - FFirst + 1;
end;

function Chrono.TQuarter.TSequence.GetEnumerator: TSequenceEnumerator;
begin
  Result := Chrono.TQuarter.TSequenceEnumerator.Create(FFirst, FLast);
end;

{ Chrono.TQuarter }

class operator Chrono.TQuarter.Explicit(const a: string): Chrono.TQuarter;
var
  L: Integer;
begin
  L := Length(a);
  if L > 0 then
  begin
    case a[1] of
      '1':   Exit(Quarter1);
      '2':   Exit(Quarter2);
      '3':   Exit(Quarter3);
      '4':   Exit(Quarter4);
      #$2160: Exit(Quarter1);
      #$2161: Exit(Quarter2);
      #$2162: Exit(Quarter3);
      #$2163: Exit(Quarter4);
      'I': if (L > 2) and (a[2] = 'I') and (a[3] = 'I') then
             Exit(Quarter3)
           else if (L > 1) and (a[2] = 'I') then
             Exit(Quarter2)
           else if (L > 1) and (a[2] = 'V') then
             Exit(Quarter4)
           else
             Exit(Quarter1);
    end;
  end;

  raise EConvertError.CreateResFmt(@SInvalidQuarter, [a]);
end;

class operator Chrono.TQuarter.Explicit(const a: Chrono.TQuarter): string;
begin
  Result := Roman[a.FQuarter];
end;

class operator Chrono.TQuarter.Implicit(const a: Chrono.TQuarter): Word;
begin
  Result := a.FQuarter;
end;

class operator Chrono.TQuarter.Implicit(const a: Word): Chrono.TQuarter;
begin
  Result.FQuarter := a;
end;

class operator Chrono.TQuarter.Implicit(const a: TQuarterNum): Chrono.TQuarter;
begin
  Result.FQuarter := a;
end;

class operator Chrono.TQuarter.Implicit(const a: Chrono.TQuarter): TQuarterNum;
begin
  Result := a.FQuarter;
end;

class operator Chrono.TQuarter.Equal(const a, b: Chrono.TQuarter): Boolean;
begin
  Result := a.FQuarter = b.FQuarter;
end;

class operator Chrono.TQuarter.GreaterThan(const a, b: Chrono.TQuarter): Boolean;
begin
  Result := a.FQuarter > b.FQuarter;
end;

class operator Chrono.TQuarter.GreaterThanOrEqual(const a, b: Chrono.TQuarter): Boolean;
begin
  Result := a.FQuarter >= b.FQuarter;
end;

class operator Chrono.TQuarter.LessThan(const a, b: Chrono.TQuarter): Boolean;
begin
  Result := a.FQuarter < b.FQuarter;
end;

class operator Chrono.TQuarter.LessThanOrEqual(const a, b: Chrono.TQuarter): Boolean;
begin
  Result := a.FQuarter <= b.FQuarter;
end;

class operator Chrono.TQuarter.NotEqual(const a, b: Chrono.TQuarter): Boolean;
begin
  Result := a.FQuarter <> b.FQuarter;
end;

class operator Chrono.TQuarter.Add(const a: Chrono.TQuarter; b: Word): Chrono.TQuarter;
begin
  Result.FQuarter := a.FQuarter + b;
end;

class operator Chrono.TQuarter.Subtract(const a: Chrono.TQuarter; const b: Word): Chrono.TQuarter;
begin
  Result.FQuarter := a.FQuarter - b;
end;

class operator Chrono.TQuarter.Subtract(const a, b: Chrono.TQuarter): Integer;
begin
  Result := a.FQuarter - b.FQuarter;
end;

class function Chrono.TQuarter.Range(const First, Last: Chrono.TQuarter): TSequence;
begin
  Result := TSequence.Create(First, Last);
end;

{ Chrono.TQuarterHelper }

function Chrono.TQuarterHelper.Dates(const Year: Chrono.TYear): Chrono.TDate.TSequence;
begin
  Result := Chrono.TDate.TSequence.Create(First.First(Year), Last.Last(Year));
end;

function Chrono.TQuarterHelper.First: TMonth;
begin
  Result.FMonth := QuarterFirstMonth[FQuarter];
end;

function Chrono.TQuarterHelper.Last: TMonth;
begin
  Result.FMonth := QuarterLastMonth[FQuarter];
end;

function Chrono.TQuarterHelper.Months: TMonth.TSequence;
begin
  Result := TMonth.TSequence.Create(First, Last);
end;

{ Chrono.TQuarterSequenceHelper }

function Chrono.TQuarterSequenceHelper.First: Chrono.TQuarter;
begin
  Result.FQuarter := FFirst;
end;

function Chrono.TQuarterSequenceHelper.Last: Chrono.TQuarter;
begin
  Result.FQuarter := FLast;
end;

function Chrono.TQuarterSequenceHelper.Months: Chrono.TMonth.TSequence;
begin
  Result := TMonth.TSequence.Create(First.First, Last.Last);
end;

{ Chrono.TQuarterOfYear }

constructor Chrono.TQuarterOfYear.Create(const Year: Chrono.TYear; const Quarter: Chrono.TQuarter);
begin
  FYear := Year;
  FQuarter := Quarter;
end;

constructor Chrono.TQuarterOfYear.Create(const Date: System.TDateTime);
begin
  Self := Chrono.TQuarterOfYear(Date);
end;

class function Chrono.TQuarterOfYear.Current: Chrono.TQuarterOfYear;
begin
  Result := Chrono.TDate.Today.QuarterOfYear;
end;

class operator Chrono.TQuarterOfYear.Explicit(const a: System.TDateTime): Chrono.TQuarterOfYear;
begin
  Result := Chrono.TDate(a).QuarterOfYear;
end;

class operator Chrono.TQuarterOfYear.Equal(const a, b: Chrono.TQuarterOfYear): Boolean;
begin
  Result := (a.FYear = b.FYear) and (a.FQuarter = b.FQuarter);
end;

class operator Chrono.TQuarterOfYear.NotEqual(const a, b: Chrono.TQuarterOfYear): Boolean;
begin
  Result := (a.FYear <> b.FYear) or (a.FQuarter <> b.FQuarter);
end;

class operator Chrono.TQuarterOfYear.GreaterThan(const a, b: Chrono.TQuarterOfYear): Boolean;
begin
  Result := a.Index > b.Index;
end;

class operator Chrono.TQuarterOfYear.GreaterThanOrEqual(const a, b: Chrono.TQuarterOfYear): Boolean;
begin
  Result := a.Index >= b.Index;
end;

class operator Chrono.TQuarterOfYear.LessThan(const a, b: Chrono.TQuarterOfYear): Boolean;
begin
  Result := a.Index < b.Index;
end;

class operator Chrono.TQuarterOfYear.LessThanOrEqual(const a, b: Chrono.TQuarterOfYear): Boolean;
begin
  Result := a.Index <= b.Index;
end;

class operator Chrono.TQuarterOfYear.Add(const a: Chrono.TQuarterOfYear; b: Word): Chrono.TQuarterOfYear;
begin
  Result.Index := a.Index + b;
end;

class operator Chrono.TQuarterOfYear.Subtract(const a, b: Chrono.TQuarterOfYear): Integer;
begin
  Result := a.Index - b.Index;
end;

class operator Chrono.TQuarterOfYear.Subtract(const a: Chrono.TQuarterOfYear; const b: Word): Chrono.TQuarterOfYear;
begin
  Result.Index := a.Index - b;
end;

class operator Chrono.TQuarterOfYear.Inc(const a: Chrono.TQuarterOfYear): Chrono.TQuarterOfYear;
begin
  Result.Index := a.Index + 1;
end;

class operator Chrono.TQuarterOfYear.Dec(const a: Chrono.TQuarterOfYear): Chrono.TQuarterOfYear;
begin
  Result.Index := a.Index - 1;
end;

function Chrono.TQuarterOfYear.GetIndex: Integer;
begin
  Result := FYear.FYear * 4 + FQuarter.FQuarter - 1;
end;

procedure Chrono.TQuarterOfYear.SetIndex(const Value: Integer);
begin
  FYear.FYear := Value div 4;
  FQuarter.FQuarter := (Value mod 4) + 1;
end;

procedure Chrono.TQuarterOfYear.SetQuarter(const Value: Chrono.TQuarter);
begin
  FQuarter := Value;
end;

procedure Chrono.TQuarterOfYear.SetYear(const Value: Chrono.TYear);
begin
  FYear := Value;
end;

{ Chrono.TQuarterOfYearHelper }

function Chrono.TQuarterOfYearHelper.First: Chrono.TMonthOfYear;
begin
  Result := Chrono.TMonthOfYear.Create(Year, QuarterFirstMonth[FQuarter.FQuarter]);
end;

function Chrono.TQuarterOfYearHelper.Last: Chrono.TMonthOfYear;
begin
  Result := Chrono.TMonthOfYear.Create(Year, QuarterLastMonth[FQuarter.FQuarter]);
end;

function Chrono.TQuarterOfYearHelper.Dates: Chrono.TDate.TSequence;
begin
  Result := Chrono.TDate.TSequence.Create(First.First, Last.Last);
end;

function Chrono.TQuarterOfYearHelper.Months: Chrono.TMonthOfYear.TSequence;
begin
  Result := Chrono.TMonthOfYear.TSequence.Create(First, Last);
end;

{ Chrono.TMonth.TSequenceEnumerator }

constructor Chrono.TMonth.TSequenceEnumerator.Create(const First, Last: TMonthNum);
begin
  FCurrent := First - 1;
  FLast := Last;
end;

function Chrono.TMonth.TSequenceEnumerator.GetCurrent: TMonth;
begin
  Result.FMonth := FCurrent;
end;

function Chrono.TMonth.TSequenceEnumerator.MoveNext: Boolean;
begin
  Inc(FCurrent);
  Result := FCurrent <= FLast;
end;

{ Chrono.TMonth.TSequence }

constructor Chrono.TMonth.TSequence.Create(const First, Last: TMonth);
begin
  FFirst := First;
  FLast := Last;
  FCount := FLast - FFirst + 1;
end;

function Chrono.TMonth.TSequence.GetEnumerator: TSequenceEnumerator;
begin
  Result := TMonth.TSequenceEnumerator.Create(FFirst, FLast);
end;

{ Chrono.TMonth }

class operator Chrono.TMonth.Add(const a: Chrono.TMonth; b: Word): Chrono.TMonth;
begin
  Result.FMonth := a.FMonth + b;
end;

class operator Chrono.TMonth.Subtract(const a: Chrono.TMonth; const b: Word): Chrono.TMonth;
begin
  Result.FMonth := a.FMonth - b;
end;

class operator Chrono.TMonth.Subtract(const a, b: Chrono.TMonth): Integer;
begin
  Result := a.FMonth - b.FMonth;
end;

class operator Chrono.TMonth.Explicit(const a: Chrono.TMonth): string;
begin
  Result := FormatSettings.LongMonthNames[a.FMonth];
end;

class operator Chrono.TMonth.Explicit(const a: string): Chrono.TMonth;
var
  I: Word;
begin
  for I in [1..12] do
  begin
    if AnsiSameText(FormatSettings.LongMonthNames[I], a) then
    begin
      Result.FMonth := I;
      Exit;
    end;
  end;

  for I in [1..12] do
  begin
    if AnsiSameText(FormatSettings.ShortMonthNames[I], a) then
    begin
      Result.FMonth := I;
      Exit;
    end;
  end;

  raise EConvertError.Create('Invalid month name "' + a + '"');
end;

class operator Chrono.TMonth.Equal(const a, b: Chrono.TMonth): Boolean;
begin
  Result := a.FMonth = b.FMonth;
end;

class operator Chrono.TMonth.GreaterThan(const a, b: Chrono.TMonth): Boolean;
begin
  Result := a.FMonth > b.FMonth;
end;

class operator Chrono.TMonth.GreaterThanOrEqual(const a, b: Chrono.TMonth): Boolean;
begin
  Result := a.FMonth >= b.FMonth;
end;

class operator Chrono.TMonth.LessThan(const a, b: Chrono.TMonth): Boolean;
begin
  Result := a.FMonth < b.FMonth;
end;

class operator Chrono.TMonth.LessThanOrEqual(const a, b: Chrono.TMonth): Boolean;
begin
  Result := a.FMonth <= b.FMonth;
end;

class operator Chrono.TMonth.NotEqual(const a, b: Chrono.TMonth): Boolean;
begin
  Result := a.FMonth <> b.FMonth;
end;

class operator Chrono.TMonth.Implicit(const a: Chrono.TMonth): TMonthNum;
begin
  Result := a.FMonth;
end;

class operator Chrono.TMonth.Implicit(const a: Chrono.TMonth): Word;
begin
  Result := a.FMonth;
end;

class operator Chrono.TMonth.Implicit(const a: Word): Chrono.TMonth;
begin
  Result.FMonth := a;
end;

function Chrono.TMonth.ToString: string;
begin
  Result := FormatSettings.LongMonthNames[FMonth];
end;

function Chrono.TMonth.ToString(const FormatSettings: TFormatSettings): string;
begin
  Result := FormatSettings.LongMonthNames[FMonth];
end;

function Chrono.TMonth.ToString(Short: Boolean): string;
begin
  if Short then
    Result := FormatSettings.ShortMonthNames[FMonth]
  else
    Result := FormatSettings.LongMonthNames[FMonth];
end;

function Chrono.TMonth.ToString(Short: Boolean; const FormatSettings: TFormatSettings): string;
begin
  if Short then
    Result := FormatSettings.ShortMonthNames[FMonth]
  else
    Result := FormatSettings.LongMonthNames[FMonth];
end;

function Chrono.TMonth.Days(const Year: Chrono.TYear): TDays;
begin
  Result := MonthDays[Year.IsLeap, FMonth];
end;

{ Chrono.TMonthHelper }

function Chrono.TMonthHelper.First(const Year: Chrono.TYear): Chrono.TDate;
begin
  Result.Encode(Year, FMonth);
end;

function Chrono.TMonthHelper.Last(const Year: Chrono.TYear): Chrono.TDate;
begin
  if FMonth = 12 then
    Result.Encode(Year.FYear, 12, 31)
  else
  begin
    Result.Encode(Year.FYear, FMonth + 1, 1);
    Dec(Result.FDate);
  end;
end;

function Chrono.TMonthHelper.Sequence(const Year: Chrono.TYear): Chrono.TDate.TSequence;
begin
  Result := Chrono.TDate.Sequence(First(Year), Last(Year));
end;

{ Chrono.TDay }

function Chrono.TDay.GetHashCode: Integer;
begin
  Result := FDay;
end;

class operator Chrono.TDay.Explicit(const a: Chrono.TDay): string;
begin
  Result := IntToStr(a.FDay);
end;

class operator Chrono.TDay.Explicit(const a: string): Chrono.TDay;
begin
  Result.FDay := StrToInt(a);
end;

class operator Chrono.TDay.Implicit(const a: Word): Chrono.TDay;
begin
  Result.FDay := a;
end;

class operator Chrono.TDay.Implicit(const a: Chrono.TDay): Word;
begin
  Result := a.FDay;
end;

class operator Chrono.TDay.Equal(const a, b: Chrono.TDay): Boolean;
begin
  Result := a.FDay = b.FDay;
end;

class operator Chrono.TDay.NotEqual(const a, b: Chrono.TDay): Boolean;
begin
  Result := a.FDay <> b.FDay;
end;

class operator Chrono.TDay.GreaterThan(const a, b: Chrono.TDay): Boolean;
begin
  Result := a.FDay > b.FDay;
end;

class operator Chrono.TDay.GreaterThanOrEqual(const a, b: Chrono.TDay): Boolean;
begin
  Result := a.FDay >= b.FDay;
end;

class operator Chrono.TDay.LessThan(const a, b: Chrono.TDay): Boolean;
begin
  Result := a.FDay < b.FDay;
end;

class operator Chrono.TDay.LessThanOrEqual(const a, b: Chrono.TDay): Boolean;
begin
  Result := a.FDay <= b.FDay;
end;

class operator Chrono.TDay.Add(const a: Chrono.TDay; const b: Word): Chrono.TDay;
begin
  Result.FDay := a.FDay + b;
end;

class operator Chrono.TDay.Subtract(const a: Chrono.TDay; const b: Word): Chrono.TDay;
begin
  Result.FDay := a.FDay - b;
end;

function Chrono.TDay.ToString: string;
begin
  Result := FDay.ToString;
end;

class operator Chrono.TDay.IntDivide(const a: Chrono.TDay; const b: Word): Chrono.TDay;
begin
  Result.FDay := a.FDay div b;
end;

class operator Chrono.TDay.Multiply(const a: Chrono.TDay; const b: Word): Chrono.TDay;
begin
  Result.FDay := a.FDay * b;
end;

class operator Chrono.TDay.Dec(const a: Chrono.TDay): Chrono.TDay;
begin
  Result.FDay := a.FDay - 1;
end;

class operator Chrono.TDay.Inc(const a: Chrono.TDay): Chrono.TDay;
begin
  Result.FDay := a.FDay + 1;
end;

{ Chrono.TDateTime }

constructor Chrono.TDateTime.Create(const Value: Chrono.TDateTime);
begin
  FDate := Value.FDate;
  FTime := Value.FTime;
end;

constructor Chrono.TDateTime.Create(const Value: Chrono.TDate);
begin
  FDate := Value;
  FTime := Chrono.TTime.Now;
end;

constructor Chrono.TDateTime.Create(const Value: Chrono.TTime);
begin
  FDate := Chrono.TDate.Today;
  FTime := Value;
end;

constructor Chrono.TDateTime.Create(const Date: Chrono.TDate; const Time: Chrono.TTime);
begin
  FDate := Date;
  FTime := Time;
end;

constructor Chrono.TDateTime.Create(const Value: System.TDateTime);
begin
  FDate := Value;
  FTime := Value;
end;

class operator Chrono.TDateTime.Implicit(const a: System.TDateTime): Chrono.TDateTime;
begin
  Result.Date := a;
  Result.Time := a;
end;

class operator Chrono.TDateTime.Implicit(const a: Chrono.TDateTime): System.TDateTime;
begin
  // Before 1899-12-30 System.TDateTime is negative and its fraction is a time
  // of day whose sign is ignored, so the time must be subtracted there
  // (the same rule as System.DateUtils.ComposeDateTime).
  if Integer(a.FDate) >= DateDelta then
    Result := System.TDateTime(a.Date) + System.TDateTime(a.Time)
  else
    Result := System.TDateTime(a.Date) - System.TDateTime(a.Time);
end;

class operator Chrono.TDateTime.Explicit(const a: Chrono.TDateTime): string;
begin
  Result := a.ToString;
end;

class operator Chrono.TDateTime.Explicit(const a: string): Chrono.TDateTime;
begin
  Result.Parse(a);
end;

class operator Chrono.TDateTime.Explicit(const a: Chrono.TDateTime): Chrono.TDate;
begin
  Result := a.Date;
end;

class operator Chrono.TDateTime.Explicit(const a: Chrono.TDate): Chrono.TDateTime;
begin
  Result.FTime := Chrono.TTime(0);
  Result.FDate := a;
end;

class operator Chrono.TDateTime.Explicit(const a: Chrono.TDateTime): Chrono.TTime;
begin
  Result := a.Time;
end;

class operator Chrono.TDateTime.Equal(const a, b: Chrono.TDateTime): Boolean;
begin
  Result := (a.FDate = b.FDate) and (a.FTime = b.FTime);
end;

class operator Chrono.TDateTime.NotEqual(const a, b: Chrono.TDateTime): Boolean;
begin
  Result := (a.FDate <> b.FDate) or (a.FTime <> b.FTime);
end;

class operator Chrono.TDateTime.LessThan(const a, b: Chrono.TDateTime): Boolean;
begin
  if a.Date < b.Date then
    Result := True
  else if a.Date > b.Date then
    Result := False
  else
    Result := a.Time < b.Time;
end;

class operator Chrono.TDateTime.LessThanOrEqual(const a, b: Chrono.TDateTime): Boolean;
begin
  if a.Date < b.Date then
    Result := True
  else if a.Date > b.Date then
    Result := False
  else
    Result := a.Time <= b.Time;
end;

class operator Chrono.TDateTime.GreaterThan(const a, b: Chrono.TDateTime): Boolean;
begin
  if a.Date > b.Date then
    Result := True
  else if a.Date < b.Date then
    Result := False
  else
    Result := a.Time > b.Time;
end;

class operator Chrono.TDateTime.GreaterThanOrEqual(const a, b: Chrono.TDateTime): Boolean;
begin
  if a.Date > b.Date then
    Result := True
  else if a.Date < b.Date then
    Result := False
  else
    Result := a.Time >= b.Time;
end;

class operator Chrono.TDateTime.Implicit(const a: TTimeStamp): Chrono.TDateTime;
begin
  // TTimeStamp stores the same day number and the same milliseconds as the
  // fields; the explicit casts select Explicit(Integer), not Implicit(System.TDateTime).
  Result.FDate := Chrono.TDate(a.Date);
  Result.FTime := Chrono.TTime(a.Time);
end;

class operator Chrono.TDateTime.Implicit(const a: Chrono.TDateTime): TTimeStamp;
begin
  // Same scales as the fields, so copy them directly without going through Double.
  Result.Date := Integer(a.FDate);
  Result.Time := Integer(a.FTime);
end;

class operator Chrono.TDateTime.Implicit(const a: Chrono.TDateTime): Variant;
begin
  Result := TimeStampToDateTime(TTimeStamp(a));
end;

class operator Chrono.TDateTime.Add(const A: Chrono.TDateTime; const B: Chrono.TDuration): Chrono.TDateTime;
var
  TotalMSec: Int64;
  DaysDelta: Integer;
  NewTimeMSec: Int64;
begin
  // Add the duration to the time of day (in ms) and carry whole days over to
  // the date — this handles crossing midnight correctly in both directions.
  TotalMSec := Integer(A.Time) + B.TotalMilliseconds;
  DaysDelta := Integer(TotalMSec div IMSecsPerDay);
  NewTimeMSec := TotalMSec mod IMSecsPerDay;
  if NewTimeMSec < 0 then
  begin
    Inc(NewTimeMSec, IMSecsPerDay);
    Dec(DaysDelta);
  end;

  Result.Date := A.Date + DaysDelta;
  Result.Time := Chrono.TTime(Integer(NewTimeMSec));
end;

class operator Chrono.TDateTime.Subtract(const A: Chrono.TDateTime; const B: Chrono.TDuration): Chrono.TDateTime;
begin
  Result := A + B.Negate;
end;

class operator Chrono.TDateTime.Subtract(const A, B: Chrono.TDateTime): Chrono.TDuration;
begin
  Result := Chrono.TDuration.Between(B, A);
end;

{ Chrono.TDateTime + TPeriod }

class operator Chrono.TDateTime.Add(const A: Chrono.TDateTime; const B: Chrono.TPeriod): Chrono.TDateTime;
begin
  Result.Date := A.Date + B;
  Result.Time := A.Time;
end;

class operator Chrono.TDateTime.Subtract(const A: Chrono.TDateTime; const B: Chrono.TPeriod): Chrono.TDateTime;
begin
  Result.Date := A.Date - B;
  Result.Time := A.Time;
end;

class function Chrono.TDateTime.Now: Chrono.TDateTime;
{$IFDEF MSWINDOWS}
var
  SystemTime: TSystemTime;
begin
  GetLocalTime(SystemTime);
  Result.FDate.Encode(SystemTime.wYear, SystemTime.wMonth, SystemTime.wDay);
  Result.FTime.Encode(SystemTime.wHour, SystemTime.wMinute, SystemTime.wSecond, SystemTime.wMilliseconds);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  T: time_t;
  TV: timeval;
  UT: tm;
begin
  gettimeofday(TV, nil);
  T := TV.tv_sec;
  localtime_r(T, UT);
  Result.FDate.Encode(UT.tm_year + 1900, UT.tm_mon + 1, UT.tm_mday);
  Result.FTime.Encode(UT.tm_hour, UT.tm_min, UT.tm_sec, TV.tv_usec div 1000);
end;
{$ENDIF POSIX}

function Chrono.TDateTime.ToString: string;
begin
  Result := DateTimeToStr(Self);
end;

function Chrono.TDateTime.ToString(const FormatSettings: TFormatSettings): string;
begin
  Result := DateTimeToStr(Self, FormatSettings);
end;

function Chrono.TDateTime.Format(const Format: string): string;
begin
  Result := FormatDateTime(Format, Self);
end;

function Chrono.TDateTime.Format(const Format: string; const FormatSettings: TFormatSettings): string;
begin
  Result := FormatDateTime(Format, Self, FormatSettings);
end;

procedure Chrono.TDateTime.Parse(const Value: string; const FormatSettings: TFormatSettings);
begin
  Self := StrToDateTime(Value, FormatSettings);
end;

procedure Chrono.TDateTime.Parse(const Value: string);
begin
  Self := StrToDateTime(Value);
end;

function Chrono.TDateTime.TryParse(const Value: string; const FormatSettings: TFormatSettings): Boolean;
var
  D: System.TDateTime;
begin
  Result := TryStrToDateTime(Value, D, FormatSettings);
  if Result then
    Self := D;
end;

function Chrono.TDateTime.TryParse(const Value: string): Boolean;
var
  D: System.TDateTime;
begin
  Result := TryStrToDateTime(Value, D);
  if Result then
    Self := D;
end;

procedure Chrono.TDateTime.SetDate(const Value: Chrono.TDate);
begin
  FDate := Value;
end;

procedure Chrono.TDateTime.SetTime(const Value: Chrono.TTime);
begin
  FTime := Value;
end;

function Chrono.TDateTime.WithDate(const Value: Chrono.TDate): Chrono.TDateTime;
begin
  Result := Self;
  Result.Date := Value;
end;

function Chrono.TDateTime.WithTime(const Value: Chrono.TTime): Chrono.TDateTime;
begin
  Result := Self;
  Result.Time := Value;
end;

function Chrono.TDateTime.StartOfDay: Chrono.TDateTime;
begin
  Result.Date := Self.Date;
  Result.Time := Chrono.TTime(0);
end;

function Chrono.TDateTime.EndOfDay: Chrono.TDateTime;
begin
  Result.Date := Self.Date;
  Result.Time := Chrono.TTime(IMSecsPerDay - 1); // 23:59:59.999
end;

function Chrono.TDateTime.Plus(const D: Chrono.TDuration): Chrono.TDateTime;
begin
  Result := Self + D;
end;

function Chrono.TDateTime.Plus(const P: Chrono.TPeriod): Chrono.TDateTime;
begin
  Result := Self + P;
end;

function Chrono.TDateTime.Minus(const D: Chrono.TDuration): Chrono.TDateTime;
begin
  Result := Self - D;
end;

function Chrono.TDateTime.Minus(const P: Chrono.TPeriod): Chrono.TDateTime;
begin
  Result := Self - P;
end;

{ Chrono.TDate.TSequenceEnumerator }

constructor Chrono.TDate.TSequenceEnumerator.Create(const First, Last: Integer);
begin
  FStart := First - 1;
  FLast := Last;
end;

function Chrono.TDate.TSequenceEnumerator.GetCurrent: Chrono.TDate;
begin
  Result.FDate := FStart;
end;

function Chrono.TDate.TSequenceEnumerator.MoveNext: Boolean;
begin
  Inc(FStart);
  Result := FStart <= FLast;
end;

{ Chrono.TDate.TSequence }

constructor Chrono.TDate.TSequence.Create(const First, Last: Chrono.TDate);
begin
  FFirst := First.FDate;
  FLast := Last.FDate;
  FCount := FLast - FFirst + 1;
end;

function Chrono.TDate.TSequence.GetEnumerator: TSequenceEnumerator;
begin
  Result := Chrono.TDate.TSequenceEnumerator.Create(FFirst, FLast);
end;

{ Chrono.TMonthOfYear.TSequenceEnumerator }

constructor Chrono.TMonthOfYear.TSequenceEnumerator.Create(const FirstMonth: Chrono.TMonth; const FirstYear: Chrono.TYear; const LastMonth: Chrono.TMonth; const LastYear: Chrono.TYear);
begin
  // Linear month indexes, see TMonthOfYear.Index. MoveNext is called before
  // the first Current, so the cursor starts one step before First.
  FCurrent := FirstYear.FYear * 12 + FirstMonth.FMonth - 2;
  FLast := LastYear.FYear * 12 + LastMonth.FMonth - 1;
end;

function Chrono.TMonthOfYear.TSequenceEnumerator.GetCurrent: TMonthOfYear;
begin
  Result.Index := FCurrent;
end;

function Chrono.TMonthOfYear.TSequenceEnumerator.MoveNext: Boolean;
begin
  Inc(FCurrent);
  Result := FCurrent <= FLast;
end;

{ Chrono.TMonthOfYear.TSequence }

constructor Chrono.TMonthOfYear.TSequence.Create(const First, Last: Chrono.TMonthOfYear);
begin
  FFirstYear := First.Year;
  FFirstMonth := First.Month;
  FLastYear := Last.Year;
  FLastMonth := Last.Month;
  FCount := Last.Index - First.Index + 1;
end;

function Chrono.TMonthOfYear.TSequence.GetEnumerator: TSequenceEnumerator;
begin
  Result := TMonthOfYear.TSequenceEnumerator.Create(FFirstMonth, FFirstYear, FLastMonth, FLastYear);
end;

{ Chrono.TMonthOfYear }

constructor Chrono.TMonthOfYear.Create(const Year: Chrono.TYear; const Month: Chrono.TMonth);
begin
  FYear := Year;
  FMonth := Month;
end;

constructor Chrono.TMonthOfYear.Create(const Date: System.TDateTime);
begin
  Self := TMonthOfYear(Date);
end;

class function Chrono.TMonthOfYear.Current: TMonthOfYear;
begin
  Result := Chrono.TDate.Today.MonthOfYear;
end;

class operator Chrono.TMonthOfYear.Implicit(const a: TMonthOfYear): Chrono.TMonth;
begin
  Result := a.FMonth;
end;

class operator Chrono.TMonthOfYear.Implicit(const a: Chrono.TMonthOfYear): TMonthNum;
begin
  Result := a.Month;
end;

class operator Chrono.TMonthOfYear.Explicit(const a: System.TDateTime): Chrono.TMonthOfYear;
begin
  Result := Chrono.TDate(a).MonthOfYear;
end;

class operator Chrono.TMonthOfYear.Equal(const a, b: Chrono.TMonthOfYear): Boolean;
begin
  Result := a.Index = b.Index;
end;

class operator Chrono.TMonthOfYear.NotEqual(const a, b: Chrono.TMonthOfYear): Boolean;
begin
  Result := a.Index <> b.Index;
end;

class operator Chrono.TMonthOfYear.GreaterThan(const a, b: Chrono.TMonthOfYear): Boolean;
begin
  Result := a.Index > b.Index;
end;

class operator Chrono.TMonthOfYear.GreaterThanOrEqual(const a, b: Chrono.TMonthOfYear): Boolean;
begin
  Result := a.Index >= b.Index;
end;

class operator Chrono.TMonthOfYear.LessThan(const a, b: Chrono.TMonthOfYear): Boolean;
begin
  Result := a.Index < b.Index;
end;

class operator Chrono.TMonthOfYear.LessThanOrEqual(const a, b: Chrono.TMonthOfYear): Boolean;
begin
  Result := a.Index <= b.Index;
end;

class operator Chrono.TMonthOfYear.Add(const a: Chrono.TMonthOfYear; b: Word): Chrono.TMonthOfYear;
begin
  Result.Index := a.Index + b;
end;

class operator Chrono.TMonthOfYear.Subtract(const a, b: Chrono.TMonthOfYear): Integer;
begin
  Result := a.Index - b.Index;
end;

class operator Chrono.TMonthOfYear.Subtract(const a: Chrono.TMonthOfYear; const b: Word): Chrono.TMonthOfYear;
begin
  Result.Index := a.Index - b;
end;

class operator Chrono.TMonthOfYear.Inc(const a: Chrono.TMonthOfYear): Chrono.TMonthOfYear;
begin
  Result.Index := a.Index + 1;
end;

class operator Chrono.TMonthOfYear.Dec(const a: Chrono.TMonthOfYear): Chrono.TMonthOfYear;
begin
  Result.Index := a.Index - 1;
end;

function Chrono.TMonthOfYear.GetDays: TDays;
begin
  Result := Month.Days(Year);
end;

function Chrono.TMonthOfYear.ToString: string;
begin
  Result := Month.ToString + ' ' + Year.ToString;
end;

function Chrono.TMonthOfYear.GetHashCode: Integer;
begin
  Result := Year.FYear shl 8 + Month.FMonth;
end;

function Chrono.TMonthOfYear.GetIndex: Integer;
begin
  Result := FYear.FYear * 12 + FMonth.FMonth - 1;
end;

procedure Chrono.TMonthOfYear.SetIndex(const Value: Integer);
begin
  FYear := Value div 12;
  FMonth := (Value mod 12) + 1;
end;

procedure Chrono.TMonthOfYear.SetMonth(const Value: Chrono.TMonth);
begin
  FMonth := Value;
end;

procedure Chrono.TMonthOfYear.SetYear(const Value: Chrono.TYear);
begin
  FYear := Value;
end;

{ Chrono.TMonthOfYearHelper }

function Chrono.TMonthOfYearHelper.First: Chrono.TDate;
begin
  Result.Encode(Year, Month, 1);
end;

function Chrono.TMonthOfYearHelper.Last: Chrono.TDate;
begin
  Result.Encode(Word(Year), Word(Month), MonthDayCount[Year.IsLeap, Word(Month)]);
end;

function Chrono.TMonthOfYearHelper.Dates: Chrono.TDate.TSequence;
begin
  Result := Chrono.TDate.TSequence.Create(First, Last);
end;

{ Chrono.TDateSequenceHelper }

function Chrono.TDateSequenceHelper.GetFirst: Chrono.TDate;
begin
  Result.FDate := FFirst;
end;

function Chrono.TDateSequenceHelper.GetLast: Chrono.TDate;
begin
  Result.FDate := FLast;
end;

{ Chrono.TDayOfMonth }

function Chrono.TDayOfMonth.GetHashCode: Integer;
begin
  Result := Integer(Self);
end;

function Chrono.TDayOfMonth.ToString: string;
begin
  Result := Day.ToString + ' ' + Month.ToString;
end;

class operator Chrono.TDayOfMonth.Equal(const a, b: TDayOfMonth): Boolean;
begin
  Result := (a.Month = b.Month) and (a.Day = b.Day);
end;

// TDayOfMonth ordering: by month first, then by day.
class operator Chrono.TDayOfMonth.GreaterThan(const a, b: TDayOfMonth): Boolean;
begin
  Result := (a.FMonth > b.FMonth) or ((a.FMonth = b.FMonth) and (a.FDay > b.FDay));
end;

class operator Chrono.TDayOfMonth.GreaterThanOrEqual(const a, b: TDayOfMonth): Boolean;
begin
  Result := (a.FMonth > b.FMonth) or ((a.FMonth = b.FMonth) and (a.FDay >= b.FDay));
end;

class operator Chrono.TDayOfMonth.LessThan(const a, b: TDayOfMonth): Boolean;
begin
  Result := (a.FMonth < b.FMonth) or ((a.FMonth = b.FMonth) and (a.FDay < b.FDay));
end;

class operator Chrono.TDayOfMonth.LessThanOrEqual(const a, b: TDayOfMonth): Boolean;
begin
  Result := (a.FMonth < b.FMonth) or ((a.FMonth = b.FMonth) and (a.FDay <= b.FDay));
end;

class operator Chrono.TDayOfMonth.NotEqual(const a, b: TDayOfMonth): Boolean;
begin
  Result := (a.FMonth <> b.FMonth) or (a.FDay <> b.FDay);
end;

procedure Chrono.TDayOfMonth.SetDay(const Value: Chrono.TDay);
begin
  FDay := Value;
end;

procedure Chrono.TDayOfMonth.SetMonth(const Value: Chrono.TMonth);
begin
  FMonth := Value;
end;

{ Chrono.TBasicCalendar }

constructor Chrono.TBasicCalendar.Create;
begin
  inherited;
  FHolidays := TDictionary<Integer, Boolean>.Create;
  FWorkDays := TDictionary<Integer, Boolean>.Create;
end;

destructor Chrono.TBasicCalendar.Destroy;
begin
  FreeAndNil(FHolidays);
  FreeAndNil(FWorkDays);
  inherited;
end;

function Chrono.TBasicCalendar.GetHoliday(const Date: Chrono.TDate): Boolean;
begin
  if not Holidays.TryGetValue(Date.FDate, Result) then
    Result := False;
end;

function Chrono.TBasicCalendar.IsHoliday(const Date: Chrono.TDate): Boolean;
begin
  Result := GetHoliday(Date);
end;

procedure Chrono.TBasicCalendar.SetHoliday(const Date: Chrono.TDate; const Value: Boolean);
begin
  Holidays.AddOrSetValue(Date.FDate, Value);
end;

function Chrono.TBasicCalendar.GetWorkDay(const Date: Chrono.TDate): Boolean;
begin
  if not WorkDays.TryGetValue(Date.FDate, Result) then
    Result := False;
end;

function Chrono.TBasicCalendar.IsWorkDay(const Date: Chrono.TDate): Boolean;
begin
  if not WorkDays.TryGetValue(Date.FDate, Result) then
    Result := not IsWeekEnd(Date) and not IsHoliday(Date);
end;

procedure Chrono.TBasicCalendar.SetWorkDay(const Date: Chrono.TDate; const Value: Boolean);
begin
  WorkDays.AddOrSetValue(Date.FDate, Value);
end;

function Chrono.TBasicCalendar.IsWeekEnd(const Date: Chrono.TDate): Boolean;
begin
  Result := Date.Weekday in [1, 7];
end;

// ISO 639 language code of the current thread locale in lower case, or 'en'
// if it cannot be determined. Only the Windows implementation asks the OS.
function GetThreadLocaleISO639LanguageName: string;
{$IFDEF MSWINDOWS}
var
  Buffer: array[0..8] of Char;
  Len: Integer;
begin
  Len := GetLocaleInfo(GetThreadLocale, LOCALE_SISO639LANGNAME, Buffer, Length(Buffer));
  if Len > 0 then
    Result := LowerCase(Buffer)
  else
    Result := 'en';
end;
{$ELSE}
begin
  Result := 'en';
end;
{$ENDIF}

procedure Localize;
var
  Previous: Integer;
begin
  // Fast path: if already initialized, exit right away.
  // TInterlocked.CompareExchange with Done/Done is used as an atomic read with
  // a full barrier: even this "plain read" of the state goes through the
  // Interlocked API rather than a direct load, so the array writes made by the
  // initializing thread are guaranteed to be visible after it.
  if TInterlocked.CompareExchange(gLocalizeState, Ord(TLocalizeState.Done), Ord(TLocalizeState.Done)) = Ord(TLocalizeState.Done) then
    Exit;

  // CAS: try to move Idle(0) -> Initializing(1). It returns the PREVIOUS
  // value (the same semantics as Win32 InterlockedCompareExchange) —
  // if Previous = Idle, THIS thread won the race and must perform the
  // initialization.
  Previous := TInterlocked.CompareExchange(gLocalizeState, Ord(TLocalizeState.Initializing), Ord(TLocalizeState.Idle));

  if Previous = Ord(TLocalizeState.Idle) then
  begin
    var Lang := GetThreadLocaleISO639LanguageName;
    if Lang = 'ru' then
    begin
      gLocalizedDatePart[Chrono.TDatePart.Year] := LoadResString(@SYear_ru);
      gLocalizedDatePart[Chrono.TDatePart.Quarter] := LoadResString(@SQuarter_ru);
      gLocalizedDatePart[Chrono.TDatePart.Month] := LoadResString(@SMonth_ru);
      gLocalizedDatePart[Chrono.TDatePart.Week] := LoadResString(@SWeek_ru);
      gLocalizedDatePart[Chrono.TDatePart.Day] := LoadResString(@SDay_ru);
      gLocalizedDatePartShort[Chrono.TDatePart.Year] := LoadResString(@SYearShort_ru);
      gLocalizedDatePartShort[Chrono.TDatePart.Quarter] := LoadResString(@SQuarterShort_ru);
      gLocalizedDatePartShort[Chrono.TDatePart.Month] := LoadResString(@SMonthShort_ru);
      gLocalizedDatePartShort[Chrono.TDatePart.Week] := LoadResString(@SWeekShort_ru);
      gLocalizedDatePartShort[Chrono.TDatePart.Day] := LoadResString(@SDayShort_ru);
      gLocalizedTimePart[Chrono.TTimePart.Hour] := LoadResString(@SHour_ru);
      gLocalizedTimePart[Chrono.TTimePart.Minute] := LoadResString(@SMinute_ru);
      gLocalizedTimePart[Chrono.TTimePart.Second] := LoadResString(@SSecond_ru);
      gLocalizedTimePart[Chrono.TTimePart.Millisecond] := LoadResString(@SMillis_ru);
      gLocalizedTimePart[Chrono.TTimePart.Microsecond] := LoadResString(@SMicros_ru);
      gLocalizedTimePart[Chrono.TTimePart.Nanosecond] := LoadResString(@SNanos_ru);
      gLocalizedTimePartShort[Chrono.TTimePart.Hour] := LoadResString(@SHourShort_ru);
      gLocalizedTimePartShort[Chrono.TTimePart.Minute] := LoadResString(@SMinuteShort_ru);
      gLocalizedTimePartShort[Chrono.TTimePart.Second] := LoadResString(@SSecondShort_ru);
      gLocalizedTimePartShort[Chrono.TTimePart.Millisecond] := LoadResString(@SMillisShort_ru);
      gLocalizedTimePartShort[Chrono.TTimePart.Microsecond] := LoadResString(@SMicrosShort_ru);
      gLocalizedTimePartShort[Chrono.TTimePart.Nanosecond] := LoadResString(@SNanosShort_ru);
    end
    else
    begin
      gLocalizedDatePart[Chrono.TDatePart.Year] := LoadResString(@SYear);
      gLocalizedDatePart[Chrono.TDatePart.Quarter] := LoadResString(@SQuarter);
      gLocalizedDatePart[Chrono.TDatePart.Month] := LoadResString(@SMonth);
      gLocalizedDatePart[Chrono.TDatePart.Week] := LoadResString(@SWeek);
      gLocalizedDatePart[Chrono.TDatePart.Day] := LoadResString(@SDay);
      gLocalizedDatePartShort[Chrono.TDatePart.Year] := LoadResString(@SYearShort);
      gLocalizedDatePartShort[Chrono.TDatePart.Quarter] := LoadResString(@SQuarterShort);
      gLocalizedDatePartShort[Chrono.TDatePart.Month] := LoadResString(@SMonthShort);
      gLocalizedDatePartShort[Chrono.TDatePart.Week] := LoadResString(@SWeekShort);
      gLocalizedDatePartShort[Chrono.TDatePart.Day] := LoadResString(@SDayShort);
      gLocalizedTimePart[Chrono.TTimePart.Hour] := LoadResString(@SHour);
      gLocalizedTimePart[Chrono.TTimePart.Minute] := LoadResString(@SMinute);
      gLocalizedTimePart[Chrono.TTimePart.Second] := LoadResString(@SSecond);
      gLocalizedTimePart[Chrono.TTimePart.Millisecond] := LoadResString(@SMillis);
      gLocalizedTimePart[Chrono.TTimePart.Microsecond] := LoadResString(@SMicros);
      gLocalizedTimePart[Chrono.TTimePart.Nanosecond] := LoadResString(@SNanos);
      gLocalizedTimePartShort[Chrono.TTimePart.Hour] := LoadResString(@SHourShort);
      gLocalizedTimePartShort[Chrono.TTimePart.Minute] := LoadResString(@SMinuteShort);
      gLocalizedTimePartShort[Chrono.TTimePart.Second] := LoadResString(@SSecondShort);
      gLocalizedTimePartShort[Chrono.TTimePart.Millisecond] := LoadResString(@SMillisShort);
      gLocalizedTimePartShort[Chrono.TTimePart.Microsecond] := LoadResString(@SMicrosShort);
      gLocalizedTimePartShort[Chrono.TTimePart.Nanosecond] := LoadResString(@SNanosShort);
    end;
    // The final atomic write of Done(2) is what "publishes" all the preceding
    // array writes to other threads (release semantics, as in the classic
    // lazy singleton initialization pattern).
    TInterlocked.Exchange(gLocalizeState, Ord(TLocalizeState.Done));
  end
  else
  begin
    // Threads that lost the CAS: another thread is either initializing
    // (Previous=1) or has just finished (Previous=2 — possible if it completed
    // between our fast-path check and the CAS). Either way, wait for Done
    // WITHOUT reading the arrays before that, so as not to see data partially
    // filled by the other thread.
    while TInterlocked.CompareExchange(gLocalizeState, Ord(TLocalizeState.Done), Ord(TLocalizeState.Done)) <> Ord(TLocalizeState.Done) do
      TThread.Yield; // give up the time slice instead of spinning at 100% CPU
  end;
end;

{ Chrono.TDatePartHelper }

function Chrono.TDatePartHelper.GetName: string;
begin
  Localize;
  Result := gLocalizedDatePart[Self];
end;

function Chrono.TDatePartHelper.GetShortName: string;
begin
  Localize;
  Result := gLocalizedDatePartShort[Self];
end;

{ Chrono.TTimePartHelper }

function Chrono.TTimePartHelper.GetName: string;
begin
  Localize;
  Result := gLocalizedTimePart[Self];
end;

function Chrono.TTimePartHelper.GetShortName: string;
begin
  Localize;
  Result := gLocalizedTimePartShort[Self];
end;

{$IFDEF MSWINDOWS}
procedure Init;
const
  SysDOW: array[0..6] of Word = (2, 3, 4, 5, 6, 7, 1);
var
  A: array[0..1] of Char;
  DOW: Integer;
begin
  try
    GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_IFIRSTDAYOFWEEK, A, SizeOf(A));
    DOW := Ord(A[0]) - Ord('0');
    if DOW in [0..6] then
      Chrono.FirstDayOfWeek := SysDOW[DOW];
  except
  end;
end;
{$ENDIF}

initialization
  // Unconditional initialization BEFORE calling Init: guarantees a valid value
  // (FDay=1, Sunday) even on POSIX (where Init is not compiled at all, see the
  // {$IFDEF MSWINDOWS} below) and even if GetLocaleInfo inside Init fails
  // (the error is caught by an empty except and silently ignored).
  // Without this line FirstDayOfWeek.FDay would stay 0 (the default value of a
  // class var), which is outside TWeekdayNum (1..7) and breaks the indexing of
  // WeekdaysArray/DaysOfWeekArray in every week-related date calculation.
  Chrono.FirstDayOfWeek.FDay := 1;
{$IFDEF MSWINDOWS}
  Init;
{$ENDIF}
  gDefaultCalendar := Chrono.TBasicCalendar.Create;

end.
