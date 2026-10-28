{ ---------------------------------------------------------------------------
  Polish texts for Chrono: month names (nominative and genitive), weekday
  names, names of date and time parts and error messages.

    uses ChronoTypes, ChronoTypes.Polish;
    ...
    Chrono.Locale := PolishLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Polish;

interface

uses
  ChronoTypes;

/// <summary>
///  The Polish locale. The month and weekday names are those of the pl-PL locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function PolishLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'styczeń'),
    (Key: 'month.february';           Value: 'luty'),
    (Key: 'month.march';              Value: 'marzec'),
    (Key: 'month.april';              Value: 'kwiecień'),
    (Key: 'month.may';                Value: 'maj'),
    (Key: 'month.june';               Value: 'czerwiec'),
    (Key: 'month.july';               Value: 'lipiec'),
    (Key: 'month.august';             Value: 'sierpień'),
    (Key: 'month.september';          Value: 'wrzesień'),
    (Key: 'month.october';            Value: 'październik'),
    (Key: 'month.november';           Value: 'listopad'),
    (Key: 'month.december';           Value: 'grudzień'),

    (Key: 'month.january.genitive';   Value: 'stycznia'),
    (Key: 'month.february.genitive';  Value: 'lutego'),
    (Key: 'month.march.genitive';     Value: 'marca'),
    (Key: 'month.april.genitive';     Value: 'kwietnia'),
    (Key: 'month.may.genitive';       Value: 'maja'),
    (Key: 'month.june.genitive';      Value: 'czerwca'),
    (Key: 'month.july.genitive';      Value: 'lipca'),
    (Key: 'month.august.genitive';    Value: 'sierpnia'),
    (Key: 'month.september.genitive'; Value: 'września'),
    (Key: 'month.october.genitive';   Value: 'października'),
    (Key: 'month.november.genitive';  Value: 'listopada'),
    (Key: 'month.december.genitive';  Value: 'grudnia'),

    (Key: 'month.january.short';      Value: 'sty'),
    (Key: 'month.february.short';     Value: 'lut'),
    (Key: 'month.march.short';        Value: 'mar'),
    (Key: 'month.april.short';        Value: 'kwi'),
    (Key: 'month.may.short';          Value: 'maj'),
    (Key: 'month.june.short';         Value: 'cze'),
    (Key: 'month.july.short';         Value: 'lip'),
    (Key: 'month.august.short';       Value: 'sie'),
    (Key: 'month.september.short';    Value: 'wrz'),
    (Key: 'month.october.short';      Value: 'paź'),
    (Key: 'month.november.short';     Value: 'lis'),
    (Key: 'month.december.short';     Value: 'gru'),

    (Key: 'weekday.sunday';           Value: 'niedziela'),
    (Key: 'weekday.monday';           Value: 'poniedziałek'),
    (Key: 'weekday.tuesday';          Value: 'wtorek'),
    (Key: 'weekday.wednesday';        Value: 'środa'),
    (Key: 'weekday.thursday';         Value: 'czwartek'),
    (Key: 'weekday.friday';           Value: 'piątek'),
    (Key: 'weekday.saturday';         Value: 'sobota'),

    (Key: 'weekday.sunday.short';     Value: 'niedz.'),
    (Key: 'weekday.monday.short';     Value: 'pon.'),
    (Key: 'weekday.tuesday.short';    Value: 'wt.'),
    (Key: 'weekday.wednesday.short';  Value: 'śr.'),
    (Key: 'weekday.thursday.short';   Value: 'czw.'),
    (Key: 'weekday.friday.short';     Value: 'pt.'),
    (Key: 'weekday.saturday.short';   Value: 'sob.'),

    (Key: 'part.year';                Value: 'Rok'),
    (Key: 'part.quarter';             Value: 'Kwartał'),
    (Key: 'part.month';               Value: 'Miesiąc'),
    (Key: 'part.week';                Value: 'Tydzień'),
    (Key: 'part.day';                 Value: 'Dzień'),
    (Key: 'part.year.short';          Value: 'r'),
    (Key: 'part.quarter.short';       Value: 'kw'),
    (Key: 'part.month.short';         Value: 'mies'),
    (Key: 'part.week.short';          Value: 'tydz'),
    (Key: 'part.day.short';           Value: 'dz'),
    (Key: 'part.hour';                Value: 'Godzina'),
    (Key: 'part.minute';              Value: 'Minuta'),
    (Key: 'part.second';              Value: 'Sekunda'),
    (Key: 'part.millisecond';         Value: 'Milisekunda'),
    (Key: 'part.hour.short';          Value: 'h'),
    (Key: 'part.minute.short';        Value: 'min'),
    (Key: 'part.second.short';        Value: 's'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Nieprawidłowa strefa czasowa "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Nieprawidłowy zapis kwartału "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Nieprawidłowa nazwa miesiąca "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Nieprawidłowa nazwa dnia tygodnia "%s"'),
    (Key: 'error.invalid-year';           Value: 'Nieprawidłowy rok %d (dopuszczalne %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Nieprawidłowy miesiąc %d (dopuszczalne 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Nieprawidłowy dzień miesiąca %d (dopuszczalne 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Nieprawidłowy kwartał %d (dopuszczalne 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Nieprawidłowy dzień tygodnia %d (dopuszczalne 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Nieprawidłowa data: rok %d, miesiąc %d, dzień %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Nieprawidłowy numer dnia %d w roku %d'),
    (Key: 'error.date-range';             Value: 'Data poza zakresem 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Nieprawidłowy czas: %d h %d min %d s %d ms'),
    (Key: 'error.time-range';             Value: 'Czas %d ms poza zakresem 00:00:00.000..23:59:59.999')
  );

var
  Polish: Chrono.TLocale;

function PolishLocale: Chrono.TLocale;
begin
  Result := Polish;
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
  Polish := Chrono.TLocale.Create('pl', Chrono.TLocale.English, Lookup);

finalization
  Polish.Free;

end.
