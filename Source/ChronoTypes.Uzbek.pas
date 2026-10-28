{ ---------------------------------------------------------------------------
  Uzbek (Latin) texts for Chrono: month names (nominative and genitive),
  weekday names, names of date and time parts and error messages.

    uses ChronoTypes, ChronoTypes.Uzbek;
    ...
    Chrono.Locale := UzbekLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Uzbek;

interface

uses
  ChronoTypes;

/// <summary>
///  The Uzbek (Latin) locale. The month and weekday names are those of the uz-Latn-UZ
///  locale of Windows, so dates read the same on every platform. The locale is created
///  when the unit is initialized and freed when it is finalized; Chrono.Locale then
///  returns to TLocale.System.
/// </summary>
function UzbekLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'Yanvar'),
    (Key: 'month.february';           Value: 'Fevral'),
    (Key: 'month.march';              Value: 'Mart'),
    (Key: 'month.april';              Value: 'Aprel'),
    (Key: 'month.may';                Value: 'May'),
    (Key: 'month.june';               Value: 'Iyun'),
    (Key: 'month.july';               Value: 'Iyul'),
    (Key: 'month.august';             Value: 'Avgust'),
    (Key: 'month.september';          Value: 'Sentabr'),
    (Key: 'month.october';            Value: 'Oktabr'),
    (Key: 'month.november';           Value: 'Noyabr'),
    (Key: 'month.december';           Value: 'Dekabr'),

    (Key: 'month.january.genitive';   Value: 'yanvar'),
    (Key: 'month.february.genitive';  Value: 'fevral'),
    (Key: 'month.march.genitive';     Value: 'mart'),
    (Key: 'month.april.genitive';     Value: 'aprel'),
    (Key: 'month.may.genitive';       Value: 'may'),
    (Key: 'month.june.genitive';      Value: 'iyun'),
    (Key: 'month.july.genitive';      Value: 'iyul'),
    (Key: 'month.august.genitive';    Value: 'avgust'),
    (Key: 'month.september.genitive'; Value: 'sentabr'),
    (Key: 'month.october.genitive';   Value: 'oktabr'),
    (Key: 'month.november.genitive';  Value: 'noyabr'),
    (Key: 'month.december.genitive';  Value: 'dekabr'),

    (Key: 'month.january.short';      Value: 'Yan'),
    (Key: 'month.february.short';     Value: 'Fev'),
    (Key: 'month.march.short';        Value: 'Mar'),
    (Key: 'month.april.short';        Value: 'Apr'),
    (Key: 'month.may.short';          Value: 'May'),
    (Key: 'month.june.short';         Value: 'Iyn'),
    (Key: 'month.july.short';         Value: 'Iyl'),
    (Key: 'month.august.short';       Value: 'Avg'),
    (Key: 'month.september.short';    Value: 'Sen'),
    (Key: 'month.october.short';      Value: 'Okt'),
    (Key: 'month.november.short';     Value: 'Noy'),
    (Key: 'month.december.short';     Value: 'Dek'),

    (Key: 'weekday.sunday';           Value: 'yakshanba'),
    (Key: 'weekday.monday';           Value: 'dushanba'),
    (Key: 'weekday.tuesday';          Value: 'seshanba'),
    (Key: 'weekday.wednesday';        Value: 'chorshanba'),
    (Key: 'weekday.thursday';         Value: 'payshanba'),
    (Key: 'weekday.friday';           Value: 'juma'),
    (Key: 'weekday.saturday';         Value: 'shanba'),

    (Key: 'weekday.sunday.short';     Value: 'Yak'),
    (Key: 'weekday.monday.short';     Value: 'Dush'),
    (Key: 'weekday.tuesday.short';    Value: 'Sesh'),
    (Key: 'weekday.wednesday.short';  Value: 'Chor'),
    (Key: 'weekday.thursday.short';   Value: 'Pay'),
    (Key: 'weekday.friday.short';     Value: 'Jum'),
    (Key: 'weekday.saturday.short';   Value: 'Shan'),

    (Key: 'part.year';                Value: 'Yil'),
    (Key: 'part.quarter';             Value: 'Chorak'),
    (Key: 'part.month';               Value: 'Oy'),
    (Key: 'part.week';                Value: 'Hafta'),
    (Key: 'part.day';                 Value: 'Kun'),
    (Key: 'part.year.short';          Value: 'yil'),
    (Key: 'part.quarter.short';       Value: 'chor'),
    (Key: 'part.month.short';         Value: 'oy'),
    (Key: 'part.week.short';          Value: 'hafta'),
    (Key: 'part.day.short';           Value: 'kun'),
    (Key: 'part.hour';                Value: 'Soat'),
    (Key: 'part.minute';              Value: 'Daqiqa'),
    (Key: 'part.second';              Value: 'Soniya'),
    (Key: 'part.millisecond';         Value: 'Millisoniya'),
    (Key: 'part.hour.short';          Value: 'soat'),
    (Key: 'part.minute.short';        Value: 'daq'),
    (Key: 'part.second.short';        Value: 'son'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Notoʻgʻri vaqt mintaqasi "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Chorakning notoʻgʻri yozuvi "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Oyning notoʻgʻri nomi "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Hafta kunining notoʻgʻri nomi "%s"'),
    (Key: 'error.invalid-year';           Value: 'Notoʻgʻri yil %d (ruxsat etilgan %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Notoʻgʻri oy %d (ruxsat etilgan 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Oyning notoʻgʻri kuni %d (ruxsat etilgan 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Notoʻgʻri chorak %d (ruxsat etilgan 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Hafta kunining notoʻgʻri raqami %d (ruxsat etilgan 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Notoʻgʻri sana: yil %d, oy %d, kun %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Yilning notoʻgʻri kuni %d (yil %d)'),
    (Key: 'error.date-range';             Value: 'Sana 0001-01-01..9999-12-31 oraligʻidan tashqarida'),
    (Key: 'error.invalid-time';           Value: 'Notoʻgʻri vaqt: %d soat %d daq %d son %d ms'),
    (Key: 'error.time-range';             Value: 'Kun vaqti %d ms 00:00:00.000..23:59:59.999 oraligʻidan tashqarida')
  );

var
  Uzbek: Chrono.TLocale;

function UzbekLocale: Chrono.TLocale;
begin
  Result := Uzbek;
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
  Uzbek := Chrono.TLocale.Create('uz', Chrono.TLocale.English, Lookup);

finalization
  Uzbek.Free;

end.
