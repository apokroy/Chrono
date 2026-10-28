{ ---------------------------------------------------------------------------
  Croatian texts for Chrono: month names (nominative and genitive), weekday
  names, names of date and time parts and error messages.

    uses ChronoTypes, ChronoTypes.Croatian;
    ...
    Chrono.Locale := CroatianLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Croatian;

interface

uses
  ChronoTypes;

/// <summary>
///  The Croatian locale. The month and weekday names are those of the hr-HR locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function CroatianLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'siječanj'),
    (Key: 'month.february';           Value: 'veljača'),
    (Key: 'month.march';              Value: 'ožujak'),
    (Key: 'month.april';              Value: 'travanj'),
    (Key: 'month.may';                Value: 'svibanj'),
    (Key: 'month.june';               Value: 'lipanj'),
    (Key: 'month.july';               Value: 'srpanj'),
    (Key: 'month.august';             Value: 'kolovoz'),
    (Key: 'month.september';          Value: 'rujan'),
    (Key: 'month.october';            Value: 'listopad'),
    (Key: 'month.november';           Value: 'studeni'),
    (Key: 'month.december';           Value: 'prosinac'),

    (Key: 'month.january.genitive';   Value: 'siječnja'),
    (Key: 'month.february.genitive';  Value: 'veljače'),
    (Key: 'month.march.genitive';     Value: 'ožujka'),
    (Key: 'month.april.genitive';     Value: 'travnja'),
    (Key: 'month.may.genitive';       Value: 'svibnja'),
    (Key: 'month.june.genitive';      Value: 'lipnja'),
    (Key: 'month.july.genitive';      Value: 'srpnja'),
    (Key: 'month.august.genitive';    Value: 'kolovoza'),
    (Key: 'month.september.genitive'; Value: 'rujna'),
    (Key: 'month.october.genitive';   Value: 'listopada'),
    (Key: 'month.november.genitive';  Value: 'studenog'),
    (Key: 'month.december.genitive';  Value: 'prosinca'),

    (Key: 'month.january.short';      Value: 'sij'),
    (Key: 'month.february.short';     Value: 'vlj'),
    (Key: 'month.march.short';        Value: 'ožu'),
    (Key: 'month.april.short';        Value: 'tra'),
    (Key: 'month.may.short';          Value: 'svi'),
    (Key: 'month.june.short';         Value: 'lip'),
    (Key: 'month.july.short';         Value: 'srp'),
    (Key: 'month.august.short';       Value: 'kol'),
    (Key: 'month.september.short';    Value: 'ruj'),
    (Key: 'month.october.short';      Value: 'lis'),
    (Key: 'month.november.short';     Value: 'stu'),
    (Key: 'month.december.short';     Value: 'pro'),

    (Key: 'weekday.sunday';           Value: 'nedjelja'),
    (Key: 'weekday.monday';           Value: 'ponedjeljak'),
    (Key: 'weekday.tuesday';          Value: 'utorak'),
    (Key: 'weekday.wednesday';        Value: 'srijeda'),
    (Key: 'weekday.thursday';         Value: 'četvrtak'),
    (Key: 'weekday.friday';           Value: 'petak'),
    (Key: 'weekday.saturday';         Value: 'subota'),

    (Key: 'weekday.sunday.short';     Value: 'ned'),
    (Key: 'weekday.monday.short';     Value: 'pon'),
    (Key: 'weekday.tuesday.short';    Value: 'uto'),
    (Key: 'weekday.wednesday.short';  Value: 'sri'),
    (Key: 'weekday.thursday.short';   Value: 'čet'),
    (Key: 'weekday.friday.short';     Value: 'pet'),
    (Key: 'weekday.saturday.short';   Value: 'sub'),

    (Key: 'part.year';                Value: 'Godina'),
    (Key: 'part.quarter';             Value: 'Tromjesečje'),
    (Key: 'part.month';               Value: 'Mjesec'),
    (Key: 'part.week';                Value: 'Tjedan'),
    (Key: 'part.day';                 Value: 'Dan'),
    (Key: 'part.year.short';          Value: 'g'),
    (Key: 'part.quarter.short';       Value: 'tromj'),
    (Key: 'part.month.short';         Value: 'mj'),
    (Key: 'part.week.short';          Value: 'tj'),
    (Key: 'part.day.short';           Value: 'd'),
    (Key: 'part.hour';                Value: 'Sat'),
    (Key: 'part.minute';              Value: 'Minuta'),
    (Key: 'part.second';              Value: 'Sekunda'),
    (Key: 'part.millisecond';         Value: 'Milisekunda'),
    (Key: 'part.hour.short';          Value: 'h'),
    (Key: 'part.minute.short';        Value: 'min'),
    (Key: 'part.second.short';        Value: 's'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Neispravna vremenska zona "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Neispravan zapis tromjesečja "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Neispravan naziv mjeseca "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Neispravan naziv dana u tjednu "%s"'),
    (Key: 'error.invalid-year';           Value: 'Neispravna godina %d (dopušteno %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Neispravan mjesec %d (dopušteno 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Neispravan dan u mjesecu %d (dopušteno 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Neispravno tromjesečje %d (dopušteno 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Neispravan dan u tjednu %d (dopušteno 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Neispravan datum: godina %d, mjesec %d, dan %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Neispravan dan %d u godini %d'),
    (Key: 'error.date-range';             Value: 'Datum je izvan raspona 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Neispravno vrijeme: %d h %d min %d s %d ms'),
    (Key: 'error.time-range';             Value: 'Vrijeme u danu %d ms je izvan raspona 00:00:00.000..23:59:59.999')
  );

var
  Croatian: Chrono.TLocale;

function CroatianLocale: Chrono.TLocale;
begin
  Result := Croatian;
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
  Croatian := Chrono.TLocale.Create('hr', Chrono.TLocale.English, Lookup);

finalization
  Croatian.Free;

end.
