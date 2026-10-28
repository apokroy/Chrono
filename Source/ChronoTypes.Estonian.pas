{ ---------------------------------------------------------------------------
  Estonian texts for Chrono: month names, weekday names, names of date and
  time parts and error messages.

    uses ChronoTypes, ChronoTypes.Estonian;
    ...
    Chrono.Locale := EstonianLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Estonian;

interface

uses
  ChronoTypes;

/// <summary>
///  The Estonian locale. The month and weekday names are those of the et-EE locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function EstonianLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'jaanuar'),
    (Key: 'month.february';           Value: 'veebruar'),
    (Key: 'month.march';              Value: 'märts'),
    (Key: 'month.april';              Value: 'aprill'),
    (Key: 'month.may';                Value: 'mai'),
    (Key: 'month.june';               Value: 'juuni'),
    (Key: 'month.july';               Value: 'juuli'),
    (Key: 'month.august';             Value: 'august'),
    (Key: 'month.september';          Value: 'september'),
    (Key: 'month.october';            Value: 'oktoober'),
    (Key: 'month.november';           Value: 'november'),
    (Key: 'month.december';           Value: 'detsember'),

    (Key: 'month.january.genitive';   Value: 'jaanuar'),
    (Key: 'month.february.genitive';  Value: 'veebruar'),
    (Key: 'month.march.genitive';     Value: 'märts'),
    (Key: 'month.april.genitive';     Value: 'aprill'),
    (Key: 'month.may.genitive';       Value: 'mai'),
    (Key: 'month.june.genitive';      Value: 'juuni'),
    (Key: 'month.july.genitive';      Value: 'juuli'),
    (Key: 'month.august.genitive';    Value: 'august'),
    (Key: 'month.september.genitive'; Value: 'september'),
    (Key: 'month.october.genitive';   Value: 'oktoober'),
    (Key: 'month.november.genitive';  Value: 'november'),
    (Key: 'month.december.genitive';  Value: 'detsember'),

    (Key: 'month.january.short';      Value: 'jaan'),
    (Key: 'month.february.short';     Value: 'veebr'),
    (Key: 'month.march.short';        Value: 'märts'),
    (Key: 'month.april.short';        Value: 'apr'),
    (Key: 'month.may.short';          Value: 'mai'),
    (Key: 'month.june.short';         Value: 'juuni'),
    (Key: 'month.july.short';         Value: 'juuli'),
    (Key: 'month.august.short';       Value: 'aug'),
    (Key: 'month.september.short';    Value: 'sept'),
    (Key: 'month.october.short';      Value: 'okt'),
    (Key: 'month.november.short';     Value: 'nov'),
    (Key: 'month.december.short';     Value: 'dets'),

    (Key: 'weekday.sunday';           Value: 'pühapäev'),
    (Key: 'weekday.monday';           Value: 'esmaspäev'),
    (Key: 'weekday.tuesday';          Value: 'teisipäev'),
    (Key: 'weekday.wednesday';        Value: 'kolmapäev'),
    (Key: 'weekday.thursday';         Value: 'neljapäev'),
    (Key: 'weekday.friday';           Value: 'reede'),
    (Key: 'weekday.saturday';         Value: 'laupäev'),

    (Key: 'weekday.sunday.short';     Value: 'P'),
    (Key: 'weekday.monday.short';     Value: 'E'),
    (Key: 'weekday.tuesday.short';    Value: 'T'),
    (Key: 'weekday.wednesday.short';  Value: 'K'),
    (Key: 'weekday.thursday.short';   Value: 'N'),
    (Key: 'weekday.friday.short';     Value: 'R'),
    (Key: 'weekday.saturday.short';   Value: 'L'),

    (Key: 'part.year';                Value: 'Aasta'),
    (Key: 'part.quarter';             Value: 'Kvartal'),
    (Key: 'part.month';               Value: 'Kuu'),
    (Key: 'part.week';                Value: 'Nädal'),
    (Key: 'part.day';                 Value: 'Päev'),
    (Key: 'part.year.short';          Value: 'a'),
    (Key: 'part.quarter.short';       Value: 'kv'),
    (Key: 'part.month.short';         Value: 'k'),
    (Key: 'part.week.short';          Value: 'näd'),
    (Key: 'part.day.short';           Value: 'p'),
    (Key: 'part.hour';                Value: 'Tund'),
    (Key: 'part.minute';              Value: 'Minut'),
    (Key: 'part.second';              Value: 'Sekund'),
    (Key: 'part.millisecond';         Value: 'Millisekund'),
    (Key: 'part.hour.short';          Value: 't'),
    (Key: 'part.minute.short';        Value: 'min'),
    (Key: 'part.second.short';        Value: 's'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Vigane ajavöönd "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Vigane kvartali vorming "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Vigane kuu nimi "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Vigane nädalapäeva nimi "%s"'),
    (Key: 'error.invalid-year';           Value: 'Vigane aasta %d (lubatud %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Vigane kuu %d (lubatud 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Vigane kuupäev %d (lubatud 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Vigane kvartal %d (lubatud 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Vigane nädalapäev %d (lubatud 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Vigane kuupäev: aasta %d, kuu %d, päev %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Vigane aasta päev %d (aasta %d)'),
    (Key: 'error.date-range';             Value: 'Kuupäev on väljaspool vahemikku 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Vigane kellaaeg: %d t %d min %d s %d ms'),
    (Key: 'error.time-range';             Value: 'Kellaaeg %d ms on väljaspool vahemikku 00:00:00.000..23:59:59.999')
  );

var
  Estonian: Chrono.TLocale;

function EstonianLocale: Chrono.TLocale;
begin
  Result := Estonian;
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
  Estonian := Chrono.TLocale.Create('et', Chrono.TLocale.English, Lookup);

finalization
  Estonian.Free;

end.
