{ ---------------------------------------------------------------------------
  Kazakh texts for Chrono: month names (nominative and genitive), weekday
  names, names of date and time parts and error messages.

    uses ChronoTypes, ChronoTypes.Kazakh;
    ...
    Chrono.Locale := KazakhLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Kazakh;

interface

uses
  ChronoTypes;

/// <summary>
///  The Kazakh locale. The month and weekday names are those of the kk-KZ locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function KazakhLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'Қаңтар'),
    (Key: 'month.february';           Value: 'Ақпан'),
    (Key: 'month.march';              Value: 'Наурыз'),
    (Key: 'month.april';              Value: 'Сәуір'),
    (Key: 'month.may';                Value: 'Мамыр'),
    (Key: 'month.june';               Value: 'Маусым'),
    (Key: 'month.july';               Value: 'Шілде'),
    (Key: 'month.august';             Value: 'Тамыз'),
    (Key: 'month.september';          Value: 'Қыркүйек'),
    (Key: 'month.october';            Value: 'Қазан'),
    (Key: 'month.november';           Value: 'Қараша'),
    (Key: 'month.december';           Value: 'Желтоқсан'),

    (Key: 'month.january.genitive';   Value: 'қаңтар'),
    (Key: 'month.february.genitive';  Value: 'ақпан'),
    (Key: 'month.march.genitive';     Value: 'наурыз'),
    (Key: 'month.april.genitive';     Value: 'сәуір'),
    (Key: 'month.may.genitive';       Value: 'мамыр'),
    (Key: 'month.june.genitive';      Value: 'маусым'),
    (Key: 'month.july.genitive';      Value: 'шілде'),
    (Key: 'month.august.genitive';    Value: 'тамыз'),
    (Key: 'month.september.genitive'; Value: 'қыркүйек'),
    (Key: 'month.october.genitive';   Value: 'қазан'),
    (Key: 'month.november.genitive';  Value: 'қараша'),
    (Key: 'month.december.genitive';  Value: 'желтоқсан'),

    (Key: 'month.january.short';      Value: 'қаң.'),
    (Key: 'month.february.short';     Value: 'ақп.'),
    (Key: 'month.march.short';        Value: 'нау.'),
    (Key: 'month.april.short';        Value: 'сәу.'),
    (Key: 'month.may.short';          Value: 'мам.'),
    (Key: 'month.june.short';         Value: 'мау.'),
    (Key: 'month.july.short';         Value: 'шіл.'),
    (Key: 'month.august.short';       Value: 'там.'),
    (Key: 'month.september.short';    Value: 'қыр.'),
    (Key: 'month.october.short';      Value: 'қаз.'),
    (Key: 'month.november.short';     Value: 'қар.'),
    (Key: 'month.december.short';     Value: 'жел.'),

    (Key: 'weekday.sunday';           Value: 'жексенбі'),
    (Key: 'weekday.monday';           Value: 'дүйсенбі'),
    (Key: 'weekday.tuesday';          Value: 'сейсенбі'),
    (Key: 'weekday.wednesday';        Value: 'сәрсенбі'),
    (Key: 'weekday.thursday';         Value: 'бейсенбі'),
    (Key: 'weekday.friday';           Value: 'жұма'),
    (Key: 'weekday.saturday';         Value: 'сенбі'),

    (Key: 'weekday.sunday.short';     Value: 'жс'),
    (Key: 'weekday.monday.short';     Value: 'дс'),
    (Key: 'weekday.tuesday.short';    Value: 'сс'),
    (Key: 'weekday.wednesday.short';  Value: 'ср'),
    (Key: 'weekday.thursday.short';   Value: 'бс'),
    (Key: 'weekday.friday.short';     Value: 'жм'),
    (Key: 'weekday.saturday.short';   Value: 'сб'),

    (Key: 'part.year';                Value: 'Жыл'),
    (Key: 'part.quarter';             Value: 'Тоқсан'),
    (Key: 'part.month';               Value: 'Ай'),
    (Key: 'part.week';                Value: 'Апта'),
    (Key: 'part.day';                 Value: 'Күн'),
    (Key: 'part.year.short';          Value: 'ж'),
    (Key: 'part.quarter.short';       Value: 'тоқ'),
    (Key: 'part.month.short';         Value: 'ай'),
    (Key: 'part.week.short';          Value: 'ап'),
    (Key: 'part.day.short';           Value: 'күн'),
    (Key: 'part.hour';                Value: 'Сағат'),
    (Key: 'part.minute';              Value: 'Минут'),
    (Key: 'part.second';              Value: 'Секунд'),
    (Key: 'part.millisecond';         Value: 'Миллисекунд'),
    (Key: 'part.hour.short';          Value: 'сағ'),
    (Key: 'part.minute.short';        Value: 'мин'),
    (Key: 'part.second.short';        Value: 'с'),
    (Key: 'part.millisecond.short';   Value: 'мс'),

    (Key: 'error.invalid-time-zone';      Value: 'Қате уақыт белдеуі "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Тоқсанның қате жазылуы "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Айдың қате атауы "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Апта күнінің қате атауы "%s"'),
    (Key: 'error.invalid-year';           Value: 'Қате жыл %d (рұқсат етілгені %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Қате ай %d (рұқсат етілгені 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Айдың қате күні %d (рұқсат етілгені 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Қате тоқсан %d (рұқсат етілгені 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Апта күнінің қате нөмірі %d (рұқсат етілгені 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Қате дата: жыл %d, ай %d, күн %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Жылдың қате күні %d (%d жыл)'),
    (Key: 'error.date-range';             Value: 'Дата 0001-01-01..9999-12-31 ауқымынан тыс'),
    (Key: 'error.invalid-time';           Value: 'Қате уақыт: %d сағ %d мин %d с %d мс'),
    (Key: 'error.time-range';             Value: 'Тәулік уақыты %d мс 00:00:00.000..23:59:59.999 ауқымынан тыс')
  );

var
  Kazakh: Chrono.TLocale;

function KazakhLocale: Chrono.TLocale;
begin
  Result := Kazakh;
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
  Kazakh := Chrono.TLocale.Create('kk', Chrono.TLocale.English, Lookup);

finalization
  Kazakh.Free;

end.
