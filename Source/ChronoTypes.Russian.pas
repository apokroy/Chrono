{ ---------------------------------------------------------------------------
  Russian texts for Chrono: month names (nominative and genitive), weekday
  names, names of date and time parts and error messages.

    uses ChronoTypes, ChronoTypes.Russian;
    ...
    Chrono.Locale := RussianLocale;

  The unit is also a template for another language: copy it, translate the
  texts (keep the keys and the %-arguments of the error messages) and rename
  the function. Keys missing from the table fall back to English.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Russian;

interface

uses
  ChronoTypes;

/// <summary>
///  The Russian locale. The names are those of the ru-RU locale of Windows, so dates read
///  the same on every platform. The locale is created when the unit is initialized and
///  freed when it is finalized; Chrono.Locale then returns to TLocale.System.
/// </summary>
function RussianLocale: Chrono.TLocale;

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

    (Key: 'month.january.genitive';   Value: 'января'),
    (Key: 'month.february.genitive';  Value: 'февраля'),
    (Key: 'month.march.genitive';     Value: 'марта'),
    (Key: 'month.april.genitive';     Value: 'апреля'),
    (Key: 'month.may.genitive';       Value: 'мая'),
    (Key: 'month.june.genitive';      Value: 'июня'),
    (Key: 'month.july.genitive';      Value: 'июля'),
    (Key: 'month.august.genitive';    Value: 'августа'),
    (Key: 'month.september.genitive'; Value: 'сентября'),
    (Key: 'month.october.genitive';   Value: 'октября'),
    (Key: 'month.november.genitive';  Value: 'ноября'),
    (Key: 'month.december.genitive';  Value: 'декабря'),

    (Key: 'month.january.short';      Value: 'янв'),
    (Key: 'month.february.short';     Value: 'фев'),
    (Key: 'month.march.short';        Value: 'мар'),
    (Key: 'month.april.short';        Value: 'апр'),
    (Key: 'month.may.short';          Value: 'май'),
    (Key: 'month.june.short';         Value: 'июн'),
    (Key: 'month.july.short';         Value: 'июл'),
    (Key: 'month.august.short';       Value: 'авг'),
    (Key: 'month.september.short';    Value: 'сен'),
    (Key: 'month.october.short';      Value: 'окт'),
    (Key: 'month.november.short';     Value: 'ноя'),
    (Key: 'month.december.short';     Value: 'дек'),

    (Key: 'weekday.sunday';           Value: 'воскресенье'),
    (Key: 'weekday.monday';           Value: 'понедельник'),
    (Key: 'weekday.tuesday';          Value: 'вторник'),
    (Key: 'weekday.wednesday';        Value: 'среда'),
    (Key: 'weekday.thursday';         Value: 'четверг'),
    (Key: 'weekday.friday';           Value: 'пятница'),
    (Key: 'weekday.saturday';         Value: 'суббота'),

    (Key: 'weekday.sunday.short';     Value: 'Вс'),
    (Key: 'weekday.monday.short';     Value: 'Пн'),
    (Key: 'weekday.tuesday.short';    Value: 'Вт'),
    (Key: 'weekday.wednesday.short';  Value: 'Ср'),
    (Key: 'weekday.thursday.short';   Value: 'Чт'),
    (Key: 'weekday.friday.short';     Value: 'Пт'),
    (Key: 'weekday.saturday.short';   Value: 'Сб'),

    (Key: 'part.year';                Value: 'Год'),
    (Key: 'part.quarter';             Value: 'Квартал'),
    (Key: 'part.month';               Value: 'Месяц'),
    (Key: 'part.week';                Value: 'Неделя'),
    (Key: 'part.day';                 Value: 'День'),
    (Key: 'part.year.short';          Value: 'г'),
    (Key: 'part.quarter.short';       Value: 'кв'),
    (Key: 'part.month.short';         Value: 'мес'),
    (Key: 'part.week.short';          Value: 'нед'),
    (Key: 'part.day.short';           Value: 'дн'),
    (Key: 'part.hour';                Value: 'Час'),
    (Key: 'part.minute';              Value: 'Минута'),
    (Key: 'part.second';              Value: 'Секунда'),
    (Key: 'part.millisecond';         Value: 'Миллисекунда'),
    (Key: 'part.hour.short';          Value: 'ч'),
    (Key: 'part.minute.short';        Value: 'мин'),
    (Key: 'part.second.short';        Value: 'с'),
    (Key: 'part.millisecond.short';   Value: 'мс'),

    (Key: 'error.invalid-time-zone';      Value: 'Неверный часовой пояс "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Неверная запись квартала "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Неверное название месяца "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Неверное название дня недели "%s"'),
    (Key: 'error.invalid-year';           Value: 'Неверный год %d (допустимы %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Неверный месяц %d (допустимы 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Неверный день месяца %d (допустимы 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Неверный квартал %d (допустимы 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Неверный день недели %d (допустимы 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Неверная дата: год %d, месяц %d, день %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Неверный день года %d в %d году'),
    (Key: 'error.date-range';             Value: 'Дата вне диапазона 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Неверное время: %d ч %d мин %d с %d мс'),
    (Key: 'error.time-range';             Value: 'Время суток %d мс вне диапазона 00:00:00.000..23:59:59.999')
  );

var
  Russian: Chrono.TLocale;

function RussianLocale: Chrono.TLocale;
begin
  Result := Russian;
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
  Russian := Chrono.TLocale.Create('ru', Chrono.TLocale.English, Lookup);

finalization
  Russian.Free;

end.
