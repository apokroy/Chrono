{ ---------------------------------------------------------------------------
  Chinese (simplified) texts for Chrono: month names, weekday names, names of
  date and time parts and error messages.

    uses ChronoTypes, ChronoTypes.Chinese;
    ...
    Chrono.Locale := ChineseLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Chinese;

interface

uses
  ChronoTypes;

/// <summary>
///  The Chinese (simplified) locale. The month and weekday names are those of the zh-CN
///  locale of Windows, so dates read the same on every platform. The locale is created
///  when the unit is initialized and freed when it is finalized; Chrono.Locale then
///  returns to TLocale.System.
/// </summary>
function ChineseLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: '一月'),
    (Key: 'month.february';           Value: '二月'),
    (Key: 'month.march';              Value: '三月'),
    (Key: 'month.april';              Value: '四月'),
    (Key: 'month.may';                Value: '五月'),
    (Key: 'month.june';               Value: '六月'),
    (Key: 'month.july';               Value: '七月'),
    (Key: 'month.august';             Value: '八月'),
    (Key: 'month.september';          Value: '九月'),
    (Key: 'month.october';            Value: '十月'),
    (Key: 'month.november';           Value: '十一月'),
    (Key: 'month.december';           Value: '十二月'),

    (Key: 'month.january.genitive';   Value: '一月'),
    (Key: 'month.february.genitive';  Value: '二月'),
    (Key: 'month.march.genitive';     Value: '三月'),
    (Key: 'month.april.genitive';     Value: '四月'),
    (Key: 'month.may.genitive';       Value: '五月'),
    (Key: 'month.june.genitive';      Value: '六月'),
    (Key: 'month.july.genitive';      Value: '七月'),
    (Key: 'month.august.genitive';    Value: '八月'),
    (Key: 'month.september.genitive'; Value: '九月'),
    (Key: 'month.october.genitive';   Value: '十月'),
    (Key: 'month.november.genitive';  Value: '十一月'),
    (Key: 'month.december.genitive';  Value: '十二月'),

    (Key: 'month.january.short';      Value: '1月'),
    (Key: 'month.february.short';     Value: '2月'),
    (Key: 'month.march.short';        Value: '3月'),
    (Key: 'month.april.short';        Value: '4月'),
    (Key: 'month.may.short';          Value: '5月'),
    (Key: 'month.june.short';         Value: '6月'),
    (Key: 'month.july.short';         Value: '7月'),
    (Key: 'month.august.short';       Value: '8月'),
    (Key: 'month.september.short';    Value: '9月'),
    (Key: 'month.october.short';      Value: '10月'),
    (Key: 'month.november.short';     Value: '11月'),
    (Key: 'month.december.short';     Value: '12月'),

    (Key: 'weekday.sunday';           Value: '星期日'),
    (Key: 'weekday.monday';           Value: '星期一'),
    (Key: 'weekday.tuesday';          Value: '星期二'),
    (Key: 'weekday.wednesday';        Value: '星期三'),
    (Key: 'weekday.thursday';         Value: '星期四'),
    (Key: 'weekday.friday';           Value: '星期五'),
    (Key: 'weekday.saturday';         Value: '星期六'),

    (Key: 'weekday.sunday.short';     Value: '周日'),
    (Key: 'weekday.monday.short';     Value: '周一'),
    (Key: 'weekday.tuesday.short';    Value: '周二'),
    (Key: 'weekday.wednesday.short';  Value: '周三'),
    (Key: 'weekday.thursday.short';   Value: '周四'),
    (Key: 'weekday.friday.short';     Value: '周五'),
    (Key: 'weekday.saturday.short';   Value: '周六'),

    (Key: 'part.year';                Value: '年'),
    (Key: 'part.quarter';             Value: '季度'),
    (Key: 'part.month';               Value: '月'),
    (Key: 'part.week';                Value: '周'),
    (Key: 'part.day';                 Value: '日'),
    (Key: 'part.year.short';          Value: '年'),
    (Key: 'part.quarter.short';       Value: '季'),
    (Key: 'part.month.short';         Value: '个月'),
    (Key: 'part.week.short';          Value: '周'),
    (Key: 'part.day.short';           Value: '天'),
    (Key: 'part.hour';                Value: '小时'),
    (Key: 'part.minute';              Value: '分钟'),
    (Key: 'part.second';              Value: '秒'),
    (Key: 'part.millisecond';         Value: '毫秒'),
    (Key: 'part.hour.short';          Value: '小时'),
    (Key: 'part.minute.short';        Value: '分'),
    (Key: 'part.second.short';        Value: '秒'),
    (Key: 'part.millisecond.short';   Value: '毫秒'),

    (Key: 'error.invalid-time-zone';      Value: '无效的时区“%s”'),
    (Key: 'error.invalid-quarter';        Value: '无效的季度格式“%s”'),
    (Key: 'error.invalid-month-name';     Value: '无效的月份名称“%s”'),
    (Key: 'error.invalid-weekday-name';   Value: '无效的星期名称“%s”'),
    (Key: 'error.invalid-year';           Value: '无效的年份 %d（有效范围为 %d..%d）'),
    (Key: 'error.invalid-month';          Value: '无效的月份 %d（有效范围为 1..12）'),
    (Key: 'error.invalid-day';            Value: '无效的月内日期 %d（有效范围为 1..31）'),
    (Key: 'error.invalid-quarter-number'; Value: '无效的季度 %d（有效范围为 1..4）'),
    (Key: 'error.invalid-weekday';        Value: '无效的星期几 %d（有效范围为 1..7）'),
    (Key: 'error.invalid-date';           Value: '无效的日期：%d 年 %d 月 %d 日'),
    (Key: 'error.invalid-day-of-year';    Value: '无效的年内天数 %d（%d 年）'),
    (Key: 'error.date-range';             Value: '日期超出范围 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: '无效的时间：%d 时 %d 分 %d 秒 %d 毫秒'),
    (Key: 'error.time-range';             Value: '一天中的时间 %d 毫秒超出范围 00:00:00.000..23:59:59.999')
  );

var
  Chinese: Chrono.TLocale;

function ChineseLocale: Chrono.TLocale;
begin
  Result := Chinese;
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
  Chinese := Chrono.TLocale.Create('zh', Chrono.TLocale.English, Lookup);

finalization
  Chinese.Free;

end.
