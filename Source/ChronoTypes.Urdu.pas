{ ---------------------------------------------------------------------------
  Urdu texts for Chrono: month names, weekday names, names of date and time
  parts and error messages.

    uses ChronoTypes, ChronoTypes.Urdu;
    ...
    Chrono.Locale := UrduLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Urdu;

interface

uses
  ChronoTypes;

/// <summary>
///  The Urdu locale. The month and weekday names are those of the ur-PK locale of Windows,
///  spelt with the Urdu yeh, kaf and heh (Windows has some Arabic letters), so dates read
///  the same on every platform. The locale is created when the unit is initialized and
///  freed when it is finalized; Chrono.Locale then returns to TLocale.System.
/// </summary>
function UrduLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'جنوری'),
    (Key: 'month.february';           Value: 'فروری'),
    (Key: 'month.march';              Value: 'مارچ'),
    (Key: 'month.april';              Value: 'اپریل'),
    (Key: 'month.may';                Value: 'مئی'),
    (Key: 'month.june';               Value: 'جون'),
    (Key: 'month.july';               Value: 'جولائی'),
    (Key: 'month.august';             Value: 'اگست'),
    (Key: 'month.september';          Value: 'ستمبر'),
    (Key: 'month.october';            Value: 'اکتوبر'),
    (Key: 'month.november';           Value: 'نومبر'),
    (Key: 'month.december';           Value: 'دسمبر'),

    (Key: 'month.january.genitive';   Value: 'جنوری'),
    (Key: 'month.february.genitive';  Value: 'فروری'),
    (Key: 'month.march.genitive';     Value: 'مارچ'),
    (Key: 'month.april.genitive';     Value: 'اپریل'),
    (Key: 'month.may.genitive';       Value: 'مئی'),
    (Key: 'month.june.genitive';      Value: 'جون'),
    (Key: 'month.july.genitive';      Value: 'جولائی'),
    (Key: 'month.august.genitive';    Value: 'اگست'),
    (Key: 'month.september.genitive'; Value: 'ستمبر'),
    (Key: 'month.october.genitive';   Value: 'اکتوبر'),
    (Key: 'month.november.genitive';  Value: 'نومبر'),
    (Key: 'month.december.genitive';  Value: 'دسمبر'),

    (Key: 'month.january.short';      Value: 'جنوری'),
    (Key: 'month.february.short';     Value: 'فروری'),
    (Key: 'month.march.short';        Value: 'مارچ'),
    (Key: 'month.april.short';        Value: 'اپریل'),
    (Key: 'month.may.short';          Value: 'مئی'),
    (Key: 'month.june.short';         Value: 'جون'),
    (Key: 'month.july.short';         Value: 'جولائی'),
    (Key: 'month.august.short';       Value: 'اگست'),
    (Key: 'month.september.short';    Value: 'ستمبر'),
    (Key: 'month.october.short';      Value: 'اکتوبر'),
    (Key: 'month.november.short';     Value: 'نومبر'),
    (Key: 'month.december.short';     Value: 'دسمبر'),

    (Key: 'weekday.sunday';           Value: 'اتوار'),
    (Key: 'weekday.monday';           Value: 'پیر'),
    (Key: 'weekday.tuesday';          Value: 'منگل'),
    (Key: 'weekday.wednesday';        Value: 'بدھ'),
    (Key: 'weekday.thursday';         Value: 'جمعرات'),
    (Key: 'weekday.friday';           Value: 'جمعہ'),
    (Key: 'weekday.saturday';         Value: 'ہفتہ'),

    (Key: 'weekday.sunday.short';     Value: 'اتوار'),
    (Key: 'weekday.monday.short';     Value: 'پیر'),
    (Key: 'weekday.tuesday.short';    Value: 'منگل'),
    (Key: 'weekday.wednesday.short';  Value: 'بدھ'),
    (Key: 'weekday.thursday.short';   Value: 'جمعرات'),
    (Key: 'weekday.friday.short';     Value: 'جمعہ'),
    (Key: 'weekday.saturday.short';   Value: 'ہفتہ'),

    (Key: 'part.year';                Value: 'سال'),
    (Key: 'part.quarter';             Value: 'سہ ماہی'),
    (Key: 'part.month';               Value: 'مہینہ'),
    (Key: 'part.week';                Value: 'ہفتہ'),
    (Key: 'part.day';                 Value: 'دن'),
    (Key: 'part.year.short';          Value: 'سال'),
    (Key: 'part.quarter.short';       Value: 'سہ ماہی'),
    (Key: 'part.month.short';         Value: 'ماہ'),
    (Key: 'part.week.short';          Value: 'ہفتہ'),
    (Key: 'part.day.short';           Value: 'دن'),
    (Key: 'part.hour';                Value: 'گھنٹہ'),
    (Key: 'part.minute';              Value: 'منٹ'),
    (Key: 'part.second';              Value: 'سیکنڈ'),
    (Key: 'part.millisecond';         Value: 'ملی سیکنڈ'),
    (Key: 'part.hour.short';          Value: 'گھنٹہ'),
    (Key: 'part.minute.short';        Value: 'منٹ'),
    (Key: 'part.second.short';        Value: 'سیکنڈ'),
    (Key: 'part.millisecond.short';   Value: 'ملی سیکنڈ'),

    (Key: 'error.invalid-time-zone';      Value: 'غلط ٹائم زون "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'سہ ماہی کی غلط شکل "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'مہینے کا غلط نام "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'ہفتے کے دن کا غلط نام "%s"'),
    (Key: 'error.invalid-year';           Value: 'غلط سال %d (درست حد %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'غلط مہینہ %d (درست حد 1..12)'),
    (Key: 'error.invalid-day';            Value: 'مہینے کا غلط دن %d (درست حد 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'غلط سہ ماہی %d (درست حد 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'ہفتے کا غلط دن %d (درست حد 1..7)'),
    (Key: 'error.invalid-date';           Value: 'غلط تاریخ: سال %d، مہینہ %d، دن %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'سال کا غلط دن %d (سال %d)'),
    (Key: 'error.date-range';             Value: 'تاریخ حد 0001-01-01..9999-12-31 سے باہر ہے'),
    (Key: 'error.invalid-time';           Value: 'غلط وقت: %d گھنٹے %d منٹ %d سیکنڈ %d ملی سیکنڈ'),
    (Key: 'error.time-range';             Value: 'دن کا وقت %d ملی سیکنڈ حد 00:00:00.000..23:59:59.999 سے باہر ہے')
  );

var
  Urdu: Chrono.TLocale;

function UrduLocale: Chrono.TLocale;
begin
  Result := Urdu;
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
  Urdu := Chrono.TLocale.Create('ur', Chrono.TLocale.English, Lookup);

finalization
  Urdu.Free;

end.
