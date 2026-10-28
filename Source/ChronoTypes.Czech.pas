{ ---------------------------------------------------------------------------
  Czech texts for Chrono: month names (nominative and genitive), weekday
  names, names of date and time parts and error messages.

    uses ChronoTypes, ChronoTypes.Czech;
    ...
    Chrono.Locale := CzechLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Czech;

interface

uses
  ChronoTypes;

/// <summary>
///  The Czech locale. The month and weekday names are those of the cs-CZ locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function CzechLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'leden'),
    (Key: 'month.february';           Value: 'únor'),
    (Key: 'month.march';              Value: 'březen'),
    (Key: 'month.april';              Value: 'duben'),
    (Key: 'month.may';                Value: 'květen'),
    (Key: 'month.june';               Value: 'červen'),
    (Key: 'month.july';               Value: 'červenec'),
    (Key: 'month.august';             Value: 'srpen'),
    (Key: 'month.september';          Value: 'září'),
    (Key: 'month.october';            Value: 'říjen'),
    (Key: 'month.november';           Value: 'listopad'),
    (Key: 'month.december';           Value: 'prosinec'),

    (Key: 'month.january.genitive';   Value: 'ledna'),
    (Key: 'month.february.genitive';  Value: 'února'),
    (Key: 'month.march.genitive';     Value: 'března'),
    (Key: 'month.april.genitive';     Value: 'dubna'),
    (Key: 'month.may.genitive';       Value: 'května'),
    (Key: 'month.june.genitive';      Value: 'června'),
    (Key: 'month.july.genitive';      Value: 'července'),
    (Key: 'month.august.genitive';    Value: 'srpna'),
    (Key: 'month.september.genitive'; Value: 'září'),
    (Key: 'month.october.genitive';   Value: 'října'),
    (Key: 'month.november.genitive';  Value: 'listopadu'),
    (Key: 'month.december.genitive';  Value: 'prosince'),

    (Key: 'month.january.short';      Value: 'led'),
    (Key: 'month.february.short';     Value: 'úno'),
    (Key: 'month.march.short';        Value: 'bře'),
    (Key: 'month.april.short';        Value: 'dub'),
    (Key: 'month.may.short';          Value: 'kvě'),
    (Key: 'month.june.short';         Value: 'čvn'),
    (Key: 'month.july.short';         Value: 'čvc'),
    (Key: 'month.august.short';       Value: 'srp'),
    (Key: 'month.september.short';    Value: 'zář'),
    (Key: 'month.october.short';      Value: 'říj'),
    (Key: 'month.november.short';     Value: 'lis'),
    (Key: 'month.december.short';     Value: 'pro'),

    (Key: 'weekday.sunday';           Value: 'neděle'),
    (Key: 'weekday.monday';           Value: 'pondělí'),
    (Key: 'weekday.tuesday';          Value: 'úterý'),
    (Key: 'weekday.wednesday';        Value: 'středa'),
    (Key: 'weekday.thursday';         Value: 'čtvrtek'),
    (Key: 'weekday.friday';           Value: 'pátek'),
    (Key: 'weekday.saturday';         Value: 'sobota'),

    (Key: 'weekday.sunday.short';     Value: 'ne'),
    (Key: 'weekday.monday.short';     Value: 'po'),
    (Key: 'weekday.tuesday.short';    Value: 'út'),
    (Key: 'weekday.wednesday.short';  Value: 'st'),
    (Key: 'weekday.thursday.short';   Value: 'čt'),
    (Key: 'weekday.friday.short';     Value: 'pá'),
    (Key: 'weekday.saturday.short';   Value: 'so'),

    (Key: 'part.year';                Value: 'Rok'),
    (Key: 'part.quarter';             Value: 'Čtvrtletí'),
    (Key: 'part.month';               Value: 'Měsíc'),
    (Key: 'part.week';                Value: 'Týden'),
    (Key: 'part.day';                 Value: 'Den'),
    (Key: 'part.year.short';          Value: 'r'),
    (Key: 'part.quarter.short';       Value: 'čtvrtl'),
    (Key: 'part.month.short';         Value: 'měs'),
    (Key: 'part.week.short';          Value: 'týd'),
    (Key: 'part.day.short';           Value: 'd'),
    (Key: 'part.hour';                Value: 'Hodina'),
    (Key: 'part.minute';              Value: 'Minuta'),
    (Key: 'part.second';              Value: 'Sekunda'),
    (Key: 'part.millisecond';         Value: 'Milisekunda'),
    (Key: 'part.hour.short';          Value: 'h'),
    (Key: 'part.minute.short';        Value: 'min'),
    (Key: 'part.second.short';        Value: 's'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Neplatné časové pásmo "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Neplatný zápis čtvrtletí "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Neplatný název měsíce "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Neplatný název dne v týdnu "%s"'),
    (Key: 'error.invalid-year';           Value: 'Neplatný rok %d (povolené hodnoty: %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Neplatný měsíc %d (povolené hodnoty: 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Neplatný den v měsíci %d (povolené hodnoty: 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Neplatné čtvrtletí %d (povolené hodnoty: 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Neplatný den v týdnu %d (povolené hodnoty: 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Neplatné datum: rok %d, měsíc %d, den %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Neplatný den %d v roce %d'),
    (Key: 'error.date-range';             Value: 'Datum mimo rozsah 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Neplatný čas: %d h %d min %d s %d ms'),
    (Key: 'error.time-range';             Value: 'Čas dne %d ms mimo rozsah 00:00:00.000..23:59:59.999')
  );

var
  Czech: Chrono.TLocale;

function CzechLocale: Chrono.TLocale;
begin
  Result := Czech;
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
  Czech := Chrono.TLocale.Create('cs', Chrono.TLocale.English, Lookup);

finalization
  Czech.Free;

end.
