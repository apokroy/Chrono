{ ---------------------------------------------------------------------------
  Bengali texts for Chrono: month names, weekday names, names of date and time
  parts and error messages.

    uses ChronoTypes, ChronoTypes.Bengali;
    ...
    Chrono.Locale := BengaliLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Bengali;

interface

uses
  ChronoTypes;

/// <summary>
///  The Bengali locale. The month and weekday names are those of the bn-BD locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function BengaliLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'জানুয়ারী'),
    (Key: 'month.february';           Value: 'ফেব্রুয়ারী'),
    (Key: 'month.march';              Value: 'মার্চ'),
    (Key: 'month.april';              Value: 'এপ্রিল'),
    (Key: 'month.may';                Value: 'মে'),
    (Key: 'month.june';               Value: 'জুন'),
    (Key: 'month.july';               Value: 'জুলাই'),
    (Key: 'month.august';             Value: 'আগস্ট'),
    (Key: 'month.september';          Value: 'সেপ্টেম্বর'),
    (Key: 'month.october';            Value: 'অক্টোবর'),
    (Key: 'month.november';           Value: 'নভেম্বর'),
    (Key: 'month.december';           Value: 'ডিসেম্বর'),

    (Key: 'month.january.genitive';   Value: 'জানুয়ারী'),
    (Key: 'month.february.genitive';  Value: 'ফেব্রুয়ারী'),
    (Key: 'month.march.genitive';     Value: 'মার্চ'),
    (Key: 'month.april.genitive';     Value: 'এপ্রিল'),
    (Key: 'month.may.genitive';       Value: 'মে'),
    (Key: 'month.june.genitive';      Value: 'জুন'),
    (Key: 'month.july.genitive';      Value: 'জুলাই'),
    (Key: 'month.august.genitive';    Value: 'আগস্ট'),
    (Key: 'month.september.genitive'; Value: 'সেপ্টেম্বর'),
    (Key: 'month.october.genitive';   Value: 'অক্টোবর'),
    (Key: 'month.november.genitive';  Value: 'নভেম্বর'),
    (Key: 'month.december.genitive';  Value: 'ডিসেম্বর'),

    (Key: 'month.january.short';      Value: 'জানু'),
    (Key: 'month.february.short';     Value: 'ফেব'),
    (Key: 'month.march.short';        Value: 'মার্চ'),
    (Key: 'month.april.short';        Value: 'এপ্রিল'),
    (Key: 'month.may.short';          Value: 'মে'),
    (Key: 'month.june.short';         Value: 'জুন'),
    (Key: 'month.july.short';         Value: 'জুলাই'),
    (Key: 'month.august.short';       Value: 'আগস্ট'),
    (Key: 'month.september.short';    Value: 'সেপ্টেম্বর'),
    (Key: 'month.october.short';      Value: 'অক্টোবর'),
    (Key: 'month.november.short';     Value: 'নভেম্বর'),
    (Key: 'month.december.short';     Value: 'ডিসেম্বর'),

    (Key: 'weekday.sunday';           Value: 'রবিবার'),
    (Key: 'weekday.monday';           Value: 'সোমবার'),
    (Key: 'weekday.tuesday';          Value: 'মঙ্গলবার'),
    (Key: 'weekday.wednesday';        Value: 'বুধবার'),
    (Key: 'weekday.thursday';         Value: 'বৃহস্পতিবার'),
    (Key: 'weekday.friday';           Value: 'শুক্রবার'),
    (Key: 'weekday.saturday';         Value: 'শনিবার'),

    (Key: 'weekday.sunday.short';     Value: 'রবি'),
    (Key: 'weekday.monday.short';     Value: 'সোম'),
    (Key: 'weekday.tuesday.short';    Value: 'মঙ্গল'),
    (Key: 'weekday.wednesday.short';  Value: 'বুধ'),
    (Key: 'weekday.thursday.short';   Value: 'বৃহস্পতি'),
    (Key: 'weekday.friday.short';     Value: 'শুক্র'),
    (Key: 'weekday.saturday.short';   Value: 'শনি'),

    (Key: 'part.year';                Value: 'বছর'),
    (Key: 'part.quarter';             Value: 'ত্রৈমাসিক'),
    (Key: 'part.month';               Value: 'মাস'),
    (Key: 'part.week';                Value: 'সপ্তাহ'),
    (Key: 'part.day';                 Value: 'দিন'),
    (Key: 'part.year.short';          Value: 'বছর'),
    (Key: 'part.quarter.short';       Value: 'ত্রৈমাসিক'),
    (Key: 'part.month.short';         Value: 'মাস'),
    (Key: 'part.week.short';          Value: 'সপ্তাহ'),
    (Key: 'part.day.short';           Value: 'দিন'),
    (Key: 'part.hour';                Value: 'ঘণ্টা'),
    (Key: 'part.minute';              Value: 'মিনিট'),
    (Key: 'part.second';              Value: 'সেকেন্ড'),
    (Key: 'part.millisecond';         Value: 'মিলিসেকেন্ড'),
    (Key: 'part.hour.short';          Value: 'ঘ'),
    (Key: 'part.minute.short';        Value: 'মি'),
    (Key: 'part.second.short';        Value: 'সে'),
    (Key: 'part.millisecond.short';   Value: 'মিসে'),

    (Key: 'error.invalid-time-zone';      Value: 'অবৈধ সময় অঞ্চল "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'ত্রৈমাসিকের অবৈধ বিন্যাস "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'মাসের অবৈধ নাম "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'সপ্তাহের দিনের অবৈধ নাম "%s"'),
    (Key: 'error.invalid-year';           Value: 'অবৈধ বছর %d (বৈধ পরিসর %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'অবৈধ মাস %d (বৈধ পরিসর 1..12)'),
    (Key: 'error.invalid-day';            Value: 'মাসের অবৈধ দিন %d (বৈধ পরিসর 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'অবৈধ ত্রৈমাসিক %d (বৈধ পরিসর 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'সপ্তাহের অবৈধ দিন %d (বৈধ পরিসর 1..7)'),
    (Key: 'error.invalid-date';           Value: 'অবৈধ তারিখ: বছর %d, মাস %d, দিন %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'বছরের অবৈধ দিন %d (বছর %d)'),
    (Key: 'error.date-range';             Value: 'তারিখ 0001-01-01..9999-12-31 পরিসরের বাইরে'),
    (Key: 'error.invalid-time';           Value: 'অবৈধ সময়: %d ঘণ্টা %d মিনিট %d সেকেন্ড %d মিলিসেকেন্ড'),
    (Key: 'error.time-range';             Value: 'দিনের সময় %d মিলিসেকেন্ড 00:00:00.000..23:59:59.999 পরিসরের বাইরে')
  );

var
  Bengali: Chrono.TLocale;

function BengaliLocale: Chrono.TLocale;
begin
  Result := Bengali;
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
  Bengali := Chrono.TLocale.Create('bn', Chrono.TLocale.English, Lookup);

finalization
  Bengali.Free;

end.
