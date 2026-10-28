{ ---------------------------------------------------------------------------
  Finnish texts for Chrono: month names (nominative and genitive), weekday
  names, names of date and time parts and error messages.

    uses ChronoTypes, ChronoTypes.Finnish;
    ...
    Chrono.Locale := FinnishLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Finnish;

interface

uses
  ChronoTypes;

/// <summary>
///  The Finnish locale. The month and weekday names are those of the fi-FI locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function FinnishLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'tammikuu'),
    (Key: 'month.february';           Value: 'helmikuu'),
    (Key: 'month.march';              Value: 'maaliskuu'),
    (Key: 'month.april';              Value: 'huhtikuu'),
    (Key: 'month.may';                Value: 'toukokuu'),
    (Key: 'month.june';               Value: 'kesäkuu'),
    (Key: 'month.july';               Value: 'heinäkuu'),
    (Key: 'month.august';             Value: 'elokuu'),
    (Key: 'month.september';          Value: 'syyskuu'),
    (Key: 'month.october';            Value: 'lokakuu'),
    (Key: 'month.november';           Value: 'marraskuu'),
    (Key: 'month.december';           Value: 'joulukuu'),

    (Key: 'month.january.genitive';   Value: 'tammikuuta'),
    (Key: 'month.february.genitive';  Value: 'helmikuuta'),
    (Key: 'month.march.genitive';     Value: 'maaliskuuta'),
    (Key: 'month.april.genitive';     Value: 'huhtikuuta'),
    (Key: 'month.may.genitive';       Value: 'toukokuuta'),
    (Key: 'month.june.genitive';      Value: 'kesäkuuta'),
    (Key: 'month.july.genitive';      Value: 'heinäkuuta'),
    (Key: 'month.august.genitive';    Value: 'elokuuta'),
    (Key: 'month.september.genitive'; Value: 'syyskuuta'),
    (Key: 'month.october.genitive';   Value: 'lokakuuta'),
    (Key: 'month.november.genitive';  Value: 'marraskuuta'),
    (Key: 'month.december.genitive';  Value: 'joulukuuta'),

    (Key: 'month.january.short';      Value: 'tammi'),
    (Key: 'month.february.short';     Value: 'helmi'),
    (Key: 'month.march.short';        Value: 'maalis'),
    (Key: 'month.april.short';        Value: 'huhti'),
    (Key: 'month.may.short';          Value: 'touko'),
    (Key: 'month.june.short';         Value: 'kesä'),
    (Key: 'month.july.short';         Value: 'heinä'),
    (Key: 'month.august.short';       Value: 'elo'),
    (Key: 'month.september.short';    Value: 'syys'),
    (Key: 'month.october.short';      Value: 'loka'),
    (Key: 'month.november.short';     Value: 'marras'),
    (Key: 'month.december.short';     Value: 'joulu'),

    (Key: 'weekday.sunday';           Value: 'sunnuntai'),
    (Key: 'weekday.monday';           Value: 'maanantai'),
    (Key: 'weekday.tuesday';          Value: 'tiistai'),
    (Key: 'weekday.wednesday';        Value: 'keskiviikko'),
    (Key: 'weekday.thursday';         Value: 'torstai'),
    (Key: 'weekday.friday';           Value: 'perjantai'),
    (Key: 'weekday.saturday';         Value: 'lauantai'),

    (Key: 'weekday.sunday.short';     Value: 'su'),
    (Key: 'weekday.monday.short';     Value: 'ma'),
    (Key: 'weekday.tuesday.short';    Value: 'ti'),
    (Key: 'weekday.wednesday.short';  Value: 'ke'),
    (Key: 'weekday.thursday.short';   Value: 'to'),
    (Key: 'weekday.friday.short';     Value: 'pe'),
    (Key: 'weekday.saturday.short';   Value: 'la'),

    (Key: 'part.year';                Value: 'Vuosi'),
    (Key: 'part.quarter';             Value: 'Neljännes'),
    (Key: 'part.month';               Value: 'Kuukausi'),
    (Key: 'part.week';                Value: 'Viikko'),
    (Key: 'part.day';                 Value: 'Päivä'),
    (Key: 'part.year.short';          Value: 'v'),
    (Key: 'part.quarter.short';       Value: 'nelj'),
    (Key: 'part.month.short';         Value: 'kk'),
    (Key: 'part.week.short';          Value: 'vk'),
    (Key: 'part.day.short';           Value: 'pv'),
    (Key: 'part.hour';                Value: 'Tunti'),
    (Key: 'part.minute';              Value: 'Minuutti'),
    (Key: 'part.second';              Value: 'Sekunti'),
    (Key: 'part.millisecond';         Value: 'Millisekunti'),
    (Key: 'part.hour.short';          Value: 'h'),
    (Key: 'part.minute.short';        Value: 'min'),
    (Key: 'part.second.short';        Value: 's'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Virheellinen aikavyöhyke "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Virheellinen neljänneksen muoto "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Virheellinen kuukauden nimi "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Virheellinen viikonpäivän nimi "%s"'),
    (Key: 'error.invalid-year';           Value: 'Virheellinen vuosi %d (sallittu alue %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Virheellinen kuukausi %d (sallittu alue 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Virheellinen kuukauden päivä %d (sallittu alue 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Virheellinen neljännes %d (sallittu alue 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Virheellinen viikonpäivä %d (sallittu alue 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Virheellinen päivämäärä: vuosi %d, kuukausi %d, päivä %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Virheellinen vuoden päivä %d vuonna %d'),
    (Key: 'error.date-range';             Value: 'Päivämäärä on alueen 0001-01-01..9999-12-31 ulkopuolella'),
    (Key: 'error.invalid-time';           Value: 'Virheellinen kellonaika: %d h %d min %d s %d ms'),
    (Key: 'error.time-range';             Value: 'Kellonaika %d ms on alueen 00:00:00.000..23:59:59.999 ulkopuolella')
  );

var
  Finnish: Chrono.TLocale;

function FinnishLocale: Chrono.TLocale;
begin
  Result := Finnish;
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
  Finnish := Chrono.TLocale.Create('fi', Chrono.TLocale.English, Lookup);

finalization
  Finnish.Free;

end.
