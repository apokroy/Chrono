{ ---------------------------------------------------------------------------
  Korean texts for Chrono: month names, weekday names, names of date and time
  parts and error messages.

    uses ChronoTypes, ChronoTypes.Korean;
    ...
    Chrono.Locale := KoreanLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Korean;

interface

uses
  ChronoTypes;

/// <summary>
///  The Korean locale. The month and weekday names are those of the ko-KR locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function KoreanLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: '1월'),
    (Key: 'month.february';           Value: '2월'),
    (Key: 'month.march';              Value: '3월'),
    (Key: 'month.april';              Value: '4월'),
    (Key: 'month.may';                Value: '5월'),
    (Key: 'month.june';               Value: '6월'),
    (Key: 'month.july';               Value: '7월'),
    (Key: 'month.august';             Value: '8월'),
    (Key: 'month.september';          Value: '9월'),
    (Key: 'month.october';            Value: '10월'),
    (Key: 'month.november';           Value: '11월'),
    (Key: 'month.december';           Value: '12월'),

    (Key: 'month.january.genitive';   Value: '1월'),
    (Key: 'month.february.genitive';  Value: '2월'),
    (Key: 'month.march.genitive';     Value: '3월'),
    (Key: 'month.april.genitive';     Value: '4월'),
    (Key: 'month.may.genitive';       Value: '5월'),
    (Key: 'month.june.genitive';      Value: '6월'),
    (Key: 'month.july.genitive';      Value: '7월'),
    (Key: 'month.august.genitive';    Value: '8월'),
    (Key: 'month.september.genitive'; Value: '9월'),
    (Key: 'month.october.genitive';   Value: '10월'),
    (Key: 'month.november.genitive';  Value: '11월'),
    (Key: 'month.december.genitive';  Value: '12월'),

    (Key: 'month.january.short';      Value: '1'),
    (Key: 'month.february.short';     Value: '2'),
    (Key: 'month.march.short';        Value: '3'),
    (Key: 'month.april.short';        Value: '4'),
    (Key: 'month.may.short';          Value: '5'),
    (Key: 'month.june.short';         Value: '6'),
    (Key: 'month.july.short';         Value: '7'),
    (Key: 'month.august.short';       Value: '8'),
    (Key: 'month.september.short';    Value: '9'),
    (Key: 'month.october.short';      Value: '10'),
    (Key: 'month.november.short';     Value: '11'),
    (Key: 'month.december.short';     Value: '12'),

    (Key: 'weekday.sunday';           Value: '일요일'),
    (Key: 'weekday.monday';           Value: '월요일'),
    (Key: 'weekday.tuesday';          Value: '화요일'),
    (Key: 'weekday.wednesday';        Value: '수요일'),
    (Key: 'weekday.thursday';         Value: '목요일'),
    (Key: 'weekday.friday';           Value: '금요일'),
    (Key: 'weekday.saturday';         Value: '토요일'),

    (Key: 'weekday.sunday.short';     Value: '일'),
    (Key: 'weekday.monday.short';     Value: '월'),
    (Key: 'weekday.tuesday.short';    Value: '화'),
    (Key: 'weekday.wednesday.short';  Value: '수'),
    (Key: 'weekday.thursday.short';   Value: '목'),
    (Key: 'weekday.friday.short';     Value: '금'),
    (Key: 'weekday.saturday.short';   Value: '토'),

    (Key: 'part.year';                Value: '연도'),
    (Key: 'part.quarter';             Value: '분기'),
    (Key: 'part.month';               Value: '월'),
    (Key: 'part.week';                Value: '주'),
    (Key: 'part.day';                 Value: '일'),
    (Key: 'part.year.short';          Value: '년'),
    (Key: 'part.quarter.short';       Value: '분기'),
    (Key: 'part.month.short';         Value: '개월'),
    (Key: 'part.week.short';          Value: '주'),
    (Key: 'part.day.short';           Value: '일'),
    (Key: 'part.hour';                Value: '시간'),
    (Key: 'part.minute';              Value: '분'),
    (Key: 'part.second';              Value: '초'),
    (Key: 'part.millisecond';         Value: '밀리초'),
    (Key: 'part.hour.short';          Value: '시간'),
    (Key: 'part.minute.short';        Value: '분'),
    (Key: 'part.second.short';        Value: '초'),
    (Key: 'part.millisecond.short';   Value: '밀리초'),

    (Key: 'error.invalid-time-zone';      Value: '잘못된 시간대 "%s"'),
    (Key: 'error.invalid-quarter';        Value: '잘못된 분기 형식 "%s"'),
    (Key: 'error.invalid-month-name';     Value: '잘못된 월 이름 "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: '잘못된 요일 이름 "%s"'),
    (Key: 'error.invalid-year';           Value: '잘못된 연도 %d (유효 범위: %d..%d)'),
    (Key: 'error.invalid-month';          Value: '잘못된 월 %d (유효 범위: 1..12)'),
    (Key: 'error.invalid-day';            Value: '잘못된 일 %d (유효 범위: 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: '잘못된 분기 %d (유효 범위: 1..4)'),
    (Key: 'error.invalid-weekday';        Value: '잘못된 요일 %d (유효 범위: 1..7)'),
    (Key: 'error.invalid-date';           Value: '잘못된 날짜: %d년 %d월 %d일'),
    (Key: 'error.invalid-day-of-year';    Value: '잘못된 연중 일자 %d (%d년)'),
    (Key: 'error.date-range';             Value: '날짜가 0001-01-01..9999-12-31 범위를 벗어났습니다'),
    (Key: 'error.invalid-time';           Value: '잘못된 시간: %d시 %d분 %d초 %d밀리초'),
    (Key: 'error.time-range';             Value: '시각 %d밀리초가 00:00:00.000..23:59:59.999 범위를 벗어났습니다')
  );

var
  Korean: Chrono.TLocale;

function KoreanLocale: Chrono.TLocale;
begin
  Result := Korean;
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
  Korean := Chrono.TLocale.Create('ko', Chrono.TLocale.English, Lookup);

finalization
  Korean.Free;

end.
