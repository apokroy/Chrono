{ ---------------------------------------------------------------------------
  Armenian texts for Chrono: month names (nominative and genitive), weekday
  names, names of date and time parts and error messages.

    uses ChronoTypes, ChronoTypes.Armenian;
    ...
    Chrono.Locale := ArmenianLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Armenian;

interface

uses
  ChronoTypes;

/// <summary>
///  The Armenian locale. The month and weekday names are those of the hy-AM locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function ArmenianLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'Հունվար'),
    (Key: 'month.february';           Value: 'Փետրվար'),
    (Key: 'month.march';              Value: 'Մարտ'),
    (Key: 'month.april';              Value: 'Ապրիլ'),
    (Key: 'month.may';                Value: 'Մայիս'),
    (Key: 'month.june';               Value: 'Հունիս'),
    (Key: 'month.july';               Value: 'Հուլիս'),
    (Key: 'month.august';             Value: 'Օգոստոս'),
    (Key: 'month.september';          Value: 'Սեպտեմբեր'),
    (Key: 'month.october';            Value: 'Հոկտեմբեր'),
    (Key: 'month.november';           Value: 'Նոյեմբեր'),
    (Key: 'month.december';           Value: 'Դեկտեմբեր'),

    (Key: 'month.january.genitive';   Value: 'հունվարի'),
    (Key: 'month.february.genitive';  Value: 'փետրվարի'),
    (Key: 'month.march.genitive';     Value: 'մարտի'),
    (Key: 'month.april.genitive';     Value: 'ապրիլի'),
    (Key: 'month.may.genitive';       Value: 'մայիսի'),
    (Key: 'month.june.genitive';      Value: 'հունիսի'),
    (Key: 'month.july.genitive';      Value: 'հուլիսի'),
    (Key: 'month.august.genitive';    Value: 'օգոստոսի'),
    (Key: 'month.september.genitive'; Value: 'սեպտեմբերի'),
    (Key: 'month.october.genitive';   Value: 'հոկտեմբերի'),
    (Key: 'month.november.genitive';  Value: 'նոյեմբերի'),
    (Key: 'month.december.genitive';  Value: 'դեկտեմբերի'),

    (Key: 'month.january.short';      Value: 'Հնվ'),
    (Key: 'month.february.short';     Value: 'Փտվ'),
    (Key: 'month.march.short';        Value: 'Մրտ'),
    (Key: 'month.april.short';        Value: 'Ապր'),
    (Key: 'month.may.short';          Value: 'Մյս'),
    (Key: 'month.june.short';         Value: 'Հնս'),
    (Key: 'month.july.short';         Value: 'Հլս'),
    (Key: 'month.august.short';       Value: 'Օգս'),
    (Key: 'month.september.short';    Value: 'Սպտ'),
    (Key: 'month.october.short';      Value: 'Հկտ'),
    (Key: 'month.november.short';     Value: 'Նյմ'),
    (Key: 'month.december.short';     Value: 'Դկտ'),

    (Key: 'weekday.sunday';           Value: 'Կիրակի'),
    (Key: 'weekday.monday';           Value: 'Երկուշաբթի'),
    (Key: 'weekday.tuesday';          Value: 'Երեքշաբթի'),
    (Key: 'weekday.wednesday';        Value: 'Չորեքշաբթի'),
    (Key: 'weekday.thursday';         Value: 'Հինգշաբթի'),
    (Key: 'weekday.friday';           Value: 'Ուրբաթ'),
    (Key: 'weekday.saturday';         Value: 'Շաբաթ'),

    (Key: 'weekday.sunday.short';     Value: 'Կիր'),
    (Key: 'weekday.monday.short';     Value: 'Երկ'),
    (Key: 'weekday.tuesday.short';    Value: 'Երք'),
    (Key: 'weekday.wednesday.short';  Value: 'Չրք'),
    (Key: 'weekday.thursday.short';   Value: 'Հնգ'),
    (Key: 'weekday.friday.short';     Value: 'Ուր'),
    (Key: 'weekday.saturday.short';   Value: 'Շբթ'),

    (Key: 'part.year';                Value: 'Տարի'),
    (Key: 'part.quarter';             Value: 'Եռամսյակ'),
    (Key: 'part.month';               Value: 'Ամիս'),
    (Key: 'part.week';                Value: 'Շաբաթ'),
    (Key: 'part.day';                 Value: 'Օր'),
    (Key: 'part.year.short';          Value: 'տ'),
    (Key: 'part.quarter.short';       Value: 'եռմ'),
    (Key: 'part.month.short';         Value: 'ամս'),
    (Key: 'part.week.short';          Value: 'շաբ'),
    (Key: 'part.day.short';           Value: 'օր'),
    (Key: 'part.hour';                Value: 'Ժամ'),
    (Key: 'part.minute';              Value: 'Րոպե'),
    (Key: 'part.second';              Value: 'Վայրկյան'),
    (Key: 'part.millisecond';         Value: 'Միլիվայրկյան'),
    (Key: 'part.hour.short';          Value: 'ժ'),
    (Key: 'part.minute.short';        Value: 'ր'),
    (Key: 'part.second.short';        Value: 'վ'),
    (Key: 'part.millisecond.short';   Value: 'մվ'),

    (Key: 'error.invalid-time-zone';      Value: 'Սխալ ժամային գոտի "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Եռամսյակի սխալ գրառում "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Ամսվա սխալ անվանում "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Շաբաթվա օրվա սխալ անվանում "%s"'),
    (Key: 'error.invalid-year';           Value: 'Սխալ տարի %d (թույլատրելի է %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Սխալ ամիս %d (թույլատրելի է 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Ամսվա սխալ օր %d (թույլատրելի է 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Սխալ եռամսյակ %d (թույլատրելի է 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Շաբաթվա սխալ օր %d (թույլատրելի է 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Սխալ ամսաթիվ՝ տարի %d, ամիս %d, օր %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Տարվա սխալ օր %d (%d թ.)'),
    (Key: 'error.date-range';             Value: 'Ամսաթիվը 0001-01-01..9999-12-31 միջակայքից դուրս է'),
    (Key: 'error.invalid-time';           Value: 'Սխալ ժամանակ՝ %d ժ %d ր %d վ %d մվ'),
    (Key: 'error.time-range';             Value: 'Օրվա ժամը %d մվ 00:00:00.000..23:59:59.999 միջակայքից դուրս է')
  );

var
  Armenian: Chrono.TLocale;

function ArmenianLocale: Chrono.TLocale;
begin
  Result := Armenian;
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
  Armenian := Chrono.TLocale.Create('hy', Chrono.TLocale.English, Lookup);

finalization
  Armenian.Free;

end.
