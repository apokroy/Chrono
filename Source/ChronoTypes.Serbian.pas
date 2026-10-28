{ ---------------------------------------------------------------------------
  Serbian (Cyrillic) texts for Chrono: month names, weekday names, names of
  date and time parts and error messages.

    uses ChronoTypes, ChronoTypes.Serbian;
    ...
    Chrono.Locale := SerbianLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Serbian;

interface

uses
  ChronoTypes;

/// <summary>
///  The Serbian (Cyrillic) locale. The month and weekday names are those of the sr-Cyrl-RS
///  locale of Windows, so dates read the same on every platform. The locale is created
///  when the unit is initialized and freed when it is finalized; Chrono.Locale then
///  returns to TLocale.System.
/// </summary>
function SerbianLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'јануар'),
    (Key: 'month.february';           Value: 'фебруар'),
    (Key: 'month.march';              Value: 'март'),
    (Key: 'month.april';              Value: 'април'),
    (Key: 'month.may';                Value: 'мај'),
    (Key: 'month.june';               Value: 'јун'),
    (Key: 'month.july';               Value: 'јул'),
    (Key: 'month.august';             Value: 'август'),
    (Key: 'month.september';          Value: 'септембар'),
    (Key: 'month.october';            Value: 'октобар'),
    (Key: 'month.november';           Value: 'новембар'),
    (Key: 'month.december';           Value: 'децембар'),

    (Key: 'month.january.genitive';   Value: 'јануар'),
    (Key: 'month.february.genitive';  Value: 'фебруар'),
    (Key: 'month.march.genitive';     Value: 'март'),
    (Key: 'month.april.genitive';     Value: 'април'),
    (Key: 'month.may.genitive';       Value: 'мај'),
    (Key: 'month.june.genitive';      Value: 'јун'),
    (Key: 'month.july.genitive';      Value: 'јул'),
    (Key: 'month.august.genitive';    Value: 'август'),
    (Key: 'month.september.genitive'; Value: 'септембар'),
    (Key: 'month.october.genitive';   Value: 'октобар'),
    (Key: 'month.november.genitive';  Value: 'новембар'),
    (Key: 'month.december.genitive';  Value: 'децембар'),

    (Key: 'month.january.short';      Value: 'јан.'),
    (Key: 'month.february.short';     Value: 'феб.'),
    (Key: 'month.march.short';        Value: 'март'),
    (Key: 'month.april.short';        Value: 'апр.'),
    (Key: 'month.may.short';          Value: 'мај'),
    (Key: 'month.june.short';         Value: 'јун'),
    (Key: 'month.july.short';         Value: 'јул'),
    (Key: 'month.august.short';       Value: 'авг.'),
    (Key: 'month.september.short';    Value: 'септ.'),
    (Key: 'month.october.short';      Value: 'окт.'),
    (Key: 'month.november.short';     Value: 'нов.'),
    (Key: 'month.december.short';     Value: 'дец.'),

    (Key: 'weekday.sunday';           Value: 'недеља'),
    (Key: 'weekday.monday';           Value: 'понедељак'),
    (Key: 'weekday.tuesday';          Value: 'уторак'),
    (Key: 'weekday.wednesday';        Value: 'среда'),
    (Key: 'weekday.thursday';         Value: 'четвртак'),
    (Key: 'weekday.friday';           Value: 'петак'),
    (Key: 'weekday.saturday';         Value: 'субота'),

    (Key: 'weekday.sunday.short';     Value: 'нед.'),
    (Key: 'weekday.monday.short';     Value: 'пон.'),
    (Key: 'weekday.tuesday.short';    Value: 'ут.'),
    (Key: 'weekday.wednesday.short';  Value: 'ср.'),
    (Key: 'weekday.thursday.short';   Value: 'чет.'),
    (Key: 'weekday.friday.short';     Value: 'пет.'),
    (Key: 'weekday.saturday.short';   Value: 'суб.'),

    (Key: 'part.year';                Value: 'Година'),
    (Key: 'part.quarter';             Value: 'Квартал'),
    (Key: 'part.month';               Value: 'Месец'),
    (Key: 'part.week';                Value: 'Недеља'),
    (Key: 'part.day';                 Value: 'Дан'),
    (Key: 'part.year.short';          Value: 'г'),
    (Key: 'part.quarter.short';       Value: 'кв'),
    (Key: 'part.month.short';         Value: 'мес'),
    (Key: 'part.week.short';          Value: 'нед'),
    (Key: 'part.day.short';           Value: 'д'),
    (Key: 'part.hour';                Value: 'Сат'),
    (Key: 'part.minute';              Value: 'Минут'),
    (Key: 'part.second';              Value: 'Секунда'),
    (Key: 'part.millisecond';         Value: 'Милисекунда'),
    (Key: 'part.hour.short';          Value: 'ч'),
    (Key: 'part.minute.short';        Value: 'мин'),
    (Key: 'part.second.short';        Value: 'с'),
    (Key: 'part.millisecond.short';   Value: 'мс'),

    (Key: 'error.invalid-time-zone';      Value: 'Неисправна временска зона "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Неисправан запис квартала "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Неисправан назив месеца "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Неисправан назив дана у недељи "%s"'),
    (Key: 'error.invalid-year';           Value: 'Неисправна година %d (дозвољено %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Неисправан месец %d (дозвољено 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Неисправан дан у месецу %d (дозвољено 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Неисправан квартал %d (дозвољено 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Неисправан дан у недељи %d (дозвољено 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Неисправан датум: година %d, месец %d, дан %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Неисправан дан %d у години %d'),
    (Key: 'error.date-range';             Value: 'Датум је ван опсега 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Неисправно време: %d ч %d мин %d с %d мс'),
    (Key: 'error.time-range';             Value: 'Време у дану %d мс је ван опсега 00:00:00.000..23:59:59.999')
  );

var
  Serbian: Chrono.TLocale;

function SerbianLocale: Chrono.TLocale;
begin
  Result := Serbian;
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
  Serbian := Chrono.TLocale.Create('sr', Chrono.TLocale.English, Lookup);

finalization
  Serbian.Free;

end.
