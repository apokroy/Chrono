{ ---------------------------------------------------------------------------
  Italian texts for Chrono: month names, weekday names, names of date and time
  parts and error messages.

    uses ChronoTypes, ChronoTypes.Italian;
    ...
    Chrono.Locale := ItalianLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Italian;

interface

uses
  ChronoTypes;

/// <summary>
///  The Italian locale. The month and weekday names are those of the it-IT locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function ItalianLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'gennaio'),
    (Key: 'month.february';           Value: 'febbraio'),
    (Key: 'month.march';              Value: 'marzo'),
    (Key: 'month.april';              Value: 'aprile'),
    (Key: 'month.may';                Value: 'maggio'),
    (Key: 'month.june';               Value: 'giugno'),
    (Key: 'month.july';               Value: 'luglio'),
    (Key: 'month.august';             Value: 'agosto'),
    (Key: 'month.september';          Value: 'settembre'),
    (Key: 'month.october';            Value: 'ottobre'),
    (Key: 'month.november';           Value: 'novembre'),
    (Key: 'month.december';           Value: 'dicembre'),

    (Key: 'month.january.genitive';   Value: 'gennaio'),
    (Key: 'month.february.genitive';  Value: 'febbraio'),
    (Key: 'month.march.genitive';     Value: 'marzo'),
    (Key: 'month.april.genitive';     Value: 'aprile'),
    (Key: 'month.may.genitive';       Value: 'maggio'),
    (Key: 'month.june.genitive';      Value: 'giugno'),
    (Key: 'month.july.genitive';      Value: 'luglio'),
    (Key: 'month.august.genitive';    Value: 'agosto'),
    (Key: 'month.september.genitive'; Value: 'settembre'),
    (Key: 'month.october.genitive';   Value: 'ottobre'),
    (Key: 'month.november.genitive';  Value: 'novembre'),
    (Key: 'month.december.genitive';  Value: 'dicembre'),

    (Key: 'month.january.short';      Value: 'gen'),
    (Key: 'month.february.short';     Value: 'feb'),
    (Key: 'month.march.short';        Value: 'mar'),
    (Key: 'month.april.short';        Value: 'apr'),
    (Key: 'month.may.short';          Value: 'mag'),
    (Key: 'month.june.short';         Value: 'giu'),
    (Key: 'month.july.short';         Value: 'lug'),
    (Key: 'month.august.short';       Value: 'ago'),
    (Key: 'month.september.short';    Value: 'set'),
    (Key: 'month.october.short';      Value: 'ott'),
    (Key: 'month.november.short';     Value: 'nov'),
    (Key: 'month.december.short';     Value: 'dic'),

    (Key: 'weekday.sunday';           Value: 'domenica'),
    (Key: 'weekday.monday';           Value: 'lunedì'),
    (Key: 'weekday.tuesday';          Value: 'martedì'),
    (Key: 'weekday.wednesday';        Value: 'mercoledì'),
    (Key: 'weekday.thursday';         Value: 'giovedì'),
    (Key: 'weekday.friday';           Value: 'venerdì'),
    (Key: 'weekday.saturday';         Value: 'sabato'),

    (Key: 'weekday.sunday.short';     Value: 'dom'),
    (Key: 'weekday.monday.short';     Value: 'lun'),
    (Key: 'weekday.tuesday.short';    Value: 'mar'),
    (Key: 'weekday.wednesday.short';  Value: 'mer'),
    (Key: 'weekday.thursday.short';   Value: 'gio'),
    (Key: 'weekday.friday.short';     Value: 'ven'),
    (Key: 'weekday.saturday.short';   Value: 'sab'),

    (Key: 'part.year';                Value: 'Anno'),
    (Key: 'part.quarter';             Value: 'Trimestre'),
    (Key: 'part.month';               Value: 'Mese'),
    (Key: 'part.week';                Value: 'Settimana'),
    (Key: 'part.day';                 Value: 'Giorno'),
    (Key: 'part.year.short';          Value: 'a'),
    (Key: 'part.quarter.short';       Value: 'trim'),
    (Key: 'part.month.short';         Value: 'm'),
    (Key: 'part.week.short';          Value: 'sett'),
    (Key: 'part.day.short';           Value: 'g'),
    (Key: 'part.hour';                Value: 'Ora'),
    (Key: 'part.minute';              Value: 'Minuto'),
    (Key: 'part.second';              Value: 'Secondo'),
    (Key: 'part.millisecond';         Value: 'Millisecondo'),
    (Key: 'part.hour.short';          Value: 'h'),
    (Key: 'part.minute.short';        Value: 'min'),
    (Key: 'part.second.short';        Value: 's'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Fuso orario "%s" non valido'),
    (Key: 'error.invalid-quarter';        Value: 'Formato del trimestre "%s" non valido'),
    (Key: 'error.invalid-month-name';     Value: 'Nome del mese "%s" non valido'),
    (Key: 'error.invalid-weekday-name';   Value: 'Nome del giorno della settimana "%s" non valido'),
    (Key: 'error.invalid-year';           Value: 'Anno %d non valido (valori ammessi: %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Mese %d non valido (valori ammessi: 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Giorno del mese %d non valido (valori ammessi: 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Trimestre %d non valido (valori ammessi: 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Giorno della settimana %d non valido (valori ammessi: 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Data non valida: anno %d, mese %d, giorno %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Giorno %d non valido nell''anno %d'),
    (Key: 'error.date-range';             Value: 'Data fuori dall''intervallo 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Ora non valida: %d h %d min %d s %d ms'),
    (Key: 'error.time-range';             Value: 'Ora del giorno %d ms fuori dall''intervallo 00:00:00.000..23:59:59.999')
  );

var
  Italian: Chrono.TLocale;

function ItalianLocale: Chrono.TLocale;
begin
  Result := Italian;
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
  Italian := Chrono.TLocale.Create('it', Chrono.TLocale.English, Lookup);

finalization
  Italian.Free;

end.
