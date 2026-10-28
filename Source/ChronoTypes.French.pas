{ ---------------------------------------------------------------------------
  French texts for Chrono: month names, weekday names, names of date and time
  parts and error messages.

    uses ChronoTypes, ChronoTypes.French;
    ...
    Chrono.Locale := FrenchLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.French;

interface

uses
  ChronoTypes;

/// <summary>
///  The French locale. The month and weekday names are those of the fr-FR locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function FrenchLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'janvier'),
    (Key: 'month.february';           Value: 'février'),
    (Key: 'month.march';              Value: 'mars'),
    (Key: 'month.april';              Value: 'avril'),
    (Key: 'month.may';                Value: 'mai'),
    (Key: 'month.june';               Value: 'juin'),
    (Key: 'month.july';               Value: 'juillet'),
    (Key: 'month.august';             Value: 'août'),
    (Key: 'month.september';          Value: 'septembre'),
    (Key: 'month.october';            Value: 'octobre'),
    (Key: 'month.november';           Value: 'novembre'),
    (Key: 'month.december';           Value: 'décembre'),

    (Key: 'month.january.genitive';   Value: 'janvier'),
    (Key: 'month.february.genitive';  Value: 'février'),
    (Key: 'month.march.genitive';     Value: 'mars'),
    (Key: 'month.april.genitive';     Value: 'avril'),
    (Key: 'month.may.genitive';       Value: 'mai'),
    (Key: 'month.june.genitive';      Value: 'juin'),
    (Key: 'month.july.genitive';      Value: 'juillet'),
    (Key: 'month.august.genitive';    Value: 'août'),
    (Key: 'month.september.genitive'; Value: 'septembre'),
    (Key: 'month.october.genitive';   Value: 'octobre'),
    (Key: 'month.november.genitive';  Value: 'novembre'),
    (Key: 'month.december.genitive';  Value: 'décembre'),

    (Key: 'month.january.short';      Value: 'janv.'),
    (Key: 'month.february.short';     Value: 'févr.'),
    (Key: 'month.march.short';        Value: 'mars'),
    (Key: 'month.april.short';        Value: 'avr.'),
    (Key: 'month.may.short';          Value: 'mai'),
    (Key: 'month.june.short';         Value: 'juin'),
    (Key: 'month.july.short';         Value: 'juil.'),
    (Key: 'month.august.short';       Value: 'août'),
    (Key: 'month.september.short';    Value: 'sept.'),
    (Key: 'month.october.short';      Value: 'oct.'),
    (Key: 'month.november.short';     Value: 'nov.'),
    (Key: 'month.december.short';     Value: 'déc.'),

    (Key: 'weekday.sunday';           Value: 'dimanche'),
    (Key: 'weekday.monday';           Value: 'lundi'),
    (Key: 'weekday.tuesday';          Value: 'mardi'),
    (Key: 'weekday.wednesday';        Value: 'mercredi'),
    (Key: 'weekday.thursday';         Value: 'jeudi'),
    (Key: 'weekday.friday';           Value: 'vendredi'),
    (Key: 'weekday.saturday';         Value: 'samedi'),

    (Key: 'weekday.sunday.short';     Value: 'dim.'),
    (Key: 'weekday.monday.short';     Value: 'lun.'),
    (Key: 'weekday.tuesday.short';    Value: 'mar.'),
    (Key: 'weekday.wednesday.short';  Value: 'mer.'),
    (Key: 'weekday.thursday.short';   Value: 'jeu.'),
    (Key: 'weekday.friday.short';     Value: 'ven.'),
    (Key: 'weekday.saturday.short';   Value: 'sam.'),

    (Key: 'part.year';                Value: 'Année'),
    (Key: 'part.quarter';             Value: 'Trimestre'),
    (Key: 'part.month';               Value: 'Mois'),
    (Key: 'part.week';                Value: 'Semaine'),
    (Key: 'part.day';                 Value: 'Jour'),
    (Key: 'part.year.short';          Value: 'a'),
    (Key: 'part.quarter.short';       Value: 'trim'),
    (Key: 'part.month.short';         Value: 'mois'),
    (Key: 'part.week.short';          Value: 'sem'),
    (Key: 'part.day.short';           Value: 'j'),
    (Key: 'part.hour';                Value: 'Heure'),
    (Key: 'part.minute';              Value: 'Minute'),
    (Key: 'part.second';              Value: 'Seconde'),
    (Key: 'part.millisecond';         Value: 'Milliseconde'),
    (Key: 'part.hour.short';          Value: 'h'),
    (Key: 'part.minute.short';        Value: 'min'),
    (Key: 'part.second.short';        Value: 's'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Fuseau horaire "%s" non valide'),
    (Key: 'error.invalid-quarter';        Value: 'Format de trimestre "%s" non valide'),
    (Key: 'error.invalid-month-name';     Value: 'Nom de mois "%s" non valide'),
    (Key: 'error.invalid-weekday-name';   Value: 'Nom de jour de la semaine "%s" non valide'),
    (Key: 'error.invalid-year';           Value: 'Année %d non valide (valeurs admises : %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Mois %d non valide (valeurs admises : 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Jour du mois %d non valide (valeurs admises : 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Trimestre %d non valide (valeurs admises : 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Jour de la semaine %d non valide (valeurs admises : 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Date non valide : année %d, mois %d, jour %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Jour %d non valide dans l''année %d'),
    (Key: 'error.date-range';             Value: 'Date hors de la plage 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Heure non valide : %d h %d min %d s %d ms'),
    (Key: 'error.time-range';             Value: 'Heure du jour %d ms hors de la plage 00:00:00.000..23:59:59.999')
  );

var
  French: Chrono.TLocale;

function FrenchLocale: Chrono.TLocale;
begin
  Result := French;
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
  French := Chrono.TLocale.Create('fr', Chrono.TLocale.English, Lookup);

finalization
  French.Free;

end.
