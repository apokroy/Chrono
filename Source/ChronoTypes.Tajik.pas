{ ---------------------------------------------------------------------------
  Tajik texts for Chrono: month names, weekday names, names of date and time
  parts and error messages.

    uses ChronoTypes, ChronoTypes.Tajik;
    ...
    Chrono.Locale := TajikLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Tajik;

interface

uses
  ChronoTypes;

/// <summary>
///  The Tajik locale. The month and weekday names are those of the tg-Cyrl-TJ locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function TajikLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'январ'),
    (Key: 'month.february';           Value: 'феврал'),
    (Key: 'month.march';              Value: 'март'),
    (Key: 'month.april';              Value: 'апрел'),
    (Key: 'month.may';                Value: 'май'),
    (Key: 'month.june';               Value: 'июн'),
    (Key: 'month.july';               Value: 'июл'),
    (Key: 'month.august';             Value: 'август'),
    (Key: 'month.september';          Value: 'сентябр'),
    (Key: 'month.october';            Value: 'октябр'),
    (Key: 'month.november';           Value: 'ноябр'),
    (Key: 'month.december';           Value: 'декабр'),

    (Key: 'month.january.genitive';   Value: 'январ'),
    (Key: 'month.february.genitive';  Value: 'феврал'),
    (Key: 'month.march.genitive';     Value: 'март'),
    (Key: 'month.april.genitive';     Value: 'апрел'),
    (Key: 'month.may.genitive';       Value: 'май'),
    (Key: 'month.june.genitive';      Value: 'июн'),
    (Key: 'month.july.genitive';      Value: 'июл'),
    (Key: 'month.august.genitive';    Value: 'август'),
    (Key: 'month.september.genitive'; Value: 'сентябр'),
    (Key: 'month.october.genitive';   Value: 'октябр'),
    (Key: 'month.november.genitive';  Value: 'ноябр'),
    (Key: 'month.december.genitive';  Value: 'декабр'),

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

    (Key: 'weekday.sunday';           Value: 'якшанбе'),
    (Key: 'weekday.monday';           Value: 'душанбе'),
    (Key: 'weekday.tuesday';          Value: 'сешанбе'),
    (Key: 'weekday.wednesday';        Value: 'чоршанбе'),
    (Key: 'weekday.thursday';         Value: 'панҷшанбе'),
    (Key: 'weekday.friday';           Value: 'ҷумъа'),
    (Key: 'weekday.saturday';         Value: 'шанбе'),

    (Key: 'weekday.sunday.short';     Value: 'пкш'),
    (Key: 'weekday.monday.short';     Value: 'дшб'),
    (Key: 'weekday.tuesday.short';    Value: 'сшб'),
    (Key: 'weekday.wednesday.short';  Value: 'чшб'),
    (Key: 'weekday.thursday.short';   Value: 'пшб'),
    (Key: 'weekday.friday.short';     Value: 'ҷум'),
    (Key: 'weekday.saturday.short';   Value: 'шнб'),

    (Key: 'part.year';                Value: 'Сол'),
    (Key: 'part.quarter';             Value: 'Семоҳа'),
    (Key: 'part.month';               Value: 'Моҳ'),
    (Key: 'part.week';                Value: 'Ҳафта'),
    (Key: 'part.day';                 Value: 'Рӯз'),
    (Key: 'part.year.short';          Value: 'с'),
    (Key: 'part.quarter.short';       Value: 'сем'),
    (Key: 'part.month.short';         Value: 'моҳ'),
    (Key: 'part.week.short';          Value: 'ҳаф'),
    (Key: 'part.day.short';           Value: 'рӯз'),
    (Key: 'part.hour';                Value: 'Соат'),
    (Key: 'part.minute';              Value: 'Дақиқа'),
    (Key: 'part.second';              Value: 'Сония'),
    (Key: 'part.millisecond';         Value: 'Миллисония'),
    (Key: 'part.hour.short';          Value: 'соат'),
    (Key: 'part.minute.short';        Value: 'дақ'),
    (Key: 'part.second.short';        Value: 'сон'),
    (Key: 'part.millisecond.short';   Value: 'мс'),

    (Key: 'error.invalid-time-zone';      Value: 'Минтақаи вақти нодуруст "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Сабти нодурусти семоҳа "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Номи нодурусти моҳ "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Номи нодурусти рӯзи ҳафта "%s"'),
    (Key: 'error.invalid-year';           Value: 'Соли нодуруст %d (иҷозатдодашуда %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Моҳи нодуруст %d (иҷозатдодашуда 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Рӯзи нодурусти моҳ %d (иҷозатдодашуда 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Семоҳаи нодуруст %d (иҷозатдодашуда 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Рӯзи нодурусти ҳафта %d (иҷозатдодашуда 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Санаи нодуруст: сол %d, моҳ %d, рӯз %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Рӯзи нодурусти сол %d (соли %d)'),
    (Key: 'error.date-range';             Value: 'Сана берун аз доираи 0001-01-01..9999-12-31 аст'),
    (Key: 'error.invalid-time';           Value: 'Вақти нодуруст: %d соат %d дақ %d сон %d мс'),
    (Key: 'error.time-range';             Value: 'Вақти шабонарӯз %d мс берун аз доираи 00:00:00.000..23:59:59.999 аст')
  );

var
  Tajik: Chrono.TLocale;

function TajikLocale: Chrono.TLocale;
begin
  Result := Tajik;
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
  Tajik := Chrono.TLocale.Create('tg', Chrono.TLocale.English, Lookup);

finalization
  Tajik.Free;

end.
