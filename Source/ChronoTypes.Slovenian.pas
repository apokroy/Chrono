{ ---------------------------------------------------------------------------
  Slovenian texts for Chrono: month names, weekday names, names of date and
  time parts and error messages.

    uses ChronoTypes, ChronoTypes.Slovenian;
    ...
    Chrono.Locale := SlovenianLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Slovenian;

interface

uses
  ChronoTypes;

/// <summary>
///  The Slovenian locale. The month and weekday names are those of the sl-SI locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function SlovenianLocale: Chrono.TLocale;

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
    (Key: 'month.march';              Value: 'marec'),
    (Key: 'month.april';              Value: 'april'),
    (Key: 'month.may';                Value: 'maj'),
    (Key: 'month.june';               Value: 'junij'),
    (Key: 'month.july';               Value: 'julij'),
    (Key: 'month.august';             Value: 'avgust'),
    (Key: 'month.september';          Value: 'september'),
    (Key: 'month.october';            Value: 'oktober'),
    (Key: 'month.november';           Value: 'november'),
    (Key: 'month.december';           Value: 'december'),

    (Key: 'month.january.genitive';   Value: 'januar'),
    (Key: 'month.february.genitive';  Value: 'februar'),
    (Key: 'month.march.genitive';     Value: 'marec'),
    (Key: 'month.april.genitive';     Value: 'april'),
    (Key: 'month.may.genitive';       Value: 'maj'),
    (Key: 'month.june.genitive';      Value: 'junij'),
    (Key: 'month.july.genitive';      Value: 'julij'),
    (Key: 'month.august.genitive';    Value: 'avgust'),
    (Key: 'month.september.genitive'; Value: 'september'),
    (Key: 'month.october.genitive';   Value: 'oktober'),
    (Key: 'month.november.genitive';  Value: 'november'),
    (Key: 'month.december.genitive';  Value: 'december'),

    (Key: 'month.january.short';      Value: 'jan.'),
    (Key: 'month.february.short';     Value: 'feb.'),
    (Key: 'month.march.short';        Value: 'mar.'),
    (Key: 'month.april.short';        Value: 'apr.'),
    (Key: 'month.may.short';          Value: 'maj'),
    (Key: 'month.june.short';         Value: 'jun.'),
    (Key: 'month.july.short';         Value: 'jul.'),
    (Key: 'month.august.short';       Value: 'avg.'),
    (Key: 'month.september.short';    Value: 'sep.'),
    (Key: 'month.october.short';      Value: 'okt.'),
    (Key: 'month.november.short';     Value: 'nov.'),
    (Key: 'month.december.short';     Value: 'dec.'),

    (Key: 'weekday.sunday';           Value: 'nedelja'),
    (Key: 'weekday.monday';           Value: 'ponedeljek'),
    (Key: 'weekday.tuesday';          Value: 'torek'),
    (Key: 'weekday.wednesday';        Value: 'sreda'),
    (Key: 'weekday.thursday';         Value: 'četrtek'),
    (Key: 'weekday.friday';           Value: 'petek'),
    (Key: 'weekday.saturday';         Value: 'sobota'),

    (Key: 'weekday.sunday.short';     Value: 'ned.'),
    (Key: 'weekday.monday.short';     Value: 'pon.'),
    (Key: 'weekday.tuesday.short';    Value: 'tor.'),
    (Key: 'weekday.wednesday.short';  Value: 'sre.'),
    (Key: 'weekday.thursday.short';   Value: 'čet.'),
    (Key: 'weekday.friday.short';     Value: 'pet.'),
    (Key: 'weekday.saturday.short';   Value: 'sob.'),

    (Key: 'part.year';                Value: 'Leto'),
    (Key: 'part.quarter';             Value: 'Četrtletje'),
    (Key: 'part.month';               Value: 'Mesec'),
    (Key: 'part.week';                Value: 'Teden'),
    (Key: 'part.day';                 Value: 'Dan'),
    (Key: 'part.year.short';          Value: 'l'),
    (Key: 'part.quarter.short';       Value: 'četrtl'),
    (Key: 'part.month.short';         Value: 'mes'),
    (Key: 'part.week.short';          Value: 'ted'),
    (Key: 'part.day.short';           Value: 'd'),
    (Key: 'part.hour';                Value: 'Ura'),
    (Key: 'part.minute';              Value: 'Minuta'),
    (Key: 'part.second';              Value: 'Sekunda'),
    (Key: 'part.millisecond';         Value: 'Milisekunda'),
    (Key: 'part.hour.short';          Value: 'h'),
    (Key: 'part.minute.short';        Value: 'min'),
    (Key: 'part.second.short';        Value: 's'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Neveljaven časovni pas "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Neveljaven zapis četrtletja "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Neveljavno ime meseca "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Neveljavno ime dneva v tednu "%s"'),
    (Key: 'error.invalid-year';           Value: 'Neveljavno leto %d (dovoljeno %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Neveljaven mesec %d (dovoljeno 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Neveljaven dan v mesecu %d (dovoljeno 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Neveljavno četrtletje %d (dovoljeno 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Neveljaven dan v tednu %d (dovoljeno 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Neveljaven datum: leto %d, mesec %d, dan %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Neveljaven dan %d v letu %d'),
    (Key: 'error.date-range';             Value: 'Datum je zunaj obsega 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Neveljaven čas: %d h %d min %d s %d ms'),
    (Key: 'error.time-range';             Value: 'Čas dneva %d ms je zunaj obsega 00:00:00.000..23:59:59.999')
  );

var
  Slovenian: Chrono.TLocale;

function SlovenianLocale: Chrono.TLocale;
begin
  Result := Slovenian;
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
  Slovenian := Chrono.TLocale.Create('sl', Chrono.TLocale.English, Lookup);

finalization
  Slovenian.Free;

end.
