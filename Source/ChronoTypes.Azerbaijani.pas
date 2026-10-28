{ ---------------------------------------------------------------------------
  Azerbaijani (Latin) texts for Chrono: month names, weekday names, names of
  date and time parts and error messages.

    uses ChronoTypes, ChronoTypes.Azerbaijani;
    ...
    Chrono.Locale := AzerbaijaniLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Azerbaijani;

interface

uses
  ChronoTypes;

/// <summary>
///  The Azerbaijani (Latin) locale. The month and weekday names are those of the az-Latn-
///  AZ locale of Windows, so dates read the same on every platform. The locale is created
///  when the unit is initialized and freed when it is finalized; Chrono.Locale then
///  returns to TLocale.System.
/// </summary>
function AzerbaijaniLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'yanvar'),
    (Key: 'month.february';           Value: 'fevral'),
    (Key: 'month.march';              Value: 'mart'),
    (Key: 'month.april';              Value: 'aprel'),
    (Key: 'month.may';                Value: 'may'),
    (Key: 'month.june';               Value: 'iyun'),
    (Key: 'month.july';               Value: 'iyul'),
    (Key: 'month.august';             Value: 'avqust'),
    (Key: 'month.september';          Value: 'sentyabr'),
    (Key: 'month.october';            Value: 'oktyabr'),
    (Key: 'month.november';           Value: 'noyabr'),
    (Key: 'month.december';           Value: 'dekabr'),

    (Key: 'month.january.genitive';   Value: 'yanvar'),
    (Key: 'month.february.genitive';  Value: 'fevral'),
    (Key: 'month.march.genitive';     Value: 'mart'),
    (Key: 'month.april.genitive';     Value: 'aprel'),
    (Key: 'month.may.genitive';       Value: 'may'),
    (Key: 'month.june.genitive';      Value: 'iyun'),
    (Key: 'month.july.genitive';      Value: 'iyul'),
    (Key: 'month.august.genitive';    Value: 'avqust'),
    (Key: 'month.september.genitive'; Value: 'sentyabr'),
    (Key: 'month.october.genitive';   Value: 'oktyabr'),
    (Key: 'month.november.genitive';  Value: 'noyabr'),
    (Key: 'month.december.genitive';  Value: 'dekabr'),

    (Key: 'month.january.short';      Value: 'yan'),
    (Key: 'month.february.short';     Value: 'fev'),
    (Key: 'month.march.short';        Value: 'mar'),
    (Key: 'month.april.short';        Value: 'apr'),
    (Key: 'month.may.short';          Value: 'may'),
    (Key: 'month.june.short';         Value: 'iyn'),
    (Key: 'month.july.short';         Value: 'iyl'),
    (Key: 'month.august.short';       Value: 'avq'),
    (Key: 'month.september.short';    Value: 'sen'),
    (Key: 'month.october.short';      Value: 'okt'),
    (Key: 'month.november.short';     Value: 'noy'),
    (Key: 'month.december.short';     Value: 'dek'),

    (Key: 'weekday.sunday';           Value: 'bazar'),
    (Key: 'weekday.monday';           Value: 'bazar ertəsi'),
    (Key: 'weekday.tuesday';          Value: 'çərşənbə axşamı'),
    (Key: 'weekday.wednesday';        Value: 'çərşənbə'),
    (Key: 'weekday.thursday';         Value: 'cümə axşamı'),
    (Key: 'weekday.friday';           Value: 'cümə'),
    (Key: 'weekday.saturday';         Value: 'şənbə'),

    (Key: 'weekday.sunday.short';     Value: 'B.'),
    (Key: 'weekday.monday.short';     Value: 'B.E.'),
    (Key: 'weekday.tuesday.short';    Value: 'Ç.A.'),
    (Key: 'weekday.wednesday.short';  Value: 'Ç.'),
    (Key: 'weekday.thursday.short';   Value: 'C.A.'),
    (Key: 'weekday.friday.short';     Value: 'C.'),
    (Key: 'weekday.saturday.short';   Value: 'Ş.'),

    (Key: 'part.year';                Value: 'İl'),
    (Key: 'part.quarter';             Value: 'Rüb'),
    (Key: 'part.month';               Value: 'Ay'),
    (Key: 'part.week';                Value: 'Həftə'),
    (Key: 'part.day';                 Value: 'Gün'),
    (Key: 'part.year.short';          Value: 'il'),
    (Key: 'part.quarter.short';       Value: 'rüb'),
    (Key: 'part.month.short';         Value: 'ay'),
    (Key: 'part.week.short';          Value: 'həf'),
    (Key: 'part.day.short';           Value: 'gün'),
    (Key: 'part.hour';                Value: 'Saat'),
    (Key: 'part.minute';              Value: 'Dəqiqə'),
    (Key: 'part.second';              Value: 'Saniyə'),
    (Key: 'part.millisecond';         Value: 'Millisaniyə'),
    (Key: 'part.hour.short';          Value: 'saat'),
    (Key: 'part.minute.short';        Value: 'dəq'),
    (Key: 'part.second.short';        Value: 'san'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Yanlış saat qurşağı "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Rübün yanlış yazılışı "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Ayın yanlış adı "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Həftə gününün yanlış adı "%s"'),
    (Key: 'error.invalid-year';           Value: 'Yanlış il %d (icazə verilən %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Yanlış ay %d (icazə verilən 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Ayın yanlış günü %d (icazə verilən 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Yanlış rüb %d (icazə verilən 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Həftə gününün yanlış nömrəsi %d (icazə verilən 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Yanlış tarix: il %d, ay %d, gün %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'İlin yanlış günü %d (il %d)'),
    (Key: 'error.date-range';             Value: 'Tarix 0001-01-01..9999-12-31 aralığından kənardadır'),
    (Key: 'error.invalid-time';           Value: 'Yanlış vaxt: %d saat %d dəq %d san %d ms'),
    (Key: 'error.time-range';             Value: 'Günün vaxtı %d ms 00:00:00.000..23:59:59.999 aralığından kənardadır')
  );

var
  Azerbaijani: Chrono.TLocale;

function AzerbaijaniLocale: Chrono.TLocale;
begin
  Result := Azerbaijani;
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
  Azerbaijani := Chrono.TLocale.Create('az', Chrono.TLocale.English, Lookup);

finalization
  Azerbaijani.Free;

end.
