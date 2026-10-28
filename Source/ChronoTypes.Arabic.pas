{ ---------------------------------------------------------------------------
  Arabic texts for Chrono: month names, weekday names, names of date and time
  parts and error messages.

    uses ChronoTypes, ChronoTypes.Arabic;
    ...
    Chrono.Locale := ArabicLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Arabic;

interface

uses
  ChronoTypes;

/// <summary>
///  The Arabic locale. The month and weekday names are those of the Gregorian calendar of
///  the ar-EG and ar-SA locales of Windows (they are the same), so dates read the same on
///  every platform. The locale is created when the unit is initialized and freed when it
///  is finalized; Chrono.Locale then returns to TLocale.System.
/// </summary>
function ArabicLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'يناير'),
    (Key: 'month.february';           Value: 'فبراير'),
    (Key: 'month.march';              Value: 'مارس'),
    (Key: 'month.april';              Value: 'أبريل'),
    (Key: 'month.may';                Value: 'مايو'),
    (Key: 'month.june';               Value: 'يونيو'),
    (Key: 'month.july';               Value: 'يوليو'),
    (Key: 'month.august';             Value: 'أغسطس'),
    (Key: 'month.september';          Value: 'سبتمبر'),
    (Key: 'month.october';            Value: 'أكتوبر'),
    (Key: 'month.november';           Value: 'نوفمبر'),
    (Key: 'month.december';           Value: 'ديسمبر'),

    (Key: 'month.january.genitive';   Value: 'يناير'),
    (Key: 'month.february.genitive';  Value: 'فبراير'),
    (Key: 'month.march.genitive';     Value: 'مارس'),
    (Key: 'month.april.genitive';     Value: 'أبريل'),
    (Key: 'month.may.genitive';       Value: 'مايو'),
    (Key: 'month.june.genitive';      Value: 'يونيو'),
    (Key: 'month.july.genitive';      Value: 'يوليو'),
    (Key: 'month.august.genitive';    Value: 'أغسطس'),
    (Key: 'month.september.genitive'; Value: 'سبتمبر'),
    (Key: 'month.october.genitive';   Value: 'أكتوبر'),
    (Key: 'month.november.genitive';  Value: 'نوفمبر'),
    (Key: 'month.december.genitive';  Value: 'ديسمبر'),

    (Key: 'month.january.short';      Value: 'يناير'),
    (Key: 'month.february.short';     Value: 'فبراير'),
    (Key: 'month.march.short';        Value: 'مارس'),
    (Key: 'month.april.short';        Value: 'أبريل'),
    (Key: 'month.may.short';          Value: 'مايو'),
    (Key: 'month.june.short';         Value: 'يونيو'),
    (Key: 'month.july.short';         Value: 'يوليو'),
    (Key: 'month.august.short';       Value: 'أغسطس'),
    (Key: 'month.september.short';    Value: 'سبتمبر'),
    (Key: 'month.october.short';      Value: 'أكتوبر'),
    (Key: 'month.november.short';     Value: 'نوفمبر'),
    (Key: 'month.december.short';     Value: 'ديسمبر'),

    (Key: 'weekday.sunday';           Value: 'الأحد'),
    (Key: 'weekday.monday';           Value: 'الإثنين'),
    (Key: 'weekday.tuesday';          Value: 'الثلاثاء'),
    (Key: 'weekday.wednesday';        Value: 'الأربعاء'),
    (Key: 'weekday.thursday';         Value: 'الخميس'),
    (Key: 'weekday.friday';           Value: 'الجمعة'),
    (Key: 'weekday.saturday';         Value: 'السبت'),

    (Key: 'weekday.sunday.short';     Value: 'الأحد'),
    (Key: 'weekday.monday.short';     Value: 'الإثنين'),
    (Key: 'weekday.tuesday.short';    Value: 'الثلاثاء'),
    (Key: 'weekday.wednesday.short';  Value: 'الأربعاء'),
    (Key: 'weekday.thursday.short';   Value: 'الخميس'),
    (Key: 'weekday.friday.short';     Value: 'الجمعة'),
    (Key: 'weekday.saturday.short';   Value: 'السبت'),

    (Key: 'part.year';                Value: 'سنة'),
    (Key: 'part.quarter';             Value: 'ربع سنة'),
    (Key: 'part.month';               Value: 'شهر'),
    (Key: 'part.week';                Value: 'أسبوع'),
    (Key: 'part.day';                 Value: 'يوم'),
    (Key: 'part.year.short';          Value: 'سنة'),
    (Key: 'part.quarter.short';       Value: 'ربع'),
    (Key: 'part.month.short';         Value: 'شهر'),
    (Key: 'part.week.short';          Value: 'أسبوع'),
    (Key: 'part.day.short';           Value: 'يوم'),
    (Key: 'part.hour';                Value: 'ساعة'),
    (Key: 'part.minute';              Value: 'دقيقة'),
    (Key: 'part.second';              Value: 'ثانية'),
    (Key: 'part.millisecond';         Value: 'ملي ثانية'),
    (Key: 'part.hour.short';          Value: 'س'),
    (Key: 'part.minute.short';        Value: 'د'),
    (Key: 'part.second.short';        Value: 'ث'),
    (Key: 'part.millisecond.short';   Value: 'مث'),

    (Key: 'error.invalid-time-zone';      Value: 'منطقة زمنية غير صالحة "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'تنسيق ربع سنة غير صالح "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'اسم شهر غير صالح "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'اسم يوم من أيام الأسبوع غير صالح "%s"'),
    (Key: 'error.invalid-year';           Value: 'سنة غير صالحة %d (النطاق المسموح %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'شهر غير صالح %d (النطاق المسموح 1..12)'),
    (Key: 'error.invalid-day';            Value: 'يوم من الشهر غير صالح %d (النطاق المسموح 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'ربع سنة غير صالح %d (النطاق المسموح 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'يوم من الأسبوع غير صالح %d (النطاق المسموح 1..7)'),
    (Key: 'error.invalid-date';           Value: 'تاريخ غير صالح: السنة %d، الشهر %d، اليوم %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'يوم من السنة غير صالح %d في السنة %d'),
    (Key: 'error.date-range';             Value: 'التاريخ خارج النطاق 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'وقت غير صالح: %d س %d د %d ث %d مث'),
    (Key: 'error.time-range';             Value: 'الوقت من اليوم %d مث خارج النطاق 00:00:00.000..23:59:59.999')
  );

var
  Arabic: Chrono.TLocale;

function ArabicLocale: Chrono.TLocale;
begin
  Result := Arabic;
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
  Arabic := Chrono.TLocale.Create('ar', Chrono.TLocale.English, Lookup);

finalization
  Arabic.Free;

end.
