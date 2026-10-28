{ ---------------------------------------------------------------------------
  Persian texts for Chrono: month names, weekday names, names of date and time
  parts and error messages.

    uses ChronoTypes, ChronoTypes.Persian;
    ...
    Chrono.Locale := PersianLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Persian;

interface

uses
  ChronoTypes;

/// <summary>
///  The Persian locale. The month and weekday names are those of the Gregorian calendar of
///  the fa-IR locale of Windows, spelt with the Persian yeh and kaf (Windows has the
///  Arabic letters), so dates read the same on every platform. The locale is created when
///  the unit is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function PersianLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'ژانویه'),
    (Key: 'month.february';           Value: 'فوریه'),
    (Key: 'month.march';              Value: 'مارس'),
    (Key: 'month.april';              Value: 'آوریل'),
    (Key: 'month.may';                Value: 'مه'),
    (Key: 'month.june';               Value: 'ژوئن'),
    (Key: 'month.july';               Value: 'ژوئیه'),
    (Key: 'month.august';             Value: 'اوت'),
    (Key: 'month.september';          Value: 'سپتامبر'),
    (Key: 'month.october';            Value: 'اکتبر'),
    (Key: 'month.november';           Value: 'نوامبر'),
    (Key: 'month.december';           Value: 'دسامبر'),

    (Key: 'month.january.genitive';   Value: 'ژانویه'),
    (Key: 'month.february.genitive';  Value: 'فوریه'),
    (Key: 'month.march.genitive';     Value: 'مارس'),
    (Key: 'month.april.genitive';     Value: 'آوریل'),
    (Key: 'month.may.genitive';       Value: 'مه'),
    (Key: 'month.june.genitive';      Value: 'ژوئن'),
    (Key: 'month.july.genitive';      Value: 'ژوئیه'),
    (Key: 'month.august.genitive';    Value: 'اوت'),
    (Key: 'month.september.genitive'; Value: 'سپتامبر'),
    (Key: 'month.october.genitive';   Value: 'اکتبر'),
    (Key: 'month.november.genitive';  Value: 'نوامبر'),
    (Key: 'month.december.genitive';  Value: 'دسامبر'),

    (Key: 'month.january.short';      Value: 'ژانویه'),
    (Key: 'month.february.short';     Value: 'فوریه'),
    (Key: 'month.march.short';        Value: 'مارس'),
    (Key: 'month.april.short';        Value: 'آوریل'),
    (Key: 'month.may.short';          Value: 'مه'),
    (Key: 'month.june.short';         Value: 'ژوئن'),
    (Key: 'month.july.short';         Value: 'ژوئیه'),
    (Key: 'month.august.short';       Value: 'اوت'),
    (Key: 'month.september.short';    Value: 'سپتامبر'),
    (Key: 'month.october.short';      Value: 'اکتبر'),
    (Key: 'month.november.short';     Value: 'نوامبر'),
    (Key: 'month.december.short';     Value: 'دسامبر'),

    (Key: 'weekday.sunday';           Value: 'یکشنبه'),
    (Key: 'weekday.monday';           Value: 'دوشنبه'),
    (Key: 'weekday.tuesday';          Value: 'سه شنبه'),
    (Key: 'weekday.wednesday';        Value: 'چهارشنبه'),
    (Key: 'weekday.thursday';         Value: 'پنجشنبه'),
    (Key: 'weekday.friday';           Value: 'جمعه'),
    (Key: 'weekday.saturday';         Value: 'شنبه'),

    (Key: 'weekday.sunday.short';     Value: 'یکشنبه'),
    (Key: 'weekday.monday.short';     Value: 'دوشنبه'),
    (Key: 'weekday.tuesday.short';    Value: 'سه شنبه'),
    (Key: 'weekday.wednesday.short';  Value: 'چهارشنبه'),
    (Key: 'weekday.thursday.short';   Value: 'پنجشنبه'),
    (Key: 'weekday.friday.short';     Value: 'جمعه'),
    (Key: 'weekday.saturday.short';   Value: 'شنبه'),

    (Key: 'part.year';                Value: 'سال'),
    (Key: 'part.quarter';             Value: 'فصل'),
    (Key: 'part.month';               Value: 'ماه'),
    (Key: 'part.week';                Value: 'هفته'),
    (Key: 'part.day';                 Value: 'روز'),
    (Key: 'part.year.short';          Value: 'سال'),
    (Key: 'part.quarter.short';       Value: 'فصل'),
    (Key: 'part.month.short';         Value: 'ماه'),
    (Key: 'part.week.short';          Value: 'هفته'),
    (Key: 'part.day.short';           Value: 'روز'),
    (Key: 'part.hour';                Value: 'ساعت'),
    (Key: 'part.minute';              Value: 'دقیقه'),
    (Key: 'part.second';              Value: 'ثانیه'),
    (Key: 'part.millisecond';         Value: 'میلی ثانیه'),
    (Key: 'part.hour.short';          Value: 'ساعت'),
    (Key: 'part.minute.short';        Value: 'دقیقه'),
    (Key: 'part.second.short';        Value: 'ثانیه'),
    (Key: 'part.millisecond.short';   Value: 'میلی ثانیه'),

    (Key: 'error.invalid-time-zone';      Value: 'منطقه زمانی نامعتبر "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'قالب نامعتبر فصل "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'نام ماه نامعتبر "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'نام روز هفته نامعتبر "%s"'),
    (Key: 'error.invalid-year';           Value: 'سال نامعتبر %d (محدوده مجاز %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'ماه نامعتبر %d (محدوده مجاز 1..12)'),
    (Key: 'error.invalid-day';            Value: 'روز ماه نامعتبر %d (محدوده مجاز 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'فصل نامعتبر %d (محدوده مجاز 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'روز هفته نامعتبر %d (محدوده مجاز 1..7)'),
    (Key: 'error.invalid-date';           Value: 'تاریخ نامعتبر: سال %d، ماه %d، روز %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'روز سال نامعتبر %d در سال %d'),
    (Key: 'error.date-range';             Value: 'تاریخ خارج از محدوده 0001-01-01..9999-12-31 است'),
    (Key: 'error.invalid-time';           Value: 'زمان نامعتبر: %d ساعت %d دقیقه %d ثانیه %d میلی ثانیه'),
    (Key: 'error.time-range';             Value: 'زمان روز %d میلی ثانیه خارج از محدوده 00:00:00.000..23:59:59.999 است')
  );

var
  Persian: Chrono.TLocale;

function PersianLocale: Chrono.TLocale;
begin
  Result := Persian;
end;

// Without const: the signature of TFunc<string, string>.
function Lookup(Key: string): string;
var
  I: Integer;
begin
  for I := Low(Texts) to High(Texts) do
    if Texts[I].Key = Key then
      Exit(Texts[I].Value);
  Result := '';
end;

initialization
  Persian := Chrono.TLocale.Create('fa', Chrono.TLocale.English, Lookup);

finalization
  Persian.Free;

end.
