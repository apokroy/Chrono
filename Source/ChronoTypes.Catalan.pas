{ ---------------------------------------------------------------------------
  Catalan texts for Chrono: month names (nominative and genitive), weekday
  names, names of date and time parts and error messages.

    uses ChronoTypes, ChronoTypes.Catalan;
    ...
    Chrono.Locale := CatalanLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Catalan;

interface

uses
  ChronoTypes;

/// <summary>
///  The Catalan locale. The month and weekday names are those of the ca-ES locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function CatalanLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'gener'),
    (Key: 'month.february';           Value: 'febrer'),
    (Key: 'month.march';              Value: 'març'),
    (Key: 'month.april';              Value: 'abril'),
    (Key: 'month.may';                Value: 'maig'),
    (Key: 'month.june';               Value: 'juny'),
    (Key: 'month.july';               Value: 'juliol'),
    (Key: 'month.august';             Value: 'agost'),
    (Key: 'month.september';          Value: 'setembre'),
    (Key: 'month.october';            Value: 'octubre'),
    (Key: 'month.november';           Value: 'novembre'),
    (Key: 'month.december';           Value: 'desembre'),

    (Key: 'month.january.genitive';   Value: 'de gener'),
    (Key: 'month.february.genitive';  Value: 'de febrer'),
    (Key: 'month.march.genitive';     Value: 'de març'),
    (Key: 'month.april.genitive';     Value: 'd’abril'),
    (Key: 'month.may.genitive';       Value: 'de maig'),
    (Key: 'month.june.genitive';      Value: 'de juny'),
    (Key: 'month.july.genitive';      Value: 'de juliol'),
    (Key: 'month.august.genitive';    Value: 'd’agost'),
    (Key: 'month.september.genitive'; Value: 'de setembre'),
    (Key: 'month.october.genitive';   Value: 'd’octubre'),
    (Key: 'month.november.genitive';  Value: 'de novembre'),
    (Key: 'month.december.genitive';  Value: 'de desembre'),

    (Key: 'month.january.short';      Value: 'gen.'),
    (Key: 'month.february.short';     Value: 'febr.'),
    (Key: 'month.march.short';        Value: 'març'),
    (Key: 'month.april.short';        Value: 'abr.'),
    (Key: 'month.may.short';          Value: 'maig'),
    (Key: 'month.june.short';         Value: 'juny'),
    (Key: 'month.july.short';         Value: 'jul.'),
    (Key: 'month.august.short';       Value: 'ag.'),
    (Key: 'month.september.short';    Value: 'set.'),
    (Key: 'month.october.short';      Value: 'oct.'),
    (Key: 'month.november.short';     Value: 'nov.'),
    (Key: 'month.december.short';     Value: 'des.'),

    (Key: 'weekday.sunday';           Value: 'diumenge'),
    (Key: 'weekday.monday';           Value: 'dilluns'),
    (Key: 'weekday.tuesday';          Value: 'dimarts'),
    (Key: 'weekday.wednesday';        Value: 'dimecres'),
    (Key: 'weekday.thursday';         Value: 'dijous'),
    (Key: 'weekday.friday';           Value: 'divendres'),
    (Key: 'weekday.saturday';         Value: 'dissabte'),

    (Key: 'weekday.sunday.short';     Value: 'dg.'),
    (Key: 'weekday.monday.short';     Value: 'dl.'),
    (Key: 'weekday.tuesday.short';    Value: 'dt.'),
    (Key: 'weekday.wednesday.short';  Value: 'dc.'),
    (Key: 'weekday.thursday.short';   Value: 'dj.'),
    (Key: 'weekday.friday.short';     Value: 'dv.'),
    (Key: 'weekday.saturday.short';   Value: 'ds.'),

    (Key: 'part.year';                Value: 'Any'),
    (Key: 'part.quarter';             Value: 'Trimestre'),
    (Key: 'part.month';               Value: 'Mes'),
    (Key: 'part.week';                Value: 'Setmana'),
    (Key: 'part.day';                 Value: 'Dia'),
    (Key: 'part.year.short';          Value: 'a'),
    (Key: 'part.quarter.short';       Value: 'trim'),
    (Key: 'part.month.short';         Value: 'm'),
    (Key: 'part.week.short';          Value: 'setm'),
    (Key: 'part.day.short';           Value: 'd'),
    (Key: 'part.hour';                Value: 'Hora'),
    (Key: 'part.minute';              Value: 'Minut'),
    (Key: 'part.second';              Value: 'Segon'),
    (Key: 'part.millisecond';         Value: 'Mil·lisegon'),
    (Key: 'part.hour.short';          Value: 'h'),
    (Key: 'part.minute.short';        Value: 'min'),
    (Key: 'part.second.short';        Value: 's'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Fus horari no vàlid "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Format de trimestre no vàlid "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Nom de mes no vàlid "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Nom de dia de la setmana no vàlid "%s"'),
    (Key: 'error.invalid-year';           Value: 'Any %d no vàlid (valors admesos: %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Mes %d no vàlid (valors admesos: 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Dia del mes %d no vàlid (valors admesos: 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Trimestre %d no vàlid (valors admesos: 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Dia de la setmana %d no vàlid (valors admesos: 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Data no vàlida: any %d, mes %d, dia %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Dia %d no vàlid a l’any %d'),
    (Key: 'error.date-range';             Value: 'Data fora de l’interval 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Hora no vàlida: %d h %d min %d s %d ms'),
    (Key: 'error.time-range';             Value: 'Hora del dia %d ms fora de l’interval 00:00:00.000..23:59:59.999')
  );

var
  Catalan: Chrono.TLocale;

function CatalanLocale: Chrono.TLocale;
begin
  Result := Catalan;
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
  Catalan := Chrono.TLocale.Create('ca', Chrono.TLocale.English, Lookup);

finalization
  Catalan.Free;

end.
