{ ---------------------------------------------------------------------------
  Hindi texts for Chrono: month names, weekday names, names of date and time
  parts and error messages.

    uses ChronoTypes, ChronoTypes.Hindi;
    ...
    Chrono.Locale := HindiLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Hindi;

interface

uses
  ChronoTypes;

/// <summary>
///  The Hindi locale. The month and weekday names are those of the hi-IN locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function HindiLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'जनवरी'),
    (Key: 'month.february';           Value: 'फरवरी'),
    (Key: 'month.march';              Value: 'मार्च'),
    (Key: 'month.april';              Value: 'अप्रैल'),
    (Key: 'month.may';                Value: 'मई'),
    (Key: 'month.june';               Value: 'जून'),
    (Key: 'month.july';               Value: 'जुलाई'),
    (Key: 'month.august';             Value: 'अगस्त'),
    (Key: 'month.september';          Value: 'सितम्बर'),
    (Key: 'month.october';            Value: 'अक्तूबर'),
    (Key: 'month.november';           Value: 'नवम्बर'),
    (Key: 'month.december';           Value: 'दिसम्बर'),

    (Key: 'month.january.genitive';   Value: 'जनवरी'),
    (Key: 'month.february.genitive';  Value: 'फरवरी'),
    (Key: 'month.march.genitive';     Value: 'मार्च'),
    (Key: 'month.april.genitive';     Value: 'अप्रैल'),
    (Key: 'month.may.genitive';       Value: 'मई'),
    (Key: 'month.june.genitive';      Value: 'जून'),
    (Key: 'month.july.genitive';      Value: 'जुलाई'),
    (Key: 'month.august.genitive';    Value: 'अगस्त'),
    (Key: 'month.september.genitive'; Value: 'सितम्बर'),
    (Key: 'month.october.genitive';   Value: 'अक्तूबर'),
    (Key: 'month.november.genitive';  Value: 'नवम्बर'),
    (Key: 'month.december.genitive';  Value: 'दिसम्बर'),

    (Key: 'month.january.short';      Value: 'जनवरी'),
    (Key: 'month.february.short';     Value: 'फरवरी'),
    (Key: 'month.march.short';        Value: 'मार्च'),
    (Key: 'month.april.short';        Value: 'अप्रैल'),
    (Key: 'month.may.short';          Value: 'मई'),
    (Key: 'month.june.short';         Value: 'जून'),
    (Key: 'month.july.short';         Value: 'जुलाई'),
    (Key: 'month.august.short';       Value: 'अगस्त'),
    (Key: 'month.september.short';    Value: 'सितम्बर'),
    (Key: 'month.october.short';      Value: 'अक्तूबर'),
    (Key: 'month.november.short';     Value: 'नवम्बर'),
    (Key: 'month.december.short';     Value: 'दिसम्बर'),

    (Key: 'weekday.sunday';           Value: 'रविवार'),
    (Key: 'weekday.monday';           Value: 'सोमवार'),
    (Key: 'weekday.tuesday';          Value: 'मंगलवार'),
    (Key: 'weekday.wednesday';        Value: 'बुधवार'),
    (Key: 'weekday.thursday';         Value: 'गुरुवार'),
    (Key: 'weekday.friday';           Value: 'शुक्रवार'),
    (Key: 'weekday.saturday';         Value: 'शनिवार'),

    (Key: 'weekday.sunday.short';     Value: 'रवि.'),
    (Key: 'weekday.monday.short';     Value: 'सोम.'),
    (Key: 'weekday.tuesday.short';    Value: 'मंगल.'),
    (Key: 'weekday.wednesday.short';  Value: 'बुध.'),
    (Key: 'weekday.thursday.short';   Value: 'गुरु.'),
    (Key: 'weekday.friday.short';     Value: 'शुक्र.'),
    (Key: 'weekday.saturday.short';   Value: 'शनि.'),

    (Key: 'part.year';                Value: 'वर्ष'),
    (Key: 'part.quarter';             Value: 'तिमाही'),
    (Key: 'part.month';               Value: 'महीना'),
    (Key: 'part.week';                Value: 'सप्ताह'),
    (Key: 'part.day';                 Value: 'दिन'),
    (Key: 'part.year.short';          Value: 'वर्ष'),
    (Key: 'part.quarter.short';       Value: 'तिमाही'),
    (Key: 'part.month.short';         Value: 'माह'),
    (Key: 'part.week.short';          Value: 'सप्ताह'),
    (Key: 'part.day.short';           Value: 'दिन'),
    (Key: 'part.hour';                Value: 'घंटा'),
    (Key: 'part.minute';              Value: 'मिनट'),
    (Key: 'part.second';              Value: 'सेकंड'),
    (Key: 'part.millisecond';         Value: 'मिलीसेकंड'),
    (Key: 'part.hour.short';          Value: 'घं'),
    (Key: 'part.minute.short';        Value: 'मि'),
    (Key: 'part.second.short';        Value: 'से'),
    (Key: 'part.millisecond.short';   Value: 'मि.से.'),

    (Key: 'error.invalid-time-zone';      Value: 'अमान्य समय क्षेत्र "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'अमान्य तिमाही प्रारूप "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'अमान्य महीने का नाम "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'सप्ताह के दिन का अमान्य नाम "%s"'),
    (Key: 'error.invalid-year';           Value: 'अमान्य वर्ष %d (मान्य सीमा %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'अमान्य महीना %d (मान्य सीमा 1..12)'),
    (Key: 'error.invalid-day';            Value: 'महीने का अमान्य दिन %d (मान्य सीमा 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'अमान्य तिमाही %d (मान्य सीमा 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'सप्ताह का अमान्य दिन %d (मान्य सीमा 1..7)'),
    (Key: 'error.invalid-date';           Value: 'अमान्य तिथि: वर्ष %d, महीना %d, दिन %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'वर्ष का अमान्य दिन %d (वर्ष %d)'),
    (Key: 'error.date-range';             Value: 'तिथि सीमा 0001-01-01..9999-12-31 से बाहर है'),
    (Key: 'error.invalid-time';           Value: 'अमान्य समय: %d घंटे %d मिनट %d सेकंड %d मिलीसेकंड'),
    (Key: 'error.time-range';             Value: 'दिन का समय %d मि.से. सीमा 00:00:00.000..23:59:59.999 से बाहर है')
  );

var
  Hindi: Chrono.TLocale;

function HindiLocale: Chrono.TLocale;
begin
  Result := Hindi;
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
  Hindi := Chrono.TLocale.Create('hi', Chrono.TLocale.English, Lookup);

finalization
  Hindi.Free;

end.
