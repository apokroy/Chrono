{ ---------------------------------------------------------------------------
  Swedish texts for Chrono: month names, weekday names, names of date and time
  parts and error messages.

    uses ChronoTypes, ChronoTypes.Swedish;
    ...
    Chrono.Locale := SwedishLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Swedish;

interface

uses
  ChronoTypes;

/// <summary>
///  The Swedish locale. The month and weekday names are those of the sv-SE locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function SwedishLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'januari'),
    (Key: 'month.february';           Value: 'februari'),
    (Key: 'month.march';              Value: 'mars'),
    (Key: 'month.april';              Value: 'april'),
    (Key: 'month.may';                Value: 'maj'),
    (Key: 'month.june';               Value: 'juni'),
    (Key: 'month.july';               Value: 'juli'),
    (Key: 'month.august';             Value: 'augusti'),
    (Key: 'month.september';          Value: 'september'),
    (Key: 'month.october';            Value: 'oktober'),
    (Key: 'month.november';           Value: 'november'),
    (Key: 'month.december';           Value: 'december'),

    (Key: 'month.january.genitive';   Value: 'januari'),
    (Key: 'month.february.genitive';  Value: 'februari'),
    (Key: 'month.march.genitive';     Value: 'mars'),
    (Key: 'month.april.genitive';     Value: 'april'),
    (Key: 'month.may.genitive';       Value: 'maj'),
    (Key: 'month.june.genitive';      Value: 'juni'),
    (Key: 'month.july.genitive';      Value: 'juli'),
    (Key: 'month.august.genitive';    Value: 'augusti'),
    (Key: 'month.september.genitive'; Value: 'september'),
    (Key: 'month.october.genitive';   Value: 'oktober'),
    (Key: 'month.november.genitive';  Value: 'november'),
    (Key: 'month.december.genitive';  Value: 'december'),

    (Key: 'month.january.short';      Value: 'jan'),
    (Key: 'month.february.short';     Value: 'feb'),
    (Key: 'month.march.short';        Value: 'mar'),
    (Key: 'month.april.short';        Value: 'apr'),
    (Key: 'month.may.short';          Value: 'maj'),
    (Key: 'month.june.short';         Value: 'jun'),
    (Key: 'month.july.short';         Value: 'jul'),
    (Key: 'month.august.short';       Value: 'aug'),
    (Key: 'month.september.short';    Value: 'sep'),
    (Key: 'month.october.short';      Value: 'okt'),
    (Key: 'month.november.short';     Value: 'nov'),
    (Key: 'month.december.short';     Value: 'dec'),

    (Key: 'weekday.sunday';           Value: 'söndag'),
    (Key: 'weekday.monday';           Value: 'måndag'),
    (Key: 'weekday.tuesday';          Value: 'tisdag'),
    (Key: 'weekday.wednesday';        Value: 'onsdag'),
    (Key: 'weekday.thursday';         Value: 'torsdag'),
    (Key: 'weekday.friday';           Value: 'fredag'),
    (Key: 'weekday.saturday';         Value: 'lördag'),

    (Key: 'weekday.sunday.short';     Value: 'sön'),
    (Key: 'weekday.monday.short';     Value: 'mån'),
    (Key: 'weekday.tuesday.short';    Value: 'tis'),
    (Key: 'weekday.wednesday.short';  Value: 'ons'),
    (Key: 'weekday.thursday.short';   Value: 'tor'),
    (Key: 'weekday.friday.short';     Value: 'fre'),
    (Key: 'weekday.saturday.short';   Value: 'lör'),

    (Key: 'part.year';                Value: 'År'),
    (Key: 'part.quarter';             Value: 'Kvartal'),
    (Key: 'part.month';               Value: 'Månad'),
    (Key: 'part.week';                Value: 'Vecka'),
    (Key: 'part.day';                 Value: 'Dag'),
    (Key: 'part.year.short';          Value: 'år'),
    (Key: 'part.quarter.short';       Value: 'kv'),
    (Key: 'part.month.short';         Value: 'mån'),
    (Key: 'part.week.short';          Value: 'v'),
    (Key: 'part.day.short';           Value: 'd'),
    (Key: 'part.hour';                Value: 'Timme'),
    (Key: 'part.minute';              Value: 'Minut'),
    (Key: 'part.second';              Value: 'Sekund'),
    (Key: 'part.millisecond';         Value: 'Millisekund'),
    (Key: 'part.hour.short';          Value: 'h'),
    (Key: 'part.minute.short';        Value: 'min'),
    (Key: 'part.second.short';        Value: 's'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Ogiltig tidszon "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Ogiltigt kvartalsformat "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Ogiltigt månadsnamn "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Ogiltigt veckodagsnamn "%s"'),
    (Key: 'error.invalid-year';           Value: 'Ogiltigt år %d (tillåtet: %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Ogiltig månad %d (tillåtet: 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Ogiltig dag i månaden %d (tillåtet: 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Ogiltigt kvartal %d (tillåtet: 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Ogiltig veckodag %d (tillåtet: 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Ogiltigt datum: år %d, månad %d, dag %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Ogiltig dag %d i året %d'),
    (Key: 'error.date-range';             Value: 'Datum utanför intervallet 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Ogiltig tid: %d h %d min %d s %d ms'),
    (Key: 'error.time-range';             Value: 'Tid på dygnet %d ms utanför intervallet 00:00:00.000..23:59:59.999')
  );

var
  Swedish: Chrono.TLocale;

function SwedishLocale: Chrono.TLocale;
begin
  Result := Swedish;
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
  Swedish := Chrono.TLocale.Create('sv', Chrono.TLocale.English, Lookup);

finalization
  Swedish.Free;

end.
