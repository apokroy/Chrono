{ ---------------------------------------------------------------------------
  Ukrainian texts for Chrono: month names (nominative and genitive), weekday
  names, names of date and time parts and error messages.

    uses ChronoTypes, ChronoTypes.Ukrainian;
    ...
    Chrono.Locale := UkrainianLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Ukrainian;

interface

uses
  ChronoTypes;

/// <summary>
///  The Ukrainian locale. The month and weekday names are those of the uk-UA locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function UkrainianLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'січень'),
    (Key: 'month.february';           Value: 'лютий'),
    (Key: 'month.march';              Value: 'березень'),
    (Key: 'month.april';              Value: 'квітень'),
    (Key: 'month.may';                Value: 'травень'),
    (Key: 'month.june';               Value: 'червень'),
    (Key: 'month.july';               Value: 'липень'),
    (Key: 'month.august';             Value: 'серпень'),
    (Key: 'month.september';          Value: 'вересень'),
    (Key: 'month.october';            Value: 'жовтень'),
    (Key: 'month.november';           Value: 'листопад'),
    (Key: 'month.december';           Value: 'грудень'),

    (Key: 'month.january.genitive';   Value: 'січня'),
    (Key: 'month.february.genitive';  Value: 'лютого'),
    (Key: 'month.march.genitive';     Value: 'березня'),
    (Key: 'month.april.genitive';     Value: 'квітня'),
    (Key: 'month.may.genitive';       Value: 'травня'),
    (Key: 'month.june.genitive';      Value: 'червня'),
    (Key: 'month.july.genitive';      Value: 'липня'),
    (Key: 'month.august.genitive';    Value: 'серпня'),
    (Key: 'month.september.genitive'; Value: 'вересня'),
    (Key: 'month.october.genitive';   Value: 'жовтня'),
    (Key: 'month.november.genitive';  Value: 'листопада'),
    (Key: 'month.december.genitive';  Value: 'грудня'),

    (Key: 'month.january.short';      Value: 'Січ'),
    (Key: 'month.february.short';     Value: 'Лют'),
    (Key: 'month.march.short';        Value: 'Бер'),
    (Key: 'month.april.short';        Value: 'Кві'),
    (Key: 'month.may.short';          Value: 'Тра'),
    (Key: 'month.june.short';         Value: 'Чер'),
    (Key: 'month.july.short';         Value: 'Лип'),
    (Key: 'month.august.short';       Value: 'Сер'),
    (Key: 'month.september.short';    Value: 'Вер'),
    (Key: 'month.october.short';      Value: 'Жов'),
    (Key: 'month.november.short';     Value: 'Лис'),
    (Key: 'month.december.short';     Value: 'Гру'),

    (Key: 'weekday.sunday';           Value: 'неділя'),
    (Key: 'weekday.monday';           Value: 'понеділок'),
    (Key: 'weekday.tuesday';          Value: 'вівторок'),
    (Key: 'weekday.wednesday';        Value: 'середа'),
    (Key: 'weekday.thursday';         Value: 'четвер'),
    (Key: 'weekday.friday';           Value: 'п''ятниця'),
    (Key: 'weekday.saturday';         Value: 'субота'),

    (Key: 'weekday.sunday.short';     Value: 'Нд'),
    (Key: 'weekday.monday.short';     Value: 'Пн'),
    (Key: 'weekday.tuesday.short';    Value: 'Вт'),
    (Key: 'weekday.wednesday.short';  Value: 'Ср'),
    (Key: 'weekday.thursday.short';   Value: 'Чт'),
    (Key: 'weekday.friday.short';     Value: 'Пт'),
    (Key: 'weekday.saturday.short';   Value: 'Сб'),

    (Key: 'part.year';                Value: 'Рік'),
    (Key: 'part.quarter';             Value: 'Квартал'),
    (Key: 'part.month';               Value: 'Місяць'),
    (Key: 'part.week';                Value: 'Тиждень'),
    (Key: 'part.day';                 Value: 'День'),
    (Key: 'part.year.short';          Value: 'р'),
    (Key: 'part.quarter.short';       Value: 'кв'),
    (Key: 'part.month.short';         Value: 'міс'),
    (Key: 'part.week.short';          Value: 'тиж'),
    (Key: 'part.day.short';           Value: 'дн'),
    (Key: 'part.hour';                Value: 'Година'),
    (Key: 'part.minute';              Value: 'Хвилина'),
    (Key: 'part.second';              Value: 'Секунда'),
    (Key: 'part.millisecond';         Value: 'Мілісекунда'),
    (Key: 'part.hour.short';          Value: 'год'),
    (Key: 'part.minute.short';        Value: 'хв'),
    (Key: 'part.second.short';        Value: 'с'),
    (Key: 'part.millisecond.short';   Value: 'мс'),

    (Key: 'error.invalid-time-zone';      Value: 'Неправильний часовий пояс "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Неправильний запис кварталу "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Неправильна назва місяця "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Неправильна назва дня тижня "%s"'),
    (Key: 'error.invalid-year';           Value: 'Неправильний рік %d (допустимі %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Неправильний місяць %d (допустимі 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Неправильний день місяця %d (допустимі 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Неправильний квартал %d (допустимі 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Неправильний день тижня %d (допустимі 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Неправильна дата: рік %d, місяць %d, день %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Неправильний день року %d у %d році'),
    (Key: 'error.date-range';             Value: 'Дата поза діапазоном 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Неправильний час: %d год %d хв %d с %d мс'),
    (Key: 'error.time-range';             Value: 'Час доби %d мс поза діапазоном 00:00:00.000..23:59:59.999')
  );

var
  Ukrainian: Chrono.TLocale;

function UkrainianLocale: Chrono.TLocale;
begin
  Result := Ukrainian;
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
  Ukrainian := Chrono.TLocale.Create('uk', Chrono.TLocale.English, Lookup);

finalization
  Ukrainian.Free;

end.
