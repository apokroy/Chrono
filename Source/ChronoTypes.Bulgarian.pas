{ ---------------------------------------------------------------------------
  Bulgarian texts for Chrono: month names, weekday names, names of date and
  time parts and error messages.

    uses ChronoTypes, ChronoTypes.Bulgarian;
    ...
    Chrono.Locale := BulgarianLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Bulgarian;

interface

uses
  ChronoTypes;

/// <summary>
///  The Bulgarian locale. The month and weekday names are those of the bg-BG locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function BulgarianLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'януари'),
    (Key: 'month.february';           Value: 'февруари'),
    (Key: 'month.march';              Value: 'март'),
    (Key: 'month.april';              Value: 'април'),
    (Key: 'month.may';                Value: 'май'),
    (Key: 'month.june';               Value: 'юни'),
    (Key: 'month.july';               Value: 'юли'),
    (Key: 'month.august';             Value: 'август'),
    (Key: 'month.september';          Value: 'септември'),
    (Key: 'month.october';            Value: 'октомври'),
    (Key: 'month.november';           Value: 'ноември'),
    (Key: 'month.december';           Value: 'декември'),

    (Key: 'month.january.genitive';   Value: 'януари'),
    (Key: 'month.february.genitive';  Value: 'февруари'),
    (Key: 'month.march.genitive';     Value: 'март'),
    (Key: 'month.april.genitive';     Value: 'април'),
    (Key: 'month.may.genitive';       Value: 'май'),
    (Key: 'month.june.genitive';      Value: 'юни'),
    (Key: 'month.july.genitive';      Value: 'юли'),
    (Key: 'month.august.genitive';    Value: 'август'),
    (Key: 'month.september.genitive'; Value: 'септември'),
    (Key: 'month.october.genitive';   Value: 'октомври'),
    (Key: 'month.november.genitive';  Value: 'ноември'),
    (Key: 'month.december.genitive';  Value: 'декември'),

    (Key: 'month.january.short';      Value: 'яну'),
    (Key: 'month.february.short';     Value: 'фев'),
    (Key: 'month.march.short';        Value: 'мар'),
    (Key: 'month.april.short';        Value: 'апр'),
    (Key: 'month.may.short';          Value: 'май'),
    (Key: 'month.june.short';         Value: 'юни'),
    (Key: 'month.july.short';         Value: 'юли'),
    (Key: 'month.august.short';       Value: 'авг'),
    (Key: 'month.september.short';    Value: 'сеп'),
    (Key: 'month.october.short';      Value: 'окт'),
    (Key: 'month.november.short';     Value: 'ное'),
    (Key: 'month.december.short';     Value: 'дек'),

    (Key: 'weekday.sunday';           Value: 'неделя'),
    (Key: 'weekday.monday';           Value: 'понеделник'),
    (Key: 'weekday.tuesday';          Value: 'вторник'),
    (Key: 'weekday.wednesday';        Value: 'сряда'),
    (Key: 'weekday.thursday';         Value: 'четвъртък'),
    (Key: 'weekday.friday';           Value: 'петък'),
    (Key: 'weekday.saturday';         Value: 'събота'),

    (Key: 'weekday.sunday.short';     Value: 'нед'),
    (Key: 'weekday.monday.short';     Value: 'пон'),
    (Key: 'weekday.tuesday.short';    Value: 'вт'),
    (Key: 'weekday.wednesday.short';  Value: 'ср'),
    (Key: 'weekday.thursday.short';   Value: 'четв'),
    (Key: 'weekday.friday.short';     Value: 'пет'),
    (Key: 'weekday.saturday.short';   Value: 'съб'),

    (Key: 'part.year';                Value: 'Година'),
    (Key: 'part.quarter';             Value: 'Тримесечие'),
    (Key: 'part.month';               Value: 'Месец'),
    (Key: 'part.week';                Value: 'Седмица'),
    (Key: 'part.day';                 Value: 'Ден'),
    (Key: 'part.year.short';          Value: 'г'),
    (Key: 'part.quarter.short';       Value: 'трим'),
    (Key: 'part.month.short';         Value: 'мес'),
    (Key: 'part.week.short';          Value: 'седм'),
    (Key: 'part.day.short';           Value: 'д'),
    (Key: 'part.hour';                Value: 'Час'),
    (Key: 'part.minute';              Value: 'Минута'),
    (Key: 'part.second';              Value: 'Секунда'),
    (Key: 'part.millisecond';         Value: 'Милисекунда'),
    (Key: 'part.hour.short';          Value: 'ч'),
    (Key: 'part.minute.short';        Value: 'мин'),
    (Key: 'part.second.short';        Value: 'с'),
    (Key: 'part.millisecond.short';   Value: 'мс'),

    (Key: 'error.invalid-time-zone';      Value: 'Невалидна часова зона "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Невалиден запис на тримесечие "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Невалидно име на месец "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Невалидно име на ден от седмицата "%s"'),
    (Key: 'error.invalid-year';           Value: 'Невалидна година %d (допустими %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Невалиден месец %d (допустими 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Невалиден ден от месеца %d (допустими 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Невалидно тримесечие %d (допустими 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Невалиден ден от седмицата %d (допустими 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Невалидна дата: година %d, месец %d, ден %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Невалиден ден от годината %d в %d година'),
    (Key: 'error.date-range';             Value: 'Датата е извън диапазона 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Невалидно време: %d ч %d мин %d с %d мс'),
    (Key: 'error.time-range';             Value: 'Часът от денонощието %d мс е извън диапазона 00:00:00.000..23:59:59.999')
  );

var
  Bulgarian: Chrono.TLocale;

function BulgarianLocale: Chrono.TLocale;
begin
  Result := Bulgarian;
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
  Bulgarian := Chrono.TLocale.Create('bg', Chrono.TLocale.English, Lookup);

finalization
  Bulgarian.Free;

end.
