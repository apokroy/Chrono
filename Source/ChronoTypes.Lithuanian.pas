{ ---------------------------------------------------------------------------
  Lithuanian texts for Chrono: month names (nominative and genitive), weekday
  names, names of date and time parts and error messages.

    uses ChronoTypes, ChronoTypes.Lithuanian;
    ...
    Chrono.Locale := LithuanianLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Lithuanian;

interface

uses
  ChronoTypes;

/// <summary>
///  The Lithuanian locale. The month and weekday names are those of the lt-LT locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function LithuanianLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'sausis'),
    (Key: 'month.february';           Value: 'vasaris'),
    (Key: 'month.march';              Value: 'kovas'),
    (Key: 'month.april';              Value: 'balandis'),
    (Key: 'month.may';                Value: 'gegužė'),
    (Key: 'month.june';               Value: 'birželis'),
    (Key: 'month.july';               Value: 'liepa'),
    (Key: 'month.august';             Value: 'rugpjūtis'),
    (Key: 'month.september';          Value: 'rugsėjis'),
    (Key: 'month.october';            Value: 'spalis'),
    (Key: 'month.november';           Value: 'lapkritis'),
    (Key: 'month.december';           Value: 'gruodis'),

    (Key: 'month.january.genitive';   Value: 'sausio'),
    (Key: 'month.february.genitive';  Value: 'vasario'),
    (Key: 'month.march.genitive';     Value: 'kovo'),
    (Key: 'month.april.genitive';     Value: 'balandžio'),
    (Key: 'month.may.genitive';       Value: 'gegužės'),
    (Key: 'month.june.genitive';      Value: 'birželio'),
    (Key: 'month.july.genitive';      Value: 'liepos'),
    (Key: 'month.august.genitive';    Value: 'rugpjūčio'),
    (Key: 'month.september.genitive'; Value: 'rugsėjo'),
    (Key: 'month.october.genitive';   Value: 'spalio'),
    (Key: 'month.november.genitive';  Value: 'lapkričio'),
    (Key: 'month.december.genitive';  Value: 'gruodžio'),

    (Key: 'month.january.short';      Value: 'saus.'),
    (Key: 'month.february.short';     Value: 'vas.'),
    (Key: 'month.march.short';        Value: 'kov.'),
    (Key: 'month.april.short';        Value: 'bal.'),
    (Key: 'month.may.short';          Value: 'geg.'),
    (Key: 'month.june.short';         Value: 'birž.'),
    (Key: 'month.july.short';         Value: 'liep.'),
    (Key: 'month.august.short';       Value: 'rugp.'),
    (Key: 'month.september.short';    Value: 'rugs.'),
    (Key: 'month.october.short';      Value: 'spal.'),
    (Key: 'month.november.short';     Value: 'lapkr.'),
    (Key: 'month.december.short';     Value: 'gruod.'),

    (Key: 'weekday.sunday';           Value: 'sekmadienis'),
    (Key: 'weekday.monday';           Value: 'pirmadienis'),
    (Key: 'weekday.tuesday';          Value: 'antradienis'),
    (Key: 'weekday.wednesday';        Value: 'trečiadienis'),
    (Key: 'weekday.thursday';         Value: 'ketvirtadienis'),
    (Key: 'weekday.friday';           Value: 'penktadienis'),
    (Key: 'weekday.saturday';         Value: 'šeštadienis'),

    (Key: 'weekday.sunday.short';     Value: 'sk'),
    (Key: 'weekday.monday.short';     Value: 'pr'),
    (Key: 'weekday.tuesday.short';    Value: 'an'),
    (Key: 'weekday.wednesday.short';  Value: 'tr'),
    (Key: 'weekday.thursday.short';   Value: 'kt'),
    (Key: 'weekday.friday.short';     Value: 'pn'),
    (Key: 'weekday.saturday.short';   Value: 'št'),

    (Key: 'part.year';                Value: 'Metai'),
    (Key: 'part.quarter';             Value: 'Ketvirtis'),
    (Key: 'part.month';               Value: 'Mėnuo'),
    (Key: 'part.week';                Value: 'Savaitė'),
    (Key: 'part.day';                 Value: 'Diena'),
    (Key: 'part.year.short';          Value: 'm'),
    (Key: 'part.quarter.short';       Value: 'ketv'),
    (Key: 'part.month.short';         Value: 'mėn'),
    (Key: 'part.week.short';          Value: 'sav'),
    (Key: 'part.day.short';           Value: 'd'),
    (Key: 'part.hour';                Value: 'Valanda'),
    (Key: 'part.minute';              Value: 'Minutė'),
    (Key: 'part.second';              Value: 'Sekundė'),
    (Key: 'part.millisecond';         Value: 'Milisekundė'),
    (Key: 'part.hour.short';          Value: 'val'),
    (Key: 'part.minute.short';        Value: 'min'),
    (Key: 'part.second.short';        Value: 's'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Neteisinga laiko juosta "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Neteisingas ketvirčio formatas "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Neteisingas mėnesio pavadinimas "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Neteisingas savaitės dienos pavadinimas "%s"'),
    (Key: 'error.invalid-year';           Value: 'Neteisingi metai %d (leistina %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Neteisingas mėnuo %d (leistina 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Neteisinga mėnesio diena %d (leistina 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Neteisingas ketvirtis %d (leistina 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Neteisinga savaitės diena %d (leistina 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Neteisinga data: metai %d, mėnuo %d, diena %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Neteisinga metų diena %d (metai %d)'),
    (Key: 'error.date-range';             Value: 'Data už intervalo 0001-01-01..9999-12-31 ribų'),
    (Key: 'error.invalid-time';           Value: 'Neteisingas laikas: %d val %d min %d s %d ms'),
    (Key: 'error.time-range';             Value: 'Paros laikas %d ms už intervalo 00:00:00.000..23:59:59.999 ribų')
  );

var
  Lithuanian: Chrono.TLocale;

function LithuanianLocale: Chrono.TLocale;
begin
  Result := Lithuanian;
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
  Lithuanian := Chrono.TLocale.Create('lt', Chrono.TLocale.English, Lookup);

finalization
  Lithuanian.Free;

end.
