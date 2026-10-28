{ ---------------------------------------------------------------------------
  Indonesian texts for Chrono: month names, weekday names, names of date and
  time parts and error messages.

    uses ChronoTypes, ChronoTypes.Indonesian;
    ...
    Chrono.Locale := IndonesianLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Indonesian;

interface

uses
  ChronoTypes;

/// <summary>
///  The Indonesian locale. The month and weekday names are those of the id-ID locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function IndonesianLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'Januari'),
    (Key: 'month.february';           Value: 'Februari'),
    (Key: 'month.march';              Value: 'Maret'),
    (Key: 'month.april';              Value: 'April'),
    (Key: 'month.may';                Value: 'Mei'),
    (Key: 'month.june';               Value: 'Juni'),
    (Key: 'month.july';               Value: 'Juli'),
    (Key: 'month.august';             Value: 'Agustus'),
    (Key: 'month.september';          Value: 'September'),
    (Key: 'month.october';            Value: 'Oktober'),
    (Key: 'month.november';           Value: 'November'),
    (Key: 'month.december';           Value: 'Desember'),

    (Key: 'month.january.genitive';   Value: 'Januari'),
    (Key: 'month.february.genitive';  Value: 'Februari'),
    (Key: 'month.march.genitive';     Value: 'Maret'),
    (Key: 'month.april.genitive';     Value: 'April'),
    (Key: 'month.may.genitive';       Value: 'Mei'),
    (Key: 'month.june.genitive';      Value: 'Juni'),
    (Key: 'month.july.genitive';      Value: 'Juli'),
    (Key: 'month.august.genitive';    Value: 'Agustus'),
    (Key: 'month.september.genitive'; Value: 'September'),
    (Key: 'month.october.genitive';   Value: 'Oktober'),
    (Key: 'month.november.genitive';  Value: 'November'),
    (Key: 'month.december.genitive';  Value: 'Desember'),

    (Key: 'month.january.short';      Value: 'Jan'),
    (Key: 'month.february.short';     Value: 'Feb'),
    (Key: 'month.march.short';        Value: 'Mar'),
    (Key: 'month.april.short';        Value: 'Apr'),
    (Key: 'month.may.short';          Value: 'Mei'),
    (Key: 'month.june.short';         Value: 'Jun'),
    (Key: 'month.july.short';         Value: 'Jul'),
    (Key: 'month.august.short';       Value: 'Agu'),
    (Key: 'month.september.short';    Value: 'Sep'),
    (Key: 'month.october.short';      Value: 'Okt'),
    (Key: 'month.november.short';     Value: 'Nov'),
    (Key: 'month.december.short';     Value: 'Des'),

    (Key: 'weekday.sunday';           Value: 'Minggu'),
    (Key: 'weekday.monday';           Value: 'Senin'),
    (Key: 'weekday.tuesday';          Value: 'Selasa'),
    (Key: 'weekday.wednesday';        Value: 'Rabu'),
    (Key: 'weekday.thursday';         Value: 'Kamis'),
    (Key: 'weekday.friday';           Value: 'Jumat'),
    (Key: 'weekday.saturday';         Value: 'Sabtu'),

    (Key: 'weekday.sunday.short';     Value: 'Min'),
    (Key: 'weekday.monday.short';     Value: 'Sen'),
    (Key: 'weekday.tuesday.short';    Value: 'Sel'),
    (Key: 'weekday.wednesday.short';  Value: 'Rab'),
    (Key: 'weekday.thursday.short';   Value: 'Kam'),
    (Key: 'weekday.friday.short';     Value: 'Jum'),
    (Key: 'weekday.saturday.short';   Value: 'Sab'),

    (Key: 'part.year';                Value: 'Tahun'),
    (Key: 'part.quarter';             Value: 'Kuartal'),
    (Key: 'part.month';               Value: 'Bulan'),
    (Key: 'part.week';                Value: 'Minggu'),
    (Key: 'part.day';                 Value: 'Hari'),
    (Key: 'part.year.short';          Value: 'thn'),
    (Key: 'part.quarter.short';       Value: 'kw'),
    (Key: 'part.month.short';         Value: 'bln'),
    (Key: 'part.week.short';          Value: 'mgg'),
    (Key: 'part.day.short';           Value: 'hr'),
    (Key: 'part.hour';                Value: 'Jam'),
    (Key: 'part.minute';              Value: 'Menit'),
    (Key: 'part.second';              Value: 'Detik'),
    (Key: 'part.millisecond';         Value: 'Milidetik'),
    (Key: 'part.hour.short';          Value: 'jam'),
    (Key: 'part.minute.short';        Value: 'mnt'),
    (Key: 'part.second.short';        Value: 'dtk'),
    (Key: 'part.millisecond.short';   Value: 'md'),

    (Key: 'error.invalid-time-zone';      Value: 'Zona waktu tidak valid "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Format kuartal tidak valid "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Nama bulan tidak valid "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Nama hari tidak valid "%s"'),
    (Key: 'error.invalid-year';           Value: 'Tahun %d tidak valid (rentang yang valid %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Bulan %d tidak valid (rentang yang valid 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Tanggal %d tidak valid (rentang yang valid 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Kuartal %d tidak valid (rentang yang valid 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Hari dalam minggu %d tidak valid (rentang yang valid 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Tanggal tidak valid: tahun %d, bulan %d, hari %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Hari ke-%d tidak valid dalam tahun %d'),
    (Key: 'error.date-range';             Value: 'Tanggal di luar rentang 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Waktu tidak valid: %d jam %d menit %d detik %d md'),
    (Key: 'error.time-range';             Value: 'Waktu %d md di luar rentang 00:00:00.000..23:59:59.999')
  );

var
  Indonesian: Chrono.TLocale;

function IndonesianLocale: Chrono.TLocale;
begin
  Result := Indonesian;
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
  Indonesian := Chrono.TLocale.Create('id', Chrono.TLocale.English, Lookup);

finalization
  Indonesian.Free;

end.
