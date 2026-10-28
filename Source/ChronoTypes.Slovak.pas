{ ---------------------------------------------------------------------------
  Slovak texts for Chrono: month names (nominative and genitive), weekday
  names, names of date and time parts and error messages.

    uses ChronoTypes, ChronoTypes.Slovak;
    ...
    Chrono.Locale := SlovakLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Slovak;

interface

uses
  ChronoTypes;

/// <summary>
///  The Slovak locale. The month and weekday names are those of the sk-SK locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function SlovakLocale: Chrono.TLocale;

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
    (Key: 'month.march';              Value: 'marec'),
    (Key: 'month.april';              Value: 'apríl'),
    (Key: 'month.may';                Value: 'máj'),
    (Key: 'month.june';               Value: 'jún'),
    (Key: 'month.july';               Value: 'júl'),
    (Key: 'month.august';             Value: 'august'),
    (Key: 'month.september';          Value: 'september'),
    (Key: 'month.october';            Value: 'október'),
    (Key: 'month.november';           Value: 'november'),
    (Key: 'month.december';           Value: 'december'),

    (Key: 'month.january.genitive';   Value: 'januára'),
    (Key: 'month.february.genitive';  Value: 'februára'),
    (Key: 'month.march.genitive';     Value: 'marca'),
    (Key: 'month.april.genitive';     Value: 'apríla'),
    (Key: 'month.may.genitive';       Value: 'mája'),
    (Key: 'month.june.genitive';      Value: 'júna'),
    (Key: 'month.july.genitive';      Value: 'júla'),
    (Key: 'month.august.genitive';    Value: 'augusta'),
    (Key: 'month.september.genitive'; Value: 'septembra'),
    (Key: 'month.october.genitive';   Value: 'októbra'),
    (Key: 'month.november.genitive';  Value: 'novembra'),
    (Key: 'month.december.genitive';  Value: 'decembra'),

    (Key: 'month.january.short';      Value: 'jan'),
    (Key: 'month.february.short';     Value: 'feb'),
    (Key: 'month.march.short';        Value: 'mar'),
    (Key: 'month.april.short';        Value: 'apr'),
    (Key: 'month.may.short';          Value: 'máj'),
    (Key: 'month.june.short';         Value: 'jún'),
    (Key: 'month.july.short';         Value: 'júl'),
    (Key: 'month.august.short';       Value: 'aug'),
    (Key: 'month.september.short';    Value: 'sep'),
    (Key: 'month.october.short';      Value: 'okt'),
    (Key: 'month.november.short';     Value: 'nov'),
    (Key: 'month.december.short';     Value: 'dec'),

    (Key: 'weekday.sunday';           Value: 'nedeľa'),
    (Key: 'weekday.monday';           Value: 'pondelok'),
    (Key: 'weekday.tuesday';          Value: 'utorok'),
    (Key: 'weekday.wednesday';        Value: 'streda'),
    (Key: 'weekday.thursday';         Value: 'štvrtok'),
    (Key: 'weekday.friday';           Value: 'piatok'),
    (Key: 'weekday.saturday';         Value: 'sobota'),

    (Key: 'weekday.sunday.short';     Value: 'ne'),
    (Key: 'weekday.monday.short';     Value: 'po'),
    (Key: 'weekday.tuesday.short';    Value: 'ut'),
    (Key: 'weekday.wednesday.short';  Value: 'st'),
    (Key: 'weekday.thursday.short';   Value: 'št'),
    (Key: 'weekday.friday.short';     Value: 'pi'),
    (Key: 'weekday.saturday.short';   Value: 'so'),

    (Key: 'part.year';                Value: 'Rok'),
    (Key: 'part.quarter';             Value: 'Štvrťrok'),
    (Key: 'part.month';               Value: 'Mesiac'),
    (Key: 'part.week';                Value: 'Týždeň'),
    (Key: 'part.day';                 Value: 'Deň'),
    (Key: 'part.year.short';          Value: 'r'),
    (Key: 'part.quarter.short';       Value: 'štvrť'),
    (Key: 'part.month.short';         Value: 'mes'),
    (Key: 'part.week.short';          Value: 'týž'),
    (Key: 'part.day.short';           Value: 'd'),
    (Key: 'part.hour';                Value: 'Hodina'),
    (Key: 'part.minute';              Value: 'Minúta'),
    (Key: 'part.second';              Value: 'Sekunda'),
    (Key: 'part.millisecond';         Value: 'Milisekunda'),
    (Key: 'part.hour.short';          Value: 'h'),
    (Key: 'part.minute.short';        Value: 'min'),
    (Key: 'part.second.short';        Value: 's'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Neplatné časové pásmo "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Neplatný zápis štvrťroka "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Neplatný názov mesiaca "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Neplatný názov dňa v týždni "%s"'),
    (Key: 'error.invalid-year';           Value: 'Neplatný rok %d (povolené hodnoty: %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Neplatný mesiac %d (povolené hodnoty: 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Neplatný deň v mesiaci %d (povolené hodnoty: 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Neplatný štvrťrok %d (povolené hodnoty: 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Neplatný deň v týždni %d (povolené hodnoty: 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Neplatný dátum: rok %d, mesiac %d, deň %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Neplatný deň %d v roku %d'),
    (Key: 'error.date-range';             Value: 'Dátum mimo rozsahu 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Neplatný čas: %d h %d min %d s %d ms'),
    (Key: 'error.time-range';             Value: 'Čas dňa %d ms mimo rozsahu 00:00:00.000..23:59:59.999')
  );

var
  Slovak: Chrono.TLocale;

function SlovakLocale: Chrono.TLocale;
begin
  Result := Slovak;
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
  Slovak := Chrono.TLocale.Create('sk', Chrono.TLocale.English, Lookup);

finalization
  Slovak.Free;

end.
