{ ---------------------------------------------------------------------------
  Norwegian (Bokmål) texts for Chrono: month names, weekday names, names of
  date and time parts and error messages.

    uses ChronoTypes, ChronoTypes.Norwegian;
    ...
    Chrono.Locale := NorwegianLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Norwegian;

interface

uses
  ChronoTypes;

/// <summary>
///  The Norwegian (Bokmål) locale. The month and weekday names are those of the nb-NO
///  locale of Windows, so dates read the same on every platform. The locale is created
///  when the unit is initialized and freed when it is finalized; Chrono.Locale then
///  returns to TLocale.System.
/// </summary>
function NorwegianLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'januar'),
    (Key: 'month.february';           Value: 'februar'),
    (Key: 'month.march';              Value: 'mars'),
    (Key: 'month.april';              Value: 'april'),
    (Key: 'month.may';                Value: 'mai'),
    (Key: 'month.june';               Value: 'juni'),
    (Key: 'month.july';               Value: 'juli'),
    (Key: 'month.august';             Value: 'august'),
    (Key: 'month.september';          Value: 'september'),
    (Key: 'month.october';            Value: 'oktober'),
    (Key: 'month.november';           Value: 'november'),
    (Key: 'month.december';           Value: 'desember'),

    (Key: 'month.january.genitive';   Value: 'januar'),
    (Key: 'month.february.genitive';  Value: 'februar'),
    (Key: 'month.march.genitive';     Value: 'mars'),
    (Key: 'month.april.genitive';     Value: 'april'),
    (Key: 'month.may.genitive';       Value: 'mai'),
    (Key: 'month.june.genitive';      Value: 'juni'),
    (Key: 'month.july.genitive';      Value: 'juli'),
    (Key: 'month.august.genitive';    Value: 'august'),
    (Key: 'month.september.genitive'; Value: 'september'),
    (Key: 'month.october.genitive';   Value: 'oktober'),
    (Key: 'month.november.genitive';  Value: 'november'),
    (Key: 'month.december.genitive';  Value: 'desember'),

    (Key: 'month.january.short';      Value: 'jan'),
    (Key: 'month.february.short';     Value: 'feb'),
    (Key: 'month.march.short';        Value: 'mar'),
    (Key: 'month.april.short';        Value: 'apr'),
    (Key: 'month.may.short';          Value: 'mai'),
    (Key: 'month.june.short';         Value: 'jun'),
    (Key: 'month.july.short';         Value: 'jul'),
    (Key: 'month.august.short';       Value: 'aug'),
    (Key: 'month.september.short';    Value: 'sep'),
    (Key: 'month.october.short';      Value: 'okt'),
    (Key: 'month.november.short';     Value: 'nov'),
    (Key: 'month.december.short';     Value: 'des'),

    (Key: 'weekday.sunday';           Value: 'søndag'),
    (Key: 'weekday.monday';           Value: 'mandag'),
    (Key: 'weekday.tuesday';          Value: 'tirsdag'),
    (Key: 'weekday.wednesday';        Value: 'onsdag'),
    (Key: 'weekday.thursday';         Value: 'torsdag'),
    (Key: 'weekday.friday';           Value: 'fredag'),
    (Key: 'weekday.saturday';         Value: 'lørdag'),

    (Key: 'weekday.sunday.short';     Value: 'søn.'),
    (Key: 'weekday.monday.short';     Value: 'man.'),
    (Key: 'weekday.tuesday.short';    Value: 'tir.'),
    (Key: 'weekday.wednesday.short';  Value: 'ons.'),
    (Key: 'weekday.thursday.short';   Value: 'tor.'),
    (Key: 'weekday.friday.short';     Value: 'fre.'),
    (Key: 'weekday.saturday.short';   Value: 'lør.'),

    (Key: 'part.year';                Value: 'År'),
    (Key: 'part.quarter';             Value: 'Kvartal'),
    (Key: 'part.month';               Value: 'Måned'),
    (Key: 'part.week';                Value: 'Uke'),
    (Key: 'part.day';                 Value: 'Dag'),
    (Key: 'part.year.short';          Value: 'år'),
    (Key: 'part.quarter.short';       Value: 'kv'),
    (Key: 'part.month.short';         Value: 'md'),
    (Key: 'part.week.short';          Value: 'u'),
    (Key: 'part.day.short';           Value: 'd'),
    (Key: 'part.hour';                Value: 'Time'),
    (Key: 'part.minute';              Value: 'Minutt'),
    (Key: 'part.second';              Value: 'Sekund'),
    (Key: 'part.millisecond';         Value: 'Millisekund'),
    (Key: 'part.hour.short';          Value: 't'),
    (Key: 'part.minute.short';        Value: 'min'),
    (Key: 'part.second.short';        Value: 's'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Ugyldig tidssone "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Ugyldig kvartalsformat "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Ugyldig månedsnavn "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Ugyldig ukedagsnavn "%s"'),
    (Key: 'error.invalid-year';           Value: 'Ugyldig år %d (tillatt: %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Ugyldig måned %d (tillatt: 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Ugyldig dag i måneden %d (tillatt: 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Ugyldig kvartal %d (tillatt: 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Ugyldig ukedag %d (tillatt: 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Ugyldig dato: år %d, måned %d, dag %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Ugyldig dag %d i året %d'),
    (Key: 'error.date-range';             Value: 'Dato utenfor intervallet 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Ugyldig klokkeslett: %d t %d min %d s %d ms'),
    (Key: 'error.time-range';             Value: 'Klokkeslett %d ms utenfor intervallet 00:00:00.000..23:59:59.999')
  );

var
  Norwegian: Chrono.TLocale;

function NorwegianLocale: Chrono.TLocale;
begin
  Result := Norwegian;
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
  Norwegian := Chrono.TLocale.Create('nb', Chrono.TLocale.English, Lookup);

finalization
  Norwegian.Free;

end.
