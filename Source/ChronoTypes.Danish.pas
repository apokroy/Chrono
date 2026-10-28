{ ---------------------------------------------------------------------------
  Danish texts for Chrono: month names, weekday names, names of date and time
  parts and error messages.

    uses ChronoTypes, ChronoTypes.Danish;
    ...
    Chrono.Locale := DanishLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Danish;

interface

uses
  ChronoTypes;

/// <summary>
///  The Danish locale. The month and weekday names are those of the da-DK locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function DanishLocale: Chrono.TLocale;

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
    (Key: 'month.march';              Value: 'marts'),
    (Key: 'month.april';              Value: 'april'),
    (Key: 'month.may';                Value: 'maj'),
    (Key: 'month.june';               Value: 'juni'),
    (Key: 'month.july';               Value: 'juli'),
    (Key: 'month.august';             Value: 'august'),
    (Key: 'month.september';          Value: 'september'),
    (Key: 'month.october';            Value: 'oktober'),
    (Key: 'month.november';           Value: 'november'),
    (Key: 'month.december';           Value: 'december'),

    (Key: 'month.january.genitive';   Value: 'januar'),
    (Key: 'month.february.genitive';  Value: 'februar'),
    (Key: 'month.march.genitive';     Value: 'marts'),
    (Key: 'month.april.genitive';     Value: 'april'),
    (Key: 'month.may.genitive';       Value: 'maj'),
    (Key: 'month.june.genitive';      Value: 'juni'),
    (Key: 'month.july.genitive';      Value: 'juli'),
    (Key: 'month.august.genitive';    Value: 'august'),
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

    (Key: 'weekday.sunday';           Value: 'søndag'),
    (Key: 'weekday.monday';           Value: 'mandag'),
    (Key: 'weekday.tuesday';          Value: 'tirsdag'),
    (Key: 'weekday.wednesday';        Value: 'onsdag'),
    (Key: 'weekday.thursday';         Value: 'torsdag'),
    (Key: 'weekday.friday';           Value: 'fredag'),
    (Key: 'weekday.saturday';         Value: 'lørdag'),

    (Key: 'weekday.sunday.short';     Value: 'sø'),
    (Key: 'weekday.monday.short';     Value: 'ma'),
    (Key: 'weekday.tuesday.short';    Value: 'ti'),
    (Key: 'weekday.wednesday.short';  Value: 'on'),
    (Key: 'weekday.thursday.short';   Value: 'to'),
    (Key: 'weekday.friday.short';     Value: 'fr'),
    (Key: 'weekday.saturday.short';   Value: 'lø'),

    (Key: 'part.year';                Value: 'År'),
    (Key: 'part.quarter';             Value: 'Kvartal'),
    (Key: 'part.month';               Value: 'Måned'),
    (Key: 'part.week';                Value: 'Uge'),
    (Key: 'part.day';                 Value: 'Dag'),
    (Key: 'part.year.short';          Value: 'år'),
    (Key: 'part.quarter.short';       Value: 'kv'),
    (Key: 'part.month.short';         Value: 'md'),
    (Key: 'part.week.short';          Value: 'u'),
    (Key: 'part.day.short';           Value: 'd'),
    (Key: 'part.hour';                Value: 'Time'),
    (Key: 'part.minute';              Value: 'Minut'),
    (Key: 'part.second';              Value: 'Sekund'),
    (Key: 'part.millisecond';         Value: 'Millisekund'),
    (Key: 'part.hour.short';          Value: 't'),
    (Key: 'part.minute.short';        Value: 'min'),
    (Key: 'part.second.short';        Value: 's'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Ugyldig tidszone "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Ugyldigt kvartalsformat "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Ugyldigt månedsnavn "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Ugyldigt ugedagsnavn "%s"'),
    (Key: 'error.invalid-year';           Value: 'Ugyldigt år %d (tilladt: %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Ugyldig måned %d (tilladt: 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Ugyldig dag i måneden %d (tilladt: 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Ugyldigt kvartal %d (tilladt: 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Ugyldig ugedag %d (tilladt: 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Ugyldig dato: år %d, måned %d, dag %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Ugyldig dag %d i året %d'),
    (Key: 'error.date-range';             Value: 'Dato uden for intervallet 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Ugyldigt klokkeslæt: %d t %d min %d s %d ms'),
    (Key: 'error.time-range';             Value: 'Klokkeslæt %d ms uden for intervallet 00:00:00.000..23:59:59.999')
  );

var
  Danish: Chrono.TLocale;

function DanishLocale: Chrono.TLocale;
begin
  Result := Danish;
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
  Danish := Chrono.TLocale.Create('da', Chrono.TLocale.English, Lookup);

finalization
  Danish.Free;

end.
