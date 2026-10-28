{ ---------------------------------------------------------------------------
  Hungarian texts for Chrono: month names, weekday names, names of date and
  time parts and error messages.

    uses ChronoTypes, ChronoTypes.Hungarian;
    ...
    Chrono.Locale := HungarianLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Hungarian;

interface

uses
  ChronoTypes;

/// <summary>
///  The Hungarian locale. The month and weekday names are those of the hu-HU locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function HungarianLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'január'),
    (Key: 'month.february';           Value: 'február'),
    (Key: 'month.march';              Value: 'március'),
    (Key: 'month.april';              Value: 'április'),
    (Key: 'month.may';                Value: 'május'),
    (Key: 'month.june';               Value: 'június'),
    (Key: 'month.july';               Value: 'július'),
    (Key: 'month.august';             Value: 'augusztus'),
    (Key: 'month.september';          Value: 'szeptember'),
    (Key: 'month.october';            Value: 'október'),
    (Key: 'month.november';           Value: 'november'),
    (Key: 'month.december';           Value: 'december'),

    (Key: 'month.january.genitive';   Value: 'január'),
    (Key: 'month.february.genitive';  Value: 'február'),
    (Key: 'month.march.genitive';     Value: 'március'),
    (Key: 'month.april.genitive';     Value: 'április'),
    (Key: 'month.may.genitive';       Value: 'május'),
    (Key: 'month.june.genitive';      Value: 'június'),
    (Key: 'month.july.genitive';      Value: 'július'),
    (Key: 'month.august.genitive';    Value: 'augusztus'),
    (Key: 'month.september.genitive'; Value: 'szeptember'),
    (Key: 'month.october.genitive';   Value: 'október'),
    (Key: 'month.november.genitive';  Value: 'november'),
    (Key: 'month.december.genitive';  Value: 'december'),

    (Key: 'month.january.short';      Value: 'jan.'),
    (Key: 'month.february.short';     Value: 'febr.'),
    (Key: 'month.march.short';        Value: 'márc.'),
    (Key: 'month.april.short';        Value: 'ápr.'),
    (Key: 'month.may.short';          Value: 'máj.'),
    (Key: 'month.june.short';         Value: 'jún.'),
    (Key: 'month.july.short';         Value: 'júl.'),
    (Key: 'month.august.short';       Value: 'aug.'),
    (Key: 'month.september.short';    Value: 'szept.'),
    (Key: 'month.october.short';      Value: 'okt.'),
    (Key: 'month.november.short';     Value: 'nov.'),
    (Key: 'month.december.short';     Value: 'dec.'),

    (Key: 'weekday.sunday';           Value: 'vasárnap'),
    (Key: 'weekday.monday';           Value: 'hétfő'),
    (Key: 'weekday.tuesday';          Value: 'kedd'),
    (Key: 'weekday.wednesday';        Value: 'szerda'),
    (Key: 'weekday.thursday';         Value: 'csütörtök'),
    (Key: 'weekday.friday';           Value: 'péntek'),
    (Key: 'weekday.saturday';         Value: 'szombat'),

    (Key: 'weekday.sunday.short';     Value: 'V'),
    (Key: 'weekday.monday.short';     Value: 'H'),
    (Key: 'weekday.tuesday.short';    Value: 'K'),
    (Key: 'weekday.wednesday.short';  Value: 'Sze'),
    (Key: 'weekday.thursday.short';   Value: 'Cs'),
    (Key: 'weekday.friday.short';     Value: 'P'),
    (Key: 'weekday.saturday.short';   Value: 'Szo'),

    (Key: 'part.year';                Value: 'Év'),
    (Key: 'part.quarter';             Value: 'Negyedév'),
    (Key: 'part.month';               Value: 'Hónap'),
    (Key: 'part.week';                Value: 'Hét'),
    (Key: 'part.day';                 Value: 'Nap'),
    (Key: 'part.year.short';          Value: 'é'),
    (Key: 'part.quarter.short';       Value: 'n.év'),
    (Key: 'part.month.short';         Value: 'hó'),
    (Key: 'part.week.short';          Value: 'hét'),
    (Key: 'part.day.short';           Value: 'n'),
    (Key: 'part.hour';                Value: 'Óra'),
    (Key: 'part.minute';              Value: 'Perc'),
    (Key: 'part.second';              Value: 'Másodperc'),
    (Key: 'part.millisecond';         Value: 'Ezredmásodperc'),
    (Key: 'part.hour.short';          Value: 'ó'),
    (Key: 'part.minute.short';        Value: 'p'),
    (Key: 'part.second.short';        Value: 'mp'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Érvénytelen időzóna: "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Érvénytelen negyedév-formátum: "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Érvénytelen hónapnév: "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Érvénytelen napnév: "%s"'),
    (Key: 'error.invalid-year';           Value: 'Érvénytelen év: %d (érvényes tartomány: %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Érvénytelen hónap: %d (érvényes tartomány: 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Érvénytelen nap a hónapban: %d (érvényes tartomány: 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Érvénytelen negyedév: %d (érvényes tartomány: 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Érvénytelen nap a héten: %d (érvényes tartomány: 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Érvénytelen dátum: év %d, hónap %d, nap %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Érvénytelen nap az évben: %d (év: %d)'),
    (Key: 'error.date-range';             Value: 'A dátum kívül esik a 0001-01-01..9999-12-31 tartományon'),
    (Key: 'error.invalid-time';           Value: 'Érvénytelen időpont: %d ó %d p %d mp %d ms'),
    (Key: 'error.time-range';             Value: 'A napon belüli idő (%d ms) kívül esik a 00:00:00.000..23:59:59.999 tartományon')
  );

var
  Hungarian: Chrono.TLocale;

function HungarianLocale: Chrono.TLocale;
begin
  Result := Hungarian;
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
  Hungarian := Chrono.TLocale.Create('hu', Chrono.TLocale.English, Lookup);

finalization
  Hungarian.Free;

end.
