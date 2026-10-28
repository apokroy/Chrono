{ ---------------------------------------------------------------------------
  Portuguese texts for Chrono: month names, weekday names, names of date and
  time parts and error messages.

    uses ChronoTypes, ChronoTypes.Portuguese;
    ...
    Chrono.Locale := PortugueseLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Portuguese;

interface

uses
  ChronoTypes;

/// <summary>
///  The Portuguese locale. The month and weekday names are those of the pt-PT and pt-BR
///  locales of Windows (they are the same), so dates read the same on every platform. The
///  locale is created when the unit is initialized and freed when it is finalized;
///  Chrono.Locale then returns to TLocale.System.
/// </summary>
function PortugueseLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'janeiro'),
    (Key: 'month.february';           Value: 'fevereiro'),
    (Key: 'month.march';              Value: 'março'),
    (Key: 'month.april';              Value: 'abril'),
    (Key: 'month.may';                Value: 'maio'),
    (Key: 'month.june';               Value: 'junho'),
    (Key: 'month.july';               Value: 'julho'),
    (Key: 'month.august';             Value: 'agosto'),
    (Key: 'month.september';          Value: 'setembro'),
    (Key: 'month.october';            Value: 'outubro'),
    (Key: 'month.november';           Value: 'novembro'),
    (Key: 'month.december';           Value: 'dezembro'),

    (Key: 'month.january.genitive';   Value: 'janeiro'),
    (Key: 'month.february.genitive';  Value: 'fevereiro'),
    (Key: 'month.march.genitive';     Value: 'março'),
    (Key: 'month.april.genitive';     Value: 'abril'),
    (Key: 'month.may.genitive';       Value: 'maio'),
    (Key: 'month.june.genitive';      Value: 'junho'),
    (Key: 'month.july.genitive';      Value: 'julho'),
    (Key: 'month.august.genitive';    Value: 'agosto'),
    (Key: 'month.september.genitive'; Value: 'setembro'),
    (Key: 'month.october.genitive';   Value: 'outubro'),
    (Key: 'month.november.genitive';  Value: 'novembro'),
    (Key: 'month.december.genitive';  Value: 'dezembro'),

    (Key: 'month.january.short';      Value: 'jan'),
    (Key: 'month.february.short';     Value: 'fev'),
    (Key: 'month.march.short';        Value: 'mar'),
    (Key: 'month.april.short';        Value: 'abr'),
    (Key: 'month.may.short';          Value: 'mai'),
    (Key: 'month.june.short';         Value: 'jun'),
    (Key: 'month.july.short';         Value: 'jul'),
    (Key: 'month.august.short';       Value: 'ago'),
    (Key: 'month.september.short';    Value: 'set'),
    (Key: 'month.october.short';      Value: 'out'),
    (Key: 'month.november.short';     Value: 'nov'),
    (Key: 'month.december.short';     Value: 'dez'),

    (Key: 'weekday.sunday';           Value: 'domingo'),
    (Key: 'weekday.monday';           Value: 'segunda-feira'),
    (Key: 'weekday.tuesday';          Value: 'terça-feira'),
    (Key: 'weekday.wednesday';        Value: 'quarta-feira'),
    (Key: 'weekday.thursday';         Value: 'quinta-feira'),
    (Key: 'weekday.friday';           Value: 'sexta-feira'),
    (Key: 'weekday.saturday';         Value: 'sábado'),

    (Key: 'weekday.sunday.short';     Value: 'dom'),
    (Key: 'weekday.monday.short';     Value: 'seg'),
    (Key: 'weekday.tuesday.short';    Value: 'ter'),
    (Key: 'weekday.wednesday.short';  Value: 'qua'),
    (Key: 'weekday.thursday.short';   Value: 'qui'),
    (Key: 'weekday.friday.short';     Value: 'sex'),
    (Key: 'weekday.saturday.short';   Value: 'sáb'),

    (Key: 'part.year';                Value: 'Ano'),
    (Key: 'part.quarter';             Value: 'Trimestre'),
    (Key: 'part.month';               Value: 'Mês'),
    (Key: 'part.week';                Value: 'Semana'),
    (Key: 'part.day';                 Value: 'Dia'),
    (Key: 'part.year.short';          Value: 'a'),
    (Key: 'part.quarter.short';       Value: 'trim'),
    (Key: 'part.month.short';         Value: 'm'),
    (Key: 'part.week.short';          Value: 'sem'),
    (Key: 'part.day.short';           Value: 'd'),
    (Key: 'part.hour';                Value: 'Hora'),
    (Key: 'part.minute';              Value: 'Minuto'),
    (Key: 'part.second';              Value: 'Segundo'),
    (Key: 'part.millisecond';         Value: 'Milissegundo'),
    (Key: 'part.hour.short';          Value: 'h'),
    (Key: 'part.minute.short';        Value: 'min'),
    (Key: 'part.second.short';        Value: 's'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Fuso horário "%s" inválido'),
    (Key: 'error.invalid-quarter';        Value: 'Formato de trimestre "%s" inválido'),
    (Key: 'error.invalid-month-name';     Value: 'Nome de mês "%s" inválido'),
    (Key: 'error.invalid-weekday-name';   Value: 'Nome de dia da semana "%s" inválido'),
    (Key: 'error.invalid-year';           Value: 'Ano %d inválido (valores permitidos: %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Mês %d inválido (valores permitidos: 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Dia do mês %d inválido (valores permitidos: 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Trimestre %d inválido (valores permitidos: 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Dia da semana %d inválido (valores permitidos: 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Data inválida: ano %d, mês %d, dia %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Dia %d inválido no ano %d'),
    (Key: 'error.date-range';             Value: 'Data fora do intervalo 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Hora inválida: %d h %d min %d s %d ms'),
    (Key: 'error.time-range';             Value: 'Hora do dia %d ms fora do intervalo 00:00:00.000..23:59:59.999')
  );

var
  Portuguese: Chrono.TLocale;

function PortugueseLocale: Chrono.TLocale;
begin
  Result := Portuguese;
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
  Portuguese := Chrono.TLocale.Create('pt', Chrono.TLocale.English, Lookup);

finalization
  Portuguese.Free;

end.
