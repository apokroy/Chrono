{ ---------------------------------------------------------------------------
  Latvian texts for Chrono: month names, weekday names, names of date and time
  parts and error messages.

    uses ChronoTypes, ChronoTypes.Latvian;
    ...
    Chrono.Locale := LatvianLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Latvian;

interface

uses
  ChronoTypes;

/// <summary>
///  The Latvian locale. The month and weekday names are those of the lv-LV locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function LatvianLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'janvāris'),
    (Key: 'month.february';           Value: 'februāris'),
    (Key: 'month.march';              Value: 'marts'),
    (Key: 'month.april';              Value: 'aprīlis'),
    (Key: 'month.may';                Value: 'maijs'),
    (Key: 'month.june';               Value: 'jūnijs'),
    (Key: 'month.july';               Value: 'jūlijs'),
    (Key: 'month.august';             Value: 'augusts'),
    (Key: 'month.september';          Value: 'septembris'),
    (Key: 'month.october';            Value: 'oktobris'),
    (Key: 'month.november';           Value: 'novembris'),
    (Key: 'month.december';           Value: 'decembris'),

    (Key: 'month.january.genitive';   Value: 'janvāris'),
    (Key: 'month.february.genitive';  Value: 'februāris'),
    (Key: 'month.march.genitive';     Value: 'marts'),
    (Key: 'month.april.genitive';     Value: 'aprīlis'),
    (Key: 'month.may.genitive';       Value: 'maijs'),
    (Key: 'month.june.genitive';      Value: 'jūnijs'),
    (Key: 'month.july.genitive';      Value: 'jūlijs'),
    (Key: 'month.august.genitive';    Value: 'augusts'),
    (Key: 'month.september.genitive'; Value: 'septembris'),
    (Key: 'month.october.genitive';   Value: 'oktobris'),
    (Key: 'month.november.genitive';  Value: 'novembris'),
    (Key: 'month.december.genitive';  Value: 'decembris'),

    (Key: 'month.january.short';      Value: 'janv.'),
    (Key: 'month.february.short';     Value: 'febr.'),
    (Key: 'month.march.short';        Value: 'marts'),
    (Key: 'month.april.short';        Value: 'apr.'),
    (Key: 'month.may.short';          Value: 'maijs'),
    (Key: 'month.june.short';         Value: 'jūn.'),
    (Key: 'month.july.short';         Value: 'jūl.'),
    (Key: 'month.august.short';       Value: 'aug.'),
    (Key: 'month.september.short';    Value: 'sept.'),
    (Key: 'month.october.short';      Value: 'okt.'),
    (Key: 'month.november.short';     Value: 'nov.'),
    (Key: 'month.december.short';     Value: 'dec.'),

    (Key: 'weekday.sunday';           Value: 'svētdiena'),
    (Key: 'weekday.monday';           Value: 'pirmdiena'),
    (Key: 'weekday.tuesday';          Value: 'otrdiena'),
    (Key: 'weekday.wednesday';        Value: 'trešdiena'),
    (Key: 'weekday.thursday';         Value: 'ceturtdiena'),
    (Key: 'weekday.friday';           Value: 'piektdiena'),
    (Key: 'weekday.saturday';         Value: 'sestdiena'),

    (Key: 'weekday.sunday.short';     Value: 'Svētd.'),
    (Key: 'weekday.monday.short';     Value: 'Pirmd.'),
    (Key: 'weekday.tuesday.short';    Value: 'Otrd.'),
    (Key: 'weekday.wednesday.short';  Value: 'Trešd.'),
    (Key: 'weekday.thursday.short';   Value: 'Ceturtd.'),
    (Key: 'weekday.friday.short';     Value: 'Piektd.'),
    (Key: 'weekday.saturday.short';   Value: 'Sestd.'),

    (Key: 'part.year';                Value: 'Gads'),
    (Key: 'part.quarter';             Value: 'Ceturksnis'),
    (Key: 'part.month';               Value: 'Mēnesis'),
    (Key: 'part.week';                Value: 'Nedēļa'),
    (Key: 'part.day';                 Value: 'Diena'),
    (Key: 'part.year.short';          Value: 'g'),
    (Key: 'part.quarter.short';       Value: 'cet'),
    (Key: 'part.month.short';         Value: 'mēn'),
    (Key: 'part.week.short';          Value: 'ned'),
    (Key: 'part.day.short';           Value: 'd'),
    (Key: 'part.hour';                Value: 'Stunda'),
    (Key: 'part.minute';              Value: 'Minūte'),
    (Key: 'part.second';              Value: 'Sekunde'),
    (Key: 'part.millisecond';         Value: 'Milisekunde'),
    (Key: 'part.hour.short';          Value: 'h'),
    (Key: 'part.minute.short';        Value: 'min'),
    (Key: 'part.second.short';        Value: 's'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Nederīga laika josla "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Nederīgs ceturkšņa formāts "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Nederīgs mēneša nosaukums "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Nederīgs nedēļas dienas nosaukums "%s"'),
    (Key: 'error.invalid-year';           Value: 'Nederīgs gads %d (atļauts %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Nederīgs mēnesis %d (atļauts 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Nederīga mēneša diena %d (atļauts 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Nederīgs ceturksnis %d (atļauts 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Nederīga nedēļas diena %d (atļauts 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Nederīgs datums: gads %d, mēnesis %d, diena %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Nederīga gada diena %d (gads %d)'),
    (Key: 'error.date-range';             Value: 'Datums ir ārpus diapazona 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Nederīgs laiks: %d h %d min %d s %d ms'),
    (Key: 'error.time-range';             Value: 'Diennakts laiks %d ms ir ārpus diapazona 00:00:00.000..23:59:59.999')
  );

var
  Latvian: Chrono.TLocale;

function LatvianLocale: Chrono.TLocale;
begin
  Result := Latvian;
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
  Latvian := Chrono.TLocale.Create('lv', Chrono.TLocale.English, Lookup);

finalization
  Latvian.Free;

end.
