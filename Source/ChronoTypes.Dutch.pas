{ ---------------------------------------------------------------------------
  Dutch texts for Chrono: month names, weekday names, names of date and time
  parts and error messages.

    uses ChronoTypes, ChronoTypes.Dutch;
    ...
    Chrono.Locale := DutchLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Dutch;

interface

uses
  ChronoTypes;

/// <summary>
///  The Dutch locale. The month and weekday names are those of the nl-NL locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function DutchLocale: Chrono.TLocale;

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
    (Key: 'month.march';              Value: 'maart'),
    (Key: 'month.april';              Value: 'april'),
    (Key: 'month.may';                Value: 'mei'),
    (Key: 'month.june';               Value: 'juni'),
    (Key: 'month.july';               Value: 'juli'),
    (Key: 'month.august';             Value: 'augustus'),
    (Key: 'month.september';          Value: 'september'),
    (Key: 'month.october';            Value: 'oktober'),
    (Key: 'month.november';           Value: 'november'),
    (Key: 'month.december';           Value: 'december'),

    (Key: 'month.january.genitive';   Value: 'januari'),
    (Key: 'month.february.genitive';  Value: 'februari'),
    (Key: 'month.march.genitive';     Value: 'maart'),
    (Key: 'month.april.genitive';     Value: 'april'),
    (Key: 'month.may.genitive';       Value: 'mei'),
    (Key: 'month.june.genitive';      Value: 'juni'),
    (Key: 'month.july.genitive';      Value: 'juli'),
    (Key: 'month.august.genitive';    Value: 'augustus'),
    (Key: 'month.september.genitive'; Value: 'september'),
    (Key: 'month.october.genitive';   Value: 'oktober'),
    (Key: 'month.november.genitive';  Value: 'november'),
    (Key: 'month.december.genitive';  Value: 'december'),

    (Key: 'month.january.short';      Value: 'jan'),
    (Key: 'month.february.short';     Value: 'feb'),
    (Key: 'month.march.short';        Value: 'mrt'),
    (Key: 'month.april.short';        Value: 'apr'),
    (Key: 'month.may.short';          Value: 'mei'),
    (Key: 'month.june.short';         Value: 'jun'),
    (Key: 'month.july.short';         Value: 'jul'),
    (Key: 'month.august.short';       Value: 'aug'),
    (Key: 'month.september.short';    Value: 'sep'),
    (Key: 'month.october.short';      Value: 'okt'),
    (Key: 'month.november.short';     Value: 'nov'),
    (Key: 'month.december.short';     Value: 'dec'),

    (Key: 'weekday.sunday';           Value: 'zondag'),
    (Key: 'weekday.monday';           Value: 'maandag'),
    (Key: 'weekday.tuesday';          Value: 'dinsdag'),
    (Key: 'weekday.wednesday';        Value: 'woensdag'),
    (Key: 'weekday.thursday';         Value: 'donderdag'),
    (Key: 'weekday.friday';           Value: 'vrijdag'),
    (Key: 'weekday.saturday';         Value: 'zaterdag'),

    (Key: 'weekday.sunday.short';     Value: 'zo'),
    (Key: 'weekday.monday.short';     Value: 'ma'),
    (Key: 'weekday.tuesday.short';    Value: 'di'),
    (Key: 'weekday.wednesday.short';  Value: 'wo'),
    (Key: 'weekday.thursday.short';   Value: 'do'),
    (Key: 'weekday.friday.short';     Value: 'vr'),
    (Key: 'weekday.saturday.short';   Value: 'za'),

    (Key: 'part.year';                Value: 'Jaar'),
    (Key: 'part.quarter';             Value: 'Kwartaal'),
    (Key: 'part.month';               Value: 'Maand'),
    (Key: 'part.week';                Value: 'Week'),
    (Key: 'part.day';                 Value: 'Dag'),
    (Key: 'part.year.short';          Value: 'j'),
    (Key: 'part.quarter.short';       Value: 'kw'),
    (Key: 'part.month.short';         Value: 'mnd'),
    (Key: 'part.week.short';          Value: 'wk'),
    (Key: 'part.day.short';           Value: 'd'),
    (Key: 'part.hour';                Value: 'Uur'),
    (Key: 'part.minute';              Value: 'Minuut'),
    (Key: 'part.second';              Value: 'Seconde'),
    (Key: 'part.millisecond';         Value: 'Milliseconde'),
    (Key: 'part.hour.short';          Value: 'u'),
    (Key: 'part.minute.short';        Value: 'min'),
    (Key: 'part.second.short';        Value: 's'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Ongeldige tijdzone "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Ongeldige kwartaalnotatie "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Ongeldige maandnaam "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Ongeldige weekdagnaam "%s"'),
    (Key: 'error.invalid-year';           Value: 'Ongeldig jaar %d (toegestaan: %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Ongeldige maand %d (toegestaan: 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Ongeldige dag van de maand %d (toegestaan: 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Ongeldig kwartaal %d (toegestaan: 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Ongeldige dag van de week %d (toegestaan: 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Ongeldige datum: jaar %d, maand %d, dag %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Ongeldige dag %d in het jaar %d'),
    (Key: 'error.date-range';             Value: 'Datum buiten het bereik 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Ongeldige tijd: %d u %d min %d s %d ms'),
    (Key: 'error.time-range';             Value: 'Tijdstip %d ms buiten het bereik 00:00:00.000..23:59:59.999')
  );

var
  Dutch: Chrono.TLocale;

function DutchLocale: Chrono.TLocale;
begin
  Result := Dutch;
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
  Dutch := Chrono.TLocale.Create('nl', Chrono.TLocale.English, Lookup);

finalization
  Dutch.Free;

end.
