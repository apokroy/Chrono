{ ---------------------------------------------------------------------------
  Japanese texts for Chrono: month names, weekday names, names of date and
  time parts and error messages.

    uses ChronoTypes, ChronoTypes.Japanese;
    ...
    Chrono.Locale := JapaneseLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Japanese;

interface

uses
  ChronoTypes;

/// <summary>
///  The Japanese locale. The month and weekday names are those of the ja-JP locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function JapaneseLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: '1月'),
    (Key: 'month.february';           Value: '2月'),
    (Key: 'month.march';              Value: '3月'),
    (Key: 'month.april';              Value: '4月'),
    (Key: 'month.may';                Value: '5月'),
    (Key: 'month.june';               Value: '6月'),
    (Key: 'month.july';               Value: '7月'),
    (Key: 'month.august';             Value: '8月'),
    (Key: 'month.september';          Value: '9月'),
    (Key: 'month.october';            Value: '10月'),
    (Key: 'month.november';           Value: '11月'),
    (Key: 'month.december';           Value: '12月'),

    (Key: 'month.january.genitive';   Value: '1月'),
    (Key: 'month.february.genitive';  Value: '2月'),
    (Key: 'month.march.genitive';     Value: '3月'),
    (Key: 'month.april.genitive';     Value: '4月'),
    (Key: 'month.may.genitive';       Value: '5月'),
    (Key: 'month.june.genitive';      Value: '6月'),
    (Key: 'month.july.genitive';      Value: '7月'),
    (Key: 'month.august.genitive';    Value: '8月'),
    (Key: 'month.september.genitive'; Value: '9月'),
    (Key: 'month.october.genitive';   Value: '10月'),
    (Key: 'month.november.genitive';  Value: '11月'),
    (Key: 'month.december.genitive';  Value: '12月'),

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

    (Key: 'weekday.sunday';           Value: '日曜日'),
    (Key: 'weekday.monday';           Value: '月曜日'),
    (Key: 'weekday.tuesday';          Value: '火曜日'),
    (Key: 'weekday.wednesday';        Value: '水曜日'),
    (Key: 'weekday.thursday';         Value: '木曜日'),
    (Key: 'weekday.friday';           Value: '金曜日'),
    (Key: 'weekday.saturday';         Value: '土曜日'),

    (Key: 'weekday.sunday.short';     Value: '日'),
    (Key: 'weekday.monday.short';     Value: '月'),
    (Key: 'weekday.tuesday.short';    Value: '火'),
    (Key: 'weekday.wednesday.short';  Value: '水'),
    (Key: 'weekday.thursday.short';   Value: '木'),
    (Key: 'weekday.friday.short';     Value: '金'),
    (Key: 'weekday.saturday.short';   Value: '土'),

    (Key: 'part.year';                Value: '年'),
    (Key: 'part.quarter';             Value: '四半期'),
    (Key: 'part.month';               Value: '月'),
    (Key: 'part.week';                Value: '週'),
    (Key: 'part.day';                 Value: '日'),
    (Key: 'part.year.short';          Value: '年'),
    (Key: 'part.quarter.short';       Value: '四半期'),
    (Key: 'part.month.short';         Value: 'か月'),
    (Key: 'part.week.short';          Value: '週'),
    (Key: 'part.day.short';           Value: '日'),
    (Key: 'part.hour';                Value: '時間'),
    (Key: 'part.minute';              Value: '分'),
    (Key: 'part.second';              Value: '秒'),
    (Key: 'part.millisecond';         Value: 'ミリ秒'),
    (Key: 'part.hour.short';          Value: '時間'),
    (Key: 'part.minute.short';        Value: '分'),
    (Key: 'part.second.short';        Value: '秒'),
    (Key: 'part.millisecond.short';   Value: 'ミリ秒'),

    (Key: 'error.invalid-time-zone';      Value: '無効なタイムゾーン「%s」'),
    (Key: 'error.invalid-quarter';        Value: '無効な四半期の形式「%s」'),
    (Key: 'error.invalid-month-name';     Value: '無効な月の名前「%s」'),
    (Key: 'error.invalid-weekday-name';   Value: '無効な曜日の名前「%s」'),
    (Key: 'error.invalid-year';           Value: '無効な年 %d（有効な範囲は %d..%d）'),
    (Key: 'error.invalid-month';          Value: '無効な月 %d（有効な範囲は 1..12）'),
    (Key: 'error.invalid-day';            Value: '無効な日 %d（有効な範囲は 1..31）'),
    (Key: 'error.invalid-quarter-number'; Value: '無効な四半期 %d（有効な範囲は 1..4）'),
    (Key: 'error.invalid-weekday';        Value: '無効な曜日 %d（有効な範囲は 1..7）'),
    (Key: 'error.invalid-date';           Value: '無効な日付: %d 年 %d 月 %d 日'),
    (Key: 'error.invalid-day-of-year';    Value: '無効な年間通算日 %d（%d 年）'),
    (Key: 'error.date-range';             Value: '日付が範囲 0001-01-01..9999-12-31 の外です'),
    (Key: 'error.invalid-time';           Value: '無効な時刻: %d 時 %d 分 %d 秒 %d ミリ秒'),
    (Key: 'error.time-range';             Value: '時刻 %d ミリ秒が範囲 00:00:00.000..23:59:59.999 の外です')
  );

var
  Japanese: Chrono.TLocale;

function JapaneseLocale: Chrono.TLocale;
begin
  Result := Japanese;
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
  Japanese := Chrono.TLocale.Create('ja', Chrono.TLocale.English, Lookup);

finalization
  Japanese.Free;

end.
