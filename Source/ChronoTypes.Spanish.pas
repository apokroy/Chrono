{ ---------------------------------------------------------------------------
  Spanish texts for Chrono: month names, weekday names, names of date and time
  parts and error messages.

    uses ChronoTypes, ChronoTypes.Spanish;
    ...
    Chrono.Locale := SpanishLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Spanish;

interface

uses
  ChronoTypes;

/// <summary>
///  The Spanish locale. The month and weekday names are those of the es-ES locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function SpanishLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'enero'),
    (Key: 'month.february';           Value: 'febrero'),
    (Key: 'month.march';              Value: 'marzo'),
    (Key: 'month.april';              Value: 'abril'),
    (Key: 'month.may';                Value: 'mayo'),
    (Key: 'month.june';               Value: 'junio'),
    (Key: 'month.july';               Value: 'julio'),
    (Key: 'month.august';             Value: 'agosto'),
    (Key: 'month.september';          Value: 'septiembre'),
    (Key: 'month.october';            Value: 'octubre'),
    (Key: 'month.november';           Value: 'noviembre'),
    (Key: 'month.december';           Value: 'diciembre'),

    (Key: 'month.january.genitive';   Value: 'enero'),
    (Key: 'month.february.genitive';  Value: 'febrero'),
    (Key: 'month.march.genitive';     Value: 'marzo'),
    (Key: 'month.april.genitive';     Value: 'abril'),
    (Key: 'month.may.genitive';       Value: 'mayo'),
    (Key: 'month.june.genitive';      Value: 'junio'),
    (Key: 'month.july.genitive';      Value: 'julio'),
    (Key: 'month.august.genitive';    Value: 'agosto'),
    (Key: 'month.september.genitive'; Value: 'septiembre'),
    (Key: 'month.october.genitive';   Value: 'octubre'),
    (Key: 'month.november.genitive';  Value: 'noviembre'),
    (Key: 'month.december.genitive';  Value: 'diciembre'),

    (Key: 'month.january.short';      Value: 'ene.'),
    (Key: 'month.february.short';     Value: 'feb.'),
    (Key: 'month.march.short';        Value: 'mar.'),
    (Key: 'month.april.short';        Value: 'abr.'),
    (Key: 'month.may.short';          Value: 'may.'),
    (Key: 'month.june.short';         Value: 'jun.'),
    (Key: 'month.july.short';         Value: 'jul.'),
    (Key: 'month.august.short';       Value: 'ago.'),
    (Key: 'month.september.short';    Value: 'sep.'),
    (Key: 'month.october.short';      Value: 'oct.'),
    (Key: 'month.november.short';     Value: 'nov.'),
    (Key: 'month.december.short';     Value: 'dic.'),

    (Key: 'weekday.sunday';           Value: 'domingo'),
    (Key: 'weekday.monday';           Value: 'lunes'),
    (Key: 'weekday.tuesday';          Value: 'martes'),
    (Key: 'weekday.wednesday';        Value: 'miércoles'),
    (Key: 'weekday.thursday';         Value: 'jueves'),
    (Key: 'weekday.friday';           Value: 'viernes'),
    (Key: 'weekday.saturday';         Value: 'sábado'),

    (Key: 'weekday.sunday.short';     Value: 'do.'),
    (Key: 'weekday.monday.short';     Value: 'lu.'),
    (Key: 'weekday.tuesday.short';    Value: 'ma.'),
    (Key: 'weekday.wednesday.short';  Value: 'mi.'),
    (Key: 'weekday.thursday.short';   Value: 'ju.'),
    (Key: 'weekday.friday.short';     Value: 'vi.'),
    (Key: 'weekday.saturday.short';   Value: 'sá.'),

    (Key: 'part.year';                Value: 'Año'),
    (Key: 'part.quarter';             Value: 'Trimestre'),
    (Key: 'part.month';               Value: 'Mes'),
    (Key: 'part.week';                Value: 'Semana'),
    (Key: 'part.day';                 Value: 'Día'),
    (Key: 'part.year.short';          Value: 'a'),
    (Key: 'part.quarter.short';       Value: 'trim'),
    (Key: 'part.month.short';         Value: 'm'),
    (Key: 'part.week.short';          Value: 'sem'),
    (Key: 'part.day.short';           Value: 'd'),
    (Key: 'part.hour';                Value: 'Hora'),
    (Key: 'part.minute';              Value: 'Minuto'),
    (Key: 'part.second';              Value: 'Segundo'),
    (Key: 'part.millisecond';         Value: 'Milisegundo'),
    (Key: 'part.hour.short';          Value: 'h'),
    (Key: 'part.minute.short';        Value: 'min'),
    (Key: 'part.second.short';        Value: 's'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Zona horaria "%s" no válida'),
    (Key: 'error.invalid-quarter';        Value: 'Formato de trimestre "%s" no válido'),
    (Key: 'error.invalid-month-name';     Value: 'Nombre de mes "%s" no válido'),
    (Key: 'error.invalid-weekday-name';   Value: 'Nombre de día de la semana "%s" no válido'),
    (Key: 'error.invalid-year';           Value: 'Año %d no válido (valores admitidos: %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Mes %d no válido (valores admitidos: 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Día del mes %d no válido (valores admitidos: 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Trimestre %d no válido (valores admitidos: 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Día de la semana %d no válido (valores admitidos: 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Fecha no válida: año %d, mes %d, día %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Día %d no válido en el año %d'),
    (Key: 'error.date-range';             Value: 'Fecha fuera del intervalo 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Hora no válida: %d h %d min %d s %d ms'),
    (Key: 'error.time-range';             Value: 'Hora del día %d ms fuera del intervalo 00:00:00.000..23:59:59.999')
  );

var
  Spanish: Chrono.TLocale;

function SpanishLocale: Chrono.TLocale;
begin
  Result := Spanish;
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
  Spanish := Chrono.TLocale.Create('es', Chrono.TLocale.English, Lookup);

finalization
  Spanish.Free;

end.
