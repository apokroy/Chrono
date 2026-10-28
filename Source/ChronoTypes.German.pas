{ ---------------------------------------------------------------------------
  German texts for Chrono: month names, weekday names, names of date and time
  parts and error messages.

    uses ChronoTypes, ChronoTypes.German;
    ...
    Chrono.Locale := GermanLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.German;

interface

uses
  ChronoTypes;

/// <summary>
///  The German locale. The month and weekday names are those of the de-DE locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function GermanLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'Januar'),
    (Key: 'month.february';           Value: 'Februar'),
    (Key: 'month.march';              Value: 'März'),
    (Key: 'month.april';              Value: 'April'),
    (Key: 'month.may';                Value: 'Mai'),
    (Key: 'month.june';               Value: 'Juni'),
    (Key: 'month.july';               Value: 'Juli'),
    (Key: 'month.august';             Value: 'August'),
    (Key: 'month.september';          Value: 'September'),
    (Key: 'month.october';            Value: 'Oktober'),
    (Key: 'month.november';           Value: 'November'),
    (Key: 'month.december';           Value: 'Dezember'),

    (Key: 'month.january.genitive';   Value: 'Januar'),
    (Key: 'month.february.genitive';  Value: 'Februar'),
    (Key: 'month.march.genitive';     Value: 'März'),
    (Key: 'month.april.genitive';     Value: 'April'),
    (Key: 'month.may.genitive';       Value: 'Mai'),
    (Key: 'month.june.genitive';      Value: 'Juni'),
    (Key: 'month.july.genitive';      Value: 'Juli'),
    (Key: 'month.august.genitive';    Value: 'August'),
    (Key: 'month.september.genitive'; Value: 'September'),
    (Key: 'month.october.genitive';   Value: 'Oktober'),
    (Key: 'month.november.genitive';  Value: 'November'),
    (Key: 'month.december.genitive';  Value: 'Dezember'),

    (Key: 'month.january.short';      Value: 'Jan'),
    (Key: 'month.february.short';     Value: 'Feb'),
    (Key: 'month.march.short';        Value: 'Mrz'),
    (Key: 'month.april.short';        Value: 'Apr'),
    (Key: 'month.may.short';          Value: 'Mai'),
    (Key: 'month.june.short';         Value: 'Jun'),
    (Key: 'month.july.short';         Value: 'Jul'),
    (Key: 'month.august.short';       Value: 'Aug'),
    (Key: 'month.september.short';    Value: 'Sep'),
    (Key: 'month.october.short';      Value: 'Okt'),
    (Key: 'month.november.short';     Value: 'Nov'),
    (Key: 'month.december.short';     Value: 'Dez'),

    (Key: 'weekday.sunday';           Value: 'Sonntag'),
    (Key: 'weekday.monday';           Value: 'Montag'),
    (Key: 'weekday.tuesday';          Value: 'Dienstag'),
    (Key: 'weekday.wednesday';        Value: 'Mittwoch'),
    (Key: 'weekday.thursday';         Value: 'Donnerstag'),
    (Key: 'weekday.friday';           Value: 'Freitag'),
    (Key: 'weekday.saturday';         Value: 'Samstag'),

    (Key: 'weekday.sunday.short';     Value: 'So'),
    (Key: 'weekday.monday.short';     Value: 'Mo'),
    (Key: 'weekday.tuesday.short';    Value: 'Di'),
    (Key: 'weekday.wednesday.short';  Value: 'Mi'),
    (Key: 'weekday.thursday.short';   Value: 'Do'),
    (Key: 'weekday.friday.short';     Value: 'Fr'),
    (Key: 'weekday.saturday.short';   Value: 'Sa'),

    (Key: 'part.year';                Value: 'Jahr'),
    (Key: 'part.quarter';             Value: 'Quartal'),
    (Key: 'part.month';               Value: 'Monat'),
    (Key: 'part.week';                Value: 'Woche'),
    (Key: 'part.day';                 Value: 'Tag'),
    (Key: 'part.year.short';          Value: 'J'),
    (Key: 'part.quarter.short';       Value: 'Q'),
    (Key: 'part.month.short';         Value: 'M'),
    (Key: 'part.week.short';          Value: 'W'),
    (Key: 'part.day.short';           Value: 'T'),
    (Key: 'part.hour';                Value: 'Stunde'),
    (Key: 'part.minute';              Value: 'Minute'),
    (Key: 'part.second';              Value: 'Sekunde'),
    (Key: 'part.millisecond';         Value: 'Millisekunde'),
    (Key: 'part.hour.short';          Value: 'h'),
    (Key: 'part.minute.short';        Value: 'min'),
    (Key: 'part.second.short';        Value: 's'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Ungültige Zeitzone "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Ungültiges Quartalsformat "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Ungültiger Monatsname "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Ungültiger Wochentagsname "%s"'),
    (Key: 'error.invalid-year';           Value: 'Ungültiges Jahr %d (zulässig: %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Ungültiger Monat %d (zulässig: 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Ungültiger Monatstag %d (zulässig: 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Ungültiges Quartal %d (zulässig: 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Ungültiger Wochentag %d (zulässig: 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Ungültiges Datum: Jahr %d, Monat %d, Tag %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Ungültiger Tag %d des Jahres %d'),
    (Key: 'error.date-range';             Value: 'Datum außerhalb des Bereichs 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Ungültige Uhrzeit: %d h %d min %d s %d ms'),
    (Key: 'error.time-range';             Value: 'Uhrzeit %d ms außerhalb des Bereichs 00:00:00.000..23:59:59.999')
  );

var
  German: Chrono.TLocale;

function GermanLocale: Chrono.TLocale;
begin
  Result := German;
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
  German := Chrono.TLocale.Create('de', Chrono.TLocale.English, Lookup);

finalization
  German.Free;

end.
