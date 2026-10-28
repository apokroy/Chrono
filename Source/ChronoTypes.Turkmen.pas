{ ---------------------------------------------------------------------------
  Turkmen texts for Chrono: month names (nominative and genitive), weekday
  names, names of date and time parts and error messages.

    uses ChronoTypes, ChronoTypes.Turkmen;
    ...
    Chrono.Locale := TurkmenLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Turkmen;

interface

uses
  ChronoTypes;

/// <summary>
///  The Turkmen locale. The month and weekday names are those of the tk-TM locale of
///  Windows, with Iýun and Iýul spelt right (Windows has a lowercase L), so dates read the
///  same on every platform. The locale is created when the unit is initialized and freed
///  when it is finalized; Chrono.Locale then returns to TLocale.System.
/// </summary>
function TurkmenLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'Ýanwar'),
    (Key: 'month.february';           Value: 'Fewral'),
    (Key: 'month.march';              Value: 'Mart'),
    (Key: 'month.april';              Value: 'Aprel'),
    (Key: 'month.may';                Value: 'Maý'),
    (Key: 'month.june';               Value: 'Iýun'),
    (Key: 'month.july';               Value: 'Iýul'),
    (Key: 'month.august';             Value: 'Awgust'),
    (Key: 'month.september';          Value: 'Sentýabr'),
    (Key: 'month.october';            Value: 'Oktýabr'),
    (Key: 'month.november';           Value: 'Noýabr'),
    (Key: 'month.december';           Value: 'Dekabr'),

    (Key: 'month.january.genitive';   Value: 'ýanwar'),
    (Key: 'month.february.genitive';  Value: 'fewral'),
    (Key: 'month.march.genitive';     Value: 'mart'),
    (Key: 'month.april.genitive';     Value: 'aprel'),
    (Key: 'month.may.genitive';       Value: 'maý'),
    (Key: 'month.june.genitive';      Value: 'iýun'),
    (Key: 'month.july.genitive';      Value: 'iýul'),
    (Key: 'month.august.genitive';    Value: 'awgust'),
    (Key: 'month.september.genitive'; Value: 'sentýabr'),
    (Key: 'month.october.genitive';   Value: 'oktýabr'),
    (Key: 'month.november.genitive';  Value: 'noýabr'),
    (Key: 'month.december.genitive';  Value: 'dekabr'),

    (Key: 'month.january.short';      Value: 'Ýan'),
    (Key: 'month.february.short';     Value: 'Few'),
    (Key: 'month.march.short';        Value: 'Mart'),
    (Key: 'month.april.short';        Value: 'Apr'),
    (Key: 'month.may.short';          Value: 'Maý'),
    (Key: 'month.june.short';         Value: 'Iýun'),
    (Key: 'month.july.short';         Value: 'Iýul'),
    (Key: 'month.august.short';       Value: 'Awg'),
    (Key: 'month.september.short';    Value: 'Sen'),
    (Key: 'month.october.short';      Value: 'Okt'),
    (Key: 'month.november.short';     Value: 'Noý'),
    (Key: 'month.december.short';     Value: 'Dek'),

    (Key: 'weekday.sunday';           Value: 'Ýekşenbe'),
    (Key: 'weekday.monday';           Value: 'Duşenbe'),
    (Key: 'weekday.tuesday';          Value: 'Sişenbe'),
    (Key: 'weekday.wednesday';        Value: 'Çarşenbe'),
    (Key: 'weekday.thursday';         Value: 'Penşenbe'),
    (Key: 'weekday.friday';           Value: 'Anna'),
    (Key: 'weekday.saturday';         Value: 'Şenbe'),

    (Key: 'weekday.sunday.short';     Value: 'Ýb'),
    (Key: 'weekday.monday.short';     Value: 'Db'),
    (Key: 'weekday.tuesday.short';    Value: 'Sb'),
    (Key: 'weekday.wednesday.short';  Value: 'Çb'),
    (Key: 'weekday.thursday.short';   Value: 'Pb'),
    (Key: 'weekday.friday.short';     Value: 'An'),
    (Key: 'weekday.saturday.short';   Value: 'Şb'),

    (Key: 'part.year';                Value: 'Ýyl'),
    (Key: 'part.quarter';             Value: 'Çärýek'),
    (Key: 'part.month';               Value: 'Aý'),
    (Key: 'part.week';                Value: 'Hepde'),
    (Key: 'part.day';                 Value: 'Gün'),
    (Key: 'part.year.short';          Value: 'ý'),
    (Key: 'part.quarter.short';       Value: 'çär'),
    (Key: 'part.month.short';         Value: 'aý'),
    (Key: 'part.week.short';          Value: 'hep'),
    (Key: 'part.day.short';           Value: 'g'),
    (Key: 'part.hour';                Value: 'Sagat'),
    (Key: 'part.minute';              Value: 'Minut'),
    (Key: 'part.second';              Value: 'Sekunt'),
    (Key: 'part.millisecond';         Value: 'Millisekunt'),
    (Key: 'part.hour.short';          Value: 'sag'),
    (Key: 'part.minute.short';        Value: 'min'),
    (Key: 'part.second.short';        Value: 'sek'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Nädogry wagt guşagy "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Çärýegiň nädogry ýazgysy "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Aýyň nädogry ady "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Hepdäniň gününiň nädogry ady "%s"'),
    (Key: 'error.invalid-year';           Value: 'Nädogry ýyl %d (rugsat berilýän %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Nädogry aý %d (rugsat berilýän 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Aýyň nädogry güni %d (rugsat berilýän 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Nädogry çärýek %d (rugsat berilýän 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Hepdäniň nädogry güni %d (rugsat berilýän 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Nädogry sene: ýyl %d, aý %d, gün %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Ýylyň nädogry güni %d (ýyl %d)'),
    (Key: 'error.date-range';             Value: 'Sene 0001-01-01..9999-12-31 aralygyndan daşarda'),
    (Key: 'error.invalid-time';           Value: 'Nädogry wagt: %d sag %d min %d sek %d ms'),
    (Key: 'error.time-range';             Value: 'Gije-gündiziň wagty %d ms 00:00:00.000..23:59:59.999 aralygyndan daşarda')
  );

var
  Turkmen: Chrono.TLocale;

function TurkmenLocale: Chrono.TLocale;
begin
  Result := Turkmen;
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
  Turkmen := Chrono.TLocale.Create('tk', Chrono.TLocale.English, Lookup);

finalization
  Turkmen.Free;

end.
