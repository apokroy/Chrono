{ ---------------------------------------------------------------------------
  Turkish texts for Chrono: month names, weekday names, names of date and time
  parts and error messages.

    uses ChronoTypes, ChronoTypes.Turkish;
    ...
    Chrono.Locale := TurkishLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Turkish;

interface

uses
  ChronoTypes;

/// <summary>
///  The Turkish locale. The month and weekday names are those of the tr-TR locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function TurkishLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'Ocak'),
    (Key: 'month.february';           Value: 'Şubat'),
    (Key: 'month.march';              Value: 'Mart'),
    (Key: 'month.april';              Value: 'Nisan'),
    (Key: 'month.may';                Value: 'Mayıs'),
    (Key: 'month.june';               Value: 'Haziran'),
    (Key: 'month.july';               Value: 'Temmuz'),
    (Key: 'month.august';             Value: 'Ağustos'),
    (Key: 'month.september';          Value: 'Eylül'),
    (Key: 'month.october';            Value: 'Ekim'),
    (Key: 'month.november';           Value: 'Kasım'),
    (Key: 'month.december';           Value: 'Aralık'),

    (Key: 'month.january.genitive';   Value: 'Ocak'),
    (Key: 'month.february.genitive';  Value: 'Şubat'),
    (Key: 'month.march.genitive';     Value: 'Mart'),
    (Key: 'month.april.genitive';     Value: 'Nisan'),
    (Key: 'month.may.genitive';       Value: 'Mayıs'),
    (Key: 'month.june.genitive';      Value: 'Haziran'),
    (Key: 'month.july.genitive';      Value: 'Temmuz'),
    (Key: 'month.august.genitive';    Value: 'Ağustos'),
    (Key: 'month.september.genitive'; Value: 'Eylül'),
    (Key: 'month.october.genitive';   Value: 'Ekim'),
    (Key: 'month.november.genitive';  Value: 'Kasım'),
    (Key: 'month.december.genitive';  Value: 'Aralık'),

    (Key: 'month.january.short';      Value: 'Oca'),
    (Key: 'month.february.short';     Value: 'Şub'),
    (Key: 'month.march.short';        Value: 'Mar'),
    (Key: 'month.april.short';        Value: 'Nis'),
    (Key: 'month.may.short';          Value: 'May'),
    (Key: 'month.june.short';         Value: 'Haz'),
    (Key: 'month.july.short';         Value: 'Tem'),
    (Key: 'month.august.short';       Value: 'Ağu'),
    (Key: 'month.september.short';    Value: 'Eyl'),
    (Key: 'month.october.short';      Value: 'Eki'),
    (Key: 'month.november.short';     Value: 'Kas'),
    (Key: 'month.december.short';     Value: 'Ara'),

    (Key: 'weekday.sunday';           Value: 'Pazar'),
    (Key: 'weekday.monday';           Value: 'Pazartesi'),
    (Key: 'weekday.tuesday';          Value: 'Salı'),
    (Key: 'weekday.wednesday';        Value: 'Çarşamba'),
    (Key: 'weekday.thursday';         Value: 'Perşembe'),
    (Key: 'weekday.friday';           Value: 'Cuma'),
    (Key: 'weekday.saturday';         Value: 'Cumartesi'),

    (Key: 'weekday.sunday.short';     Value: 'Paz'),
    (Key: 'weekday.monday.short';     Value: 'Pzt'),
    (Key: 'weekday.tuesday.short';    Value: 'Sal'),
    (Key: 'weekday.wednesday.short';  Value: 'Çar'),
    (Key: 'weekday.thursday.short';   Value: 'Per'),
    (Key: 'weekday.friday.short';     Value: 'Cum'),
    (Key: 'weekday.saturday.short';   Value: 'Cmt'),

    (Key: 'part.year';                Value: 'Yıl'),
    (Key: 'part.quarter';             Value: 'Çeyrek'),
    (Key: 'part.month';               Value: 'Ay'),
    (Key: 'part.week';                Value: 'Hafta'),
    (Key: 'part.day';                 Value: 'Gün'),
    (Key: 'part.year.short';          Value: 'yıl'),
    (Key: 'part.quarter.short';       Value: 'çyr'),
    (Key: 'part.month.short';         Value: 'ay'),
    (Key: 'part.week.short';          Value: 'hft'),
    (Key: 'part.day.short';           Value: 'gün'),
    (Key: 'part.hour';                Value: 'Saat'),
    (Key: 'part.minute';              Value: 'Dakika'),
    (Key: 'part.second';              Value: 'Saniye'),
    (Key: 'part.millisecond';         Value: 'Milisaniye'),
    (Key: 'part.hour.short';          Value: 'sa'),
    (Key: 'part.minute.short';        Value: 'dk'),
    (Key: 'part.second.short';        Value: 'sn'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Geçersiz saat dilimi "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Geçersiz çeyrek biçimi "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Geçersiz ay adı "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Geçersiz gün adı "%s"'),
    (Key: 'error.invalid-year';           Value: 'Geçersiz yıl %d (geçerli aralık %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Geçersiz ay %d (geçerli aralık 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Geçersiz ayın günü %d (geçerli aralık 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Geçersiz çeyrek %d (geçerli aralık 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Geçersiz haftanın günü %d (geçerli aralık 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Geçersiz tarih: yıl %d, ay %d, gün %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Geçersiz yılın günü %d (yıl %d)'),
    (Key: 'error.date-range';             Value: 'Tarih 0001-01-01..9999-12-31 aralığının dışında'),
    (Key: 'error.invalid-time';           Value: 'Geçersiz saat: %d sa %d dk %d sn %d ms'),
    (Key: 'error.time-range';             Value: 'Günün saati %d ms, 00:00:00.000..23:59:59.999 aralığının dışında')
  );

var
  Turkish: Chrono.TLocale;

function TurkishLocale: Chrono.TLocale;
begin
  Result := Turkish;
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
  Turkish := Chrono.TLocale.Create('tr', Chrono.TLocale.English, Lookup);

finalization
  Turkish.Free;

end.
