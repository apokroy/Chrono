{ ---------------------------------------------------------------------------
  Romanian texts for Chrono: month names, weekday names, names of date and
  time parts and error messages.

    uses ChronoTypes, ChronoTypes.Romanian;
    ...
    Chrono.Locale := RomanianLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Romanian;

interface

uses
  ChronoTypes;

/// <summary>
///  The Romanian locale. The month and weekday names are those of the ro-RO locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function RomanianLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'ianuarie'),
    (Key: 'month.february';           Value: 'februarie'),
    (Key: 'month.march';              Value: 'martie'),
    (Key: 'month.april';              Value: 'aprilie'),
    (Key: 'month.may';                Value: 'mai'),
    (Key: 'month.june';               Value: 'iunie'),
    (Key: 'month.july';               Value: 'iulie'),
    (Key: 'month.august';             Value: 'august'),
    (Key: 'month.september';          Value: 'septembrie'),
    (Key: 'month.october';            Value: 'octombrie'),
    (Key: 'month.november';           Value: 'noiembrie'),
    (Key: 'month.december';           Value: 'decembrie'),

    (Key: 'month.january.genitive';   Value: 'ianuarie'),
    (Key: 'month.february.genitive';  Value: 'februarie'),
    (Key: 'month.march.genitive';     Value: 'martie'),
    (Key: 'month.april.genitive';     Value: 'aprilie'),
    (Key: 'month.may.genitive';       Value: 'mai'),
    (Key: 'month.june.genitive';      Value: 'iunie'),
    (Key: 'month.july.genitive';      Value: 'iulie'),
    (Key: 'month.august.genitive';    Value: 'august'),
    (Key: 'month.september.genitive'; Value: 'septembrie'),
    (Key: 'month.october.genitive';   Value: 'octombrie'),
    (Key: 'month.november.genitive';  Value: 'noiembrie'),
    (Key: 'month.december.genitive';  Value: 'decembrie'),

    (Key: 'month.january.short';      Value: 'ian.'),
    (Key: 'month.february.short';     Value: 'feb.'),
    (Key: 'month.march.short';        Value: 'mar.'),
    (Key: 'month.april.short';        Value: 'apr.'),
    (Key: 'month.may.short';          Value: 'mai'),
    (Key: 'month.june.short';         Value: 'iun.'),
    (Key: 'month.july.short';         Value: 'iul.'),
    (Key: 'month.august.short';       Value: 'aug.'),
    (Key: 'month.september.short';    Value: 'sept.'),
    (Key: 'month.october.short';      Value: 'oct.'),
    (Key: 'month.november.short';     Value: 'nov.'),
    (Key: 'month.december.short';     Value: 'dec.'),

    (Key: 'weekday.sunday';           Value: 'duminică'),
    (Key: 'weekday.monday';           Value: 'luni'),
    (Key: 'weekday.tuesday';          Value: 'marți'),
    (Key: 'weekday.wednesday';        Value: 'miercuri'),
    (Key: 'weekday.thursday';         Value: 'joi'),
    (Key: 'weekday.friday';           Value: 'vineri'),
    (Key: 'weekday.saturday';         Value: 'sâmbătă'),

    (Key: 'weekday.sunday.short';     Value: 'dum.'),
    (Key: 'weekday.monday.short';     Value: 'lun.'),
    (Key: 'weekday.tuesday.short';    Value: 'mar.'),
    (Key: 'weekday.wednesday.short';  Value: 'mie.'),
    (Key: 'weekday.thursday.short';   Value: 'joi'),
    (Key: 'weekday.friday.short';     Value: 'vin.'),
    (Key: 'weekday.saturday.short';   Value: 'sâm.'),

    (Key: 'part.year';                Value: 'An'),
    (Key: 'part.quarter';             Value: 'Trimestru'),
    (Key: 'part.month';               Value: 'Lună'),
    (Key: 'part.week';                Value: 'Săptămână'),
    (Key: 'part.day';                 Value: 'Zi'),
    (Key: 'part.year.short';          Value: 'a'),
    (Key: 'part.quarter.short';       Value: 'trim'),
    (Key: 'part.month.short';         Value: 'l'),
    (Key: 'part.week.short';          Value: 'săpt'),
    (Key: 'part.day.short';           Value: 'z'),
    (Key: 'part.hour';                Value: 'Oră'),
    (Key: 'part.minute';              Value: 'Minut'),
    (Key: 'part.second';              Value: 'Secundă'),
    (Key: 'part.millisecond';         Value: 'Milisecundă'),
    (Key: 'part.hour.short';          Value: 'h'),
    (Key: 'part.minute.short';        Value: 'min'),
    (Key: 'part.second.short';        Value: 's'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Fus orar nevalid "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Format de trimestru nevalid "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Nume de lună nevalid "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Nume de zi a săptămânii nevalid "%s"'),
    (Key: 'error.invalid-year';           Value: 'An nevalid %d (intervalul valid este %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Lună nevalidă %d (intervalul valid este 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Zi a lunii nevalidă %d (intervalul valid este 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Trimestru nevalid %d (intervalul valid este 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Zi a săptămânii nevalidă %d (intervalul valid este 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Dată nevalidă: anul %d, luna %d, ziua %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Zi a anului nevalidă %d în anul %d'),
    (Key: 'error.date-range';             Value: 'Data este în afara intervalului 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Oră nevalidă: %d h %d min %d s %d ms'),
    (Key: 'error.time-range';             Value: 'Ora din zi %d ms este în afara intervalului 00:00:00.000..23:59:59.999')
  );

var
  Romanian: Chrono.TLocale;

function RomanianLocale: Chrono.TLocale;
begin
  Result := Romanian;
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
  Romanian := Chrono.TLocale.Create('ro', Chrono.TLocale.English, Lookup);

finalization
  Romanian.Free;

end.
