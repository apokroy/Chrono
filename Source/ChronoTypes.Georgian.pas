{ ---------------------------------------------------------------------------
  Georgian texts for Chrono: month names, weekday names, names of date and
  time parts and error messages.

    uses ChronoTypes, ChronoTypes.Georgian;
    ...
    Chrono.Locale := GeorgianLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Georgian;

interface

uses
  ChronoTypes;

/// <summary>
///  The Georgian locale. The month and weekday names are those of the ka-GE locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function GeorgianLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'იანვარი'),
    (Key: 'month.february';           Value: 'თებერვალი'),
    (Key: 'month.march';              Value: 'მარტი'),
    (Key: 'month.april';              Value: 'აპრილი'),
    (Key: 'month.may';                Value: 'მაისი'),
    (Key: 'month.june';               Value: 'ივნისი'),
    (Key: 'month.july';               Value: 'ივლისი'),
    (Key: 'month.august';             Value: 'აგვისტო'),
    (Key: 'month.september';          Value: 'სექტემბერი'),
    (Key: 'month.october';            Value: 'ოქტომბერი'),
    (Key: 'month.november';           Value: 'ნოემბერი'),
    (Key: 'month.december';           Value: 'დეკემბერი'),

    (Key: 'month.january.genitive';   Value: 'იანვარი'),
    (Key: 'month.february.genitive';  Value: 'თებერვალი'),
    (Key: 'month.march.genitive';     Value: 'მარტი'),
    (Key: 'month.april.genitive';     Value: 'აპრილი'),
    (Key: 'month.may.genitive';       Value: 'მაისი'),
    (Key: 'month.june.genitive';      Value: 'ივნისი'),
    (Key: 'month.july.genitive';      Value: 'ივლისი'),
    (Key: 'month.august.genitive';    Value: 'აგვისტო'),
    (Key: 'month.september.genitive'; Value: 'სექტემბერი'),
    (Key: 'month.october.genitive';   Value: 'ოქტომბერი'),
    (Key: 'month.november.genitive';  Value: 'ნოემბერი'),
    (Key: 'month.december.genitive';  Value: 'დეკემბერი'),

    (Key: 'month.january.short';      Value: 'იან'),
    (Key: 'month.february.short';     Value: 'თებ'),
    (Key: 'month.march.short';        Value: 'მარ'),
    (Key: 'month.april.short';        Value: 'აპრ'),
    (Key: 'month.may.short';          Value: 'მაი'),
    (Key: 'month.june.short';         Value: 'ივნ'),
    (Key: 'month.july.short';         Value: 'ივლ'),
    (Key: 'month.august.short';       Value: 'აგვ'),
    (Key: 'month.september.short';    Value: 'სექ'),
    (Key: 'month.october.short';      Value: 'ოქტ'),
    (Key: 'month.november.short';     Value: 'ნოე'),
    (Key: 'month.december.short';     Value: 'დეკ'),

    (Key: 'weekday.sunday';           Value: 'კვირა'),
    (Key: 'weekday.monday';           Value: 'ორშაბათი'),
    (Key: 'weekday.tuesday';          Value: 'სამშაბათი'),
    (Key: 'weekday.wednesday';        Value: 'ოთხშაბათი'),
    (Key: 'weekday.thursday';         Value: 'ხუთშაბათი'),
    (Key: 'weekday.friday';           Value: 'პარასკევი'),
    (Key: 'weekday.saturday';         Value: 'შაბათი'),

    (Key: 'weekday.sunday.short';     Value: 'კვი'),
    (Key: 'weekday.monday.short';     Value: 'ორშ'),
    (Key: 'weekday.tuesday.short';    Value: 'სამ'),
    (Key: 'weekday.wednesday.short';  Value: 'ოთხ'),
    (Key: 'weekday.thursday.short';   Value: 'ხუთ'),
    (Key: 'weekday.friday.short';     Value: 'პარ'),
    (Key: 'weekday.saturday.short';   Value: 'შაბ'),

    (Key: 'part.year';                Value: 'წელი'),
    (Key: 'part.quarter';             Value: 'კვარტალი'),
    (Key: 'part.month';               Value: 'თვე'),
    (Key: 'part.week';                Value: 'კვირა'),
    (Key: 'part.day';                 Value: 'დღე'),
    (Key: 'part.year.short';          Value: 'წ'),
    (Key: 'part.quarter.short';       Value: 'კვარტ'),
    (Key: 'part.month.short';         Value: 'თვ'),
    (Key: 'part.week.short';          Value: 'კვ'),
    (Key: 'part.day.short';           Value: 'დღ'),
    (Key: 'part.hour';                Value: 'საათი'),
    (Key: 'part.minute';              Value: 'წუთი'),
    (Key: 'part.second';              Value: 'წამი'),
    (Key: 'part.millisecond';         Value: 'მილიწამი'),
    (Key: 'part.hour.short';          Value: 'სთ'),
    (Key: 'part.minute.short';        Value: 'წთ'),
    (Key: 'part.second.short';        Value: 'წმ'),
    (Key: 'part.millisecond.short';   Value: 'მწმ'),

    (Key: 'error.invalid-time-zone';      Value: 'არასწორი სასაათო სარტყელი "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'კვარტლის არასწორი ჩანაწერი "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'თვის არასწორი სახელი "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'კვირის დღის არასწორი სახელი "%s"'),
    (Key: 'error.invalid-year';           Value: 'არასწორი წელი %d (დასაშვებია %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'არასწორი თვე %d (დასაშვებია 1..12)'),
    (Key: 'error.invalid-day';            Value: 'თვის არასწორი დღე %d (დასაშვებია 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'არასწორი კვარტალი %d (დასაშვებია 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'კვირის არასწორი დღე %d (დასაშვებია 1..7)'),
    (Key: 'error.invalid-date';           Value: 'არასწორი თარიღი: წელი %d, თვე %d, დღე %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'წლის არასწორი დღე %d (%d წელი)'),
    (Key: 'error.date-range';             Value: 'თარიღი 0001-01-01..9999-12-31 დიაპაზონის გარეთაა'),
    (Key: 'error.invalid-time';           Value: 'არასწორი დრო: %d სთ %d წთ %d წმ %d მწმ'),
    (Key: 'error.time-range';             Value: 'დღე-ღამის დრო %d მწმ 00:00:00.000..23:59:59.999 დიაპაზონის გარეთაა')
  );

var
  Georgian: Chrono.TLocale;

function GeorgianLocale: Chrono.TLocale;
begin
  Result := Georgian;
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
  Georgian := Chrono.TLocale.Create('ka', Chrono.TLocale.English, Lookup);

finalization
  Georgian.Free;

end.
