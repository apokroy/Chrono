{ ---------------------------------------------------------------------------
  Kyrgyz texts for Chrono: month names (nominative and genitive), weekday
  names, names of date and time parts and error messages.

    uses ChronoTypes, ChronoTypes.Kyrgyz;
    ...
    Chrono.Locale := KyrgyzLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Kyrgyz;

interface

uses
  ChronoTypes;

/// <summary>
///  The Kyrgyz locale. The month and weekday names are those of the ky-KG locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function KyrgyzLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'Январь'),
    (Key: 'month.february';           Value: 'Февраль'),
    (Key: 'month.march';              Value: 'Март'),
    (Key: 'month.april';              Value: 'Апрель'),
    (Key: 'month.may';                Value: 'Май'),
    (Key: 'month.june';               Value: 'Июнь'),
    (Key: 'month.july';               Value: 'Июль'),
    (Key: 'month.august';             Value: 'Август'),
    (Key: 'month.september';          Value: 'Сентябрь'),
    (Key: 'month.october';            Value: 'Октябрь'),
    (Key: 'month.november';           Value: 'Ноябрь'),
    (Key: 'month.december';           Value: 'Декабрь'),

    (Key: 'month.january.genitive';   Value: 'январь'),
    (Key: 'month.february.genitive';  Value: 'февраль'),
    (Key: 'month.march.genitive';     Value: 'март'),
    (Key: 'month.april.genitive';     Value: 'апрель'),
    (Key: 'month.may.genitive';       Value: 'май'),
    (Key: 'month.june.genitive';      Value: 'июнь'),
    (Key: 'month.july.genitive';      Value: 'июль'),
    (Key: 'month.august.genitive';    Value: 'август'),
    (Key: 'month.september.genitive'; Value: 'сентябрь'),
    (Key: 'month.october.genitive';   Value: 'октябрь'),
    (Key: 'month.november.genitive';  Value: 'ноябрь'),
    (Key: 'month.december.genitive';  Value: 'декабрь'),

    (Key: 'month.january.short';      Value: 'Янв'),
    (Key: 'month.february.short';     Value: 'Фев'),
    (Key: 'month.march.short';        Value: 'Мар'),
    (Key: 'month.april.short';        Value: 'Апр'),
    (Key: 'month.may.short';          Value: 'Май'),
    (Key: 'month.june.short';         Value: 'Июн'),
    (Key: 'month.july.short';         Value: 'Июл'),
    (Key: 'month.august.short';       Value: 'Авг'),
    (Key: 'month.september.short';    Value: 'Сен'),
    (Key: 'month.october.short';      Value: 'Окт'),
    (Key: 'month.november.short';     Value: 'Ноя'),
    (Key: 'month.december.short';     Value: 'Дек'),

    (Key: 'weekday.sunday';           Value: 'жекшемби'),
    (Key: 'weekday.monday';           Value: 'дүйшөмбү'),
    (Key: 'weekday.tuesday';          Value: 'шейшемби'),
    (Key: 'weekday.wednesday';        Value: 'шаршемби'),
    (Key: 'weekday.thursday';         Value: 'бейшемби'),
    (Key: 'weekday.friday';           Value: 'жума'),
    (Key: 'weekday.saturday';         Value: 'ишемби'),

    (Key: 'weekday.sunday.short';     Value: 'жек.'),
    (Key: 'weekday.monday.short';     Value: 'дүй.'),
    (Key: 'weekday.tuesday.short';    Value: 'шейш.'),
    (Key: 'weekday.wednesday.short';  Value: 'шарш.'),
    (Key: 'weekday.thursday.short';   Value: 'бейш.'),
    (Key: 'weekday.friday.short';     Value: 'жума'),
    (Key: 'weekday.saturday.short';   Value: 'ишм.'),

    (Key: 'part.year';                Value: 'Жыл'),
    (Key: 'part.quarter';             Value: 'Чейрек'),
    (Key: 'part.month';               Value: 'Ай'),
    (Key: 'part.week';                Value: 'Апта'),
    (Key: 'part.day';                 Value: 'Күн'),
    (Key: 'part.year.short';          Value: 'ж'),
    (Key: 'part.quarter.short';       Value: 'чейр'),
    (Key: 'part.month.short';         Value: 'ай'),
    (Key: 'part.week.short';          Value: 'апт'),
    (Key: 'part.day.short';           Value: 'күн'),
    (Key: 'part.hour';                Value: 'Саат'),
    (Key: 'part.minute';              Value: 'Мүнөт'),
    (Key: 'part.second';              Value: 'Секунд'),
    (Key: 'part.millisecond';         Value: 'Миллисекунд'),
    (Key: 'part.hour.short';          Value: 'саат'),
    (Key: 'part.minute.short';        Value: 'мүн'),
    (Key: 'part.second.short';        Value: 'сек'),
    (Key: 'part.millisecond.short';   Value: 'мс'),

    (Key: 'error.invalid-time-zone';      Value: 'Туура эмес убакыт алкагы "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Чейректин туура эмес жазылышы "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Айдын туура эмес аталышы "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Апта күнүнүн туура эмес аталышы "%s"'),
    (Key: 'error.invalid-year';           Value: 'Туура эмес жыл %d (уруксат берилген %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Туура эмес ай %d (уруксат берилген 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Айдын туура эмес күнү %d (уруксат берилген 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Туура эмес чейрек %d (уруксат берилген 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Апта күнүнүн туура эмес номери %d (уруксат берилген 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Туура эмес дата: жыл %d, ай %d, күн %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Жылдын туура эмес күнү %d (%d-жыл)'),
    (Key: 'error.date-range';             Value: 'Дата 0001-01-01..9999-12-31 аралыгынан тышкары'),
    (Key: 'error.invalid-time';           Value: 'Туура эмес убакыт: %d саат %d мүн %d сек %d мс'),
    (Key: 'error.time-range';             Value: 'Суткадагы убакыт %d мс 00:00:00.000..23:59:59.999 аралыгынан тышкары')
  );

var
  Kyrgyz: Chrono.TLocale;

function KyrgyzLocale: Chrono.TLocale;
begin
  Result := Kyrgyz;
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
  Kyrgyz := Chrono.TLocale.Create('ky', Chrono.TLocale.English, Lookup);

finalization
  Kyrgyz.Free;

end.
