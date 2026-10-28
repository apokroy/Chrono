{ ---------------------------------------------------------------------------
  Vietnamese texts for Chrono: month names, weekday names, names of date and
  time parts and error messages.

    uses ChronoTypes, ChronoTypes.Vietnamese;
    ...
    Chrono.Locale := VietnameseLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Vietnamese;

interface

uses
  ChronoTypes;

/// <summary>
///  The Vietnamese locale. The month and weekday names are those of the vi-VN locale of
///  Windows in the composed form (NFC) that people type; Windows keeps them decomposed, so
///  dates read the same on every platform. The locale is created when the unit is
///  initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function VietnameseLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'Tháng Giêng'),
    (Key: 'month.february';           Value: 'Tháng Hai'),
    (Key: 'month.march';              Value: 'Tháng Ba'),
    (Key: 'month.april';              Value: 'Tháng Tư'),
    (Key: 'month.may';                Value: 'Tháng Năm'),
    (Key: 'month.june';               Value: 'Tháng Sáu'),
    (Key: 'month.july';               Value: 'Tháng Bảy'),
    (Key: 'month.august';             Value: 'Tháng Tám'),
    (Key: 'month.september';          Value: 'Tháng Chín'),
    (Key: 'month.october';            Value: 'Tháng Mười'),
    (Key: 'month.november';           Value: 'Tháng Mười Một'),
    (Key: 'month.december';           Value: 'Tháng Mười Hai'),

    (Key: 'month.january.genitive';   Value: 'Tháng Giêng'),
    (Key: 'month.february.genitive';  Value: 'Tháng Hai'),
    (Key: 'month.march.genitive';     Value: 'Tháng Ba'),
    (Key: 'month.april.genitive';     Value: 'Tháng Tư'),
    (Key: 'month.may.genitive';       Value: 'Tháng Năm'),
    (Key: 'month.june.genitive';      Value: 'Tháng Sáu'),
    (Key: 'month.july.genitive';      Value: 'Tháng Bảy'),
    (Key: 'month.august.genitive';    Value: 'Tháng Tám'),
    (Key: 'month.september.genitive'; Value: 'Tháng Chín'),
    (Key: 'month.october.genitive';   Value: 'Tháng Mười'),
    (Key: 'month.november.genitive';  Value: 'Tháng Mười Một'),
    (Key: 'month.december.genitive';  Value: 'Tháng Mười Hai'),

    (Key: 'month.january.short';      Value: 'Thg1'),
    (Key: 'month.february.short';     Value: 'Thg2'),
    (Key: 'month.march.short';        Value: 'Thg3'),
    (Key: 'month.april.short';        Value: 'Thg4'),
    (Key: 'month.may.short';          Value: 'Thg5'),
    (Key: 'month.june.short';         Value: 'Thg6'),
    (Key: 'month.july.short';         Value: 'Thg7'),
    (Key: 'month.august.short';       Value: 'Thg8'),
    (Key: 'month.september.short';    Value: 'Thg9'),
    (Key: 'month.october.short';      Value: 'Thg10'),
    (Key: 'month.november.short';     Value: 'Thg11'),
    (Key: 'month.december.short';     Value: 'Thg12'),

    (Key: 'weekday.sunday';           Value: 'Chủ Nhật'),
    (Key: 'weekday.monday';           Value: 'Thứ Hai'),
    (Key: 'weekday.tuesday';          Value: 'Thứ Ba'),
    (Key: 'weekday.wednesday';        Value: 'Thứ Tư'),
    (Key: 'weekday.thursday';         Value: 'Thứ Năm'),
    (Key: 'weekday.friday';           Value: 'Thứ Sáu'),
    (Key: 'weekday.saturday';         Value: 'Thứ Bảy'),

    (Key: 'weekday.sunday.short';     Value: 'CN'),
    (Key: 'weekday.monday.short';     Value: 'T2'),
    (Key: 'weekday.tuesday.short';    Value: 'T3'),
    (Key: 'weekday.wednesday.short';  Value: 'T4'),
    (Key: 'weekday.thursday.short';   Value: 'T5'),
    (Key: 'weekday.friday.short';     Value: 'T6'),
    (Key: 'weekday.saturday.short';   Value: 'T7'),

    (Key: 'part.year';                Value: 'Năm'),
    (Key: 'part.quarter';             Value: 'Quý'),
    (Key: 'part.month';               Value: 'Tháng'),
    (Key: 'part.week';                Value: 'Tuần'),
    (Key: 'part.day';                 Value: 'Ngày'),
    (Key: 'part.year.short';          Value: 'năm'),
    (Key: 'part.quarter.short';       Value: 'quý'),
    (Key: 'part.month.short';         Value: 'tháng'),
    (Key: 'part.week.short';          Value: 'tuần'),
    (Key: 'part.day.short';           Value: 'ngày'),
    (Key: 'part.hour';                Value: 'Giờ'),
    (Key: 'part.minute';              Value: 'Phút'),
    (Key: 'part.second';              Value: 'Giây'),
    (Key: 'part.millisecond';         Value: 'Mili giây'),
    (Key: 'part.hour.short';          Value: 'giờ'),
    (Key: 'part.minute.short';        Value: 'phút'),
    (Key: 'part.second.short';        Value: 'giây'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Múi giờ không hợp lệ "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Định dạng quý không hợp lệ "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Tên tháng không hợp lệ "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Tên thứ trong tuần không hợp lệ "%s"'),
    (Key: 'error.invalid-year';           Value: 'Năm %d không hợp lệ (phạm vi hợp lệ %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Tháng %d không hợp lệ (phạm vi hợp lệ 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Ngày trong tháng %d không hợp lệ (phạm vi hợp lệ 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Quý %d không hợp lệ (phạm vi hợp lệ 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Thứ trong tuần %d không hợp lệ (phạm vi hợp lệ 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Ngày không hợp lệ: năm %d, tháng %d, ngày %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Ngày thứ %d trong năm không hợp lệ (năm %d)'),
    (Key: 'error.date-range';             Value: 'Ngày nằm ngoài phạm vi 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Thời gian không hợp lệ: %d giờ %d phút %d giây %d ms'),
    (Key: 'error.time-range';             Value: 'Thời điểm trong ngày %d ms nằm ngoài phạm vi 00:00:00.000..23:59:59.999')
  );

var
  Vietnamese: Chrono.TLocale;

function VietnameseLocale: Chrono.TLocale;
begin
  Result := Vietnamese;
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
  Vietnamese := Chrono.TLocale.Create('vi', Chrono.TLocale.English, Lookup);

finalization
  Vietnamese.Free;

end.
