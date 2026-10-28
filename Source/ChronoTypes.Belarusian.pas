{ ---------------------------------------------------------------------------
  Belarusian texts for Chrono: month names (nominative and genitive), weekday
  names, names of date and time parts and error messages.

    uses ChronoTypes, ChronoTypes.Belarusian;
    ...
    Chrono.Locale := BelarusianLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Belarusian;

interface

uses
  ChronoTypes;

/// <summary>
///  The Belarusian locale. The month and weekday names are those of the be-BY locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function BelarusianLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'студзень'),
    (Key: 'month.february';           Value: 'люты'),
    (Key: 'month.march';              Value: 'сакавік'),
    (Key: 'month.april';              Value: 'красавік'),
    (Key: 'month.may';                Value: 'май'),
    (Key: 'month.june';               Value: 'чэрвень'),
    (Key: 'month.july';               Value: 'ліпень'),
    (Key: 'month.august';             Value: 'жнівень'),
    (Key: 'month.september';          Value: 'верасень'),
    (Key: 'month.october';            Value: 'кастрычнік'),
    (Key: 'month.november';           Value: 'лістапад'),
    (Key: 'month.december';           Value: 'снежань'),

    (Key: 'month.january.genitive';   Value: 'студзеня'),
    (Key: 'month.february.genitive';  Value: 'лютага'),
    (Key: 'month.march.genitive';     Value: 'сакавіка'),
    (Key: 'month.april.genitive';     Value: 'красавіка'),
    (Key: 'month.may.genitive';       Value: 'мая'),
    (Key: 'month.june.genitive';      Value: 'чэрвеня'),
    (Key: 'month.july.genitive';      Value: 'ліпеня'),
    (Key: 'month.august.genitive';    Value: 'жніўня'),
    (Key: 'month.september.genitive'; Value: 'верасня'),
    (Key: 'month.october.genitive';   Value: 'кастрычніка'),
    (Key: 'month.november.genitive';  Value: 'лістапада'),
    (Key: 'month.december.genitive';  Value: 'снежня'),

    (Key: 'month.january.short';      Value: 'студз'),
    (Key: 'month.february.short';     Value: 'лют'),
    (Key: 'month.march.short';        Value: 'сак'),
    (Key: 'month.april.short';        Value: 'крас'),
    (Key: 'month.may.short';          Value: 'май'),
    (Key: 'month.june.short';         Value: 'чэрв'),
    (Key: 'month.july.short';         Value: 'ліп'),
    (Key: 'month.august.short';       Value: 'жн'),
    (Key: 'month.september.short';    Value: 'вер'),
    (Key: 'month.october.short';      Value: 'кастр'),
    (Key: 'month.november.short';     Value: 'ліст'),
    (Key: 'month.december.short';     Value: 'снеж'),

    (Key: 'weekday.sunday';           Value: 'нядзеля'),
    (Key: 'weekday.monday';           Value: 'панядзелак'),
    (Key: 'weekday.tuesday';          Value: 'аўторак'),
    (Key: 'weekday.wednesday';        Value: 'серада'),
    (Key: 'weekday.thursday';         Value: 'чацвер'),
    (Key: 'weekday.friday';           Value: 'пятніца'),
    (Key: 'weekday.saturday';         Value: 'субота'),

    (Key: 'weekday.sunday.short';     Value: 'нд'),
    (Key: 'weekday.monday.short';     Value: 'пн'),
    (Key: 'weekday.tuesday.short';    Value: 'аўт'),
    (Key: 'weekday.wednesday.short';  Value: 'ср'),
    (Key: 'weekday.thursday.short';   Value: 'чц'),
    (Key: 'weekday.friday.short';     Value: 'пт'),
    (Key: 'weekday.saturday.short';   Value: 'сб'),

    (Key: 'part.year';                Value: 'Год'),
    (Key: 'part.quarter';             Value: 'Квартал'),
    (Key: 'part.month';               Value: 'Месяц'),
    (Key: 'part.week';                Value: 'Тыдзень'),
    (Key: 'part.day';                 Value: 'Дзень'),
    (Key: 'part.year.short';          Value: 'г'),
    (Key: 'part.quarter.short';       Value: 'кв'),
    (Key: 'part.month.short';         Value: 'мес'),
    (Key: 'part.week.short';          Value: 'тыдз'),
    (Key: 'part.day.short';           Value: 'дз'),
    (Key: 'part.hour';                Value: 'Гадзіна'),
    (Key: 'part.minute';              Value: 'Хвіліна'),
    (Key: 'part.second';              Value: 'Секунда'),
    (Key: 'part.millisecond';         Value: 'Мілісекунда'),
    (Key: 'part.hour.short';          Value: 'гадз'),
    (Key: 'part.minute.short';        Value: 'хв'),
    (Key: 'part.second.short';        Value: 'с'),
    (Key: 'part.millisecond.short';   Value: 'мс'),

    (Key: 'error.invalid-time-zone';      Value: 'Няправільны часавы пояс "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Няправільны запіс квартала "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Няправільная назва месяца "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Няправільная назва дня тыдня "%s"'),
    (Key: 'error.invalid-year';           Value: 'Няправільны год %d (дапушчальныя %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Няправільны месяц %d (дапушчальныя 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Няправільны дзень месяца %d (дапушчальныя 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Няправільны квартал %d (дапушчальныя 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Няправільны дзень тыдня %d (дапушчальныя 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Няправільная дата: год %d, месяц %d, дзень %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Няправільны дзень года %d у %d годзе'),
    (Key: 'error.date-range';             Value: 'Дата па-за дыяпазонам 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Няправільны час: %d гадз %d хв %d с %d мс'),
    (Key: 'error.time-range';             Value: 'Час сутак %d мс па-за дыяпазонам 00:00:00.000..23:59:59.999')
  );

var
  Belarusian: Chrono.TLocale;

function BelarusianLocale: Chrono.TLocale;
begin
  Result := Belarusian;
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
  Belarusian := Chrono.TLocale.Create('be', Chrono.TLocale.English, Lookup);

finalization
  Belarusian.Free;

end.
