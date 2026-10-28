{ ---------------------------------------------------------------------------
  Greek texts for Chrono: month names (nominative and genitive), weekday
  names, names of date and time parts and error messages.

    uses ChronoTypes, ChronoTypes.Greek;
    ...
    Chrono.Locale := GreekLocale;

  Keys missing from the table fall back to English. ChronoTypes.Russian
  explains how to make a unit for another language.

  https://github.com/apokroy/Chrono

  Copyright (c) 2026 Alexey Pokroy
  SPDX-License-Identifier: MIT (see the LICENSE file)
  --------------------------------------------------------------------------- }
unit ChronoTypes.Greek;

interface

uses
  ChronoTypes;

/// <summary>
///  The Greek locale. The month and weekday names are those of the el-GR locale of
///  Windows, so dates read the same on every platform. The locale is created when the unit
///  is initialized and freed when it is finalized; Chrono.Locale then returns to
///  TLocale.System.
/// </summary>
function GreekLocale: Chrono.TLocale;

implementation

type
  TText = record
    Key: string;
    Value: string;
  end;

const
  Texts: array[0..81] of TText = (
    (Key: 'month.january';            Value: 'Ιανουάριος'),
    (Key: 'month.february';           Value: 'Φεβρουάριος'),
    (Key: 'month.march';              Value: 'Μάρτιος'),
    (Key: 'month.april';              Value: 'Απρίλιος'),
    (Key: 'month.may';                Value: 'Μάιος'),
    (Key: 'month.june';               Value: 'Ιούνιος'),
    (Key: 'month.july';               Value: 'Ιούλιος'),
    (Key: 'month.august';             Value: 'Αύγουστος'),
    (Key: 'month.september';          Value: 'Σεπτέμβριος'),
    (Key: 'month.october';            Value: 'Οκτώβριος'),
    (Key: 'month.november';           Value: 'Νοέμβριος'),
    (Key: 'month.december';           Value: 'Δεκέμβριος'),

    (Key: 'month.january.genitive';   Value: 'Ιανουαρίου'),
    (Key: 'month.february.genitive';  Value: 'Φεβρουαρίου'),
    (Key: 'month.march.genitive';     Value: 'Μαρτίου'),
    (Key: 'month.april.genitive';     Value: 'Απριλίου'),
    (Key: 'month.may.genitive';       Value: 'Μαΐου'),
    (Key: 'month.june.genitive';      Value: 'Ιουνίου'),
    (Key: 'month.july.genitive';      Value: 'Ιουλίου'),
    (Key: 'month.august.genitive';    Value: 'Αυγούστου'),
    (Key: 'month.september.genitive'; Value: 'Σεπτεμβρίου'),
    (Key: 'month.october.genitive';   Value: 'Οκτωβρίου'),
    (Key: 'month.november.genitive';  Value: 'Νοεμβρίου'),
    (Key: 'month.december.genitive';  Value: 'Δεκεμβρίου'),

    (Key: 'month.january.short';      Value: 'Ιαν'),
    (Key: 'month.february.short';     Value: 'Φεβ'),
    (Key: 'month.march.short';        Value: 'Μαρ'),
    (Key: 'month.april.short';        Value: 'Απρ'),
    (Key: 'month.may.short';          Value: 'Μαϊ'),
    (Key: 'month.june.short';         Value: 'Ιουν'),
    (Key: 'month.july.short';         Value: 'Ιουλ'),
    (Key: 'month.august.short';       Value: 'Αυγ'),
    (Key: 'month.september.short';    Value: 'Σεπ'),
    (Key: 'month.october.short';      Value: 'Οκτ'),
    (Key: 'month.november.short';     Value: 'Νοε'),
    (Key: 'month.december.short';     Value: 'Δεκ'),

    (Key: 'weekday.sunday';           Value: 'Κυριακή'),
    (Key: 'weekday.monday';           Value: 'Δευτέρα'),
    (Key: 'weekday.tuesday';          Value: 'Τρίτη'),
    (Key: 'weekday.wednesday';        Value: 'Τετάρτη'),
    (Key: 'weekday.thursday';         Value: 'Πέμπτη'),
    (Key: 'weekday.friday';           Value: 'Παρασκευή'),
    (Key: 'weekday.saturday';         Value: 'Σάββατο'),

    (Key: 'weekday.sunday.short';     Value: 'Κυρ'),
    (Key: 'weekday.monday.short';     Value: 'Δευ'),
    (Key: 'weekday.tuesday.short';    Value: 'Τρι'),
    (Key: 'weekday.wednesday.short';  Value: 'Τετ'),
    (Key: 'weekday.thursday.short';   Value: 'Πεμ'),
    (Key: 'weekday.friday.short';     Value: 'Παρ'),
    (Key: 'weekday.saturday.short';   Value: 'Σαβ'),

    (Key: 'part.year';                Value: 'Έτος'),
    (Key: 'part.quarter';             Value: 'Τρίμηνο'),
    (Key: 'part.month';               Value: 'Μήνας'),
    (Key: 'part.week';                Value: 'Εβδομάδα'),
    (Key: 'part.day';                 Value: 'Ημέρα'),
    (Key: 'part.year.short';          Value: 'έτ'),
    (Key: 'part.quarter.short';       Value: 'τρίμ'),
    (Key: 'part.month.short';         Value: 'μήν'),
    (Key: 'part.week.short';          Value: 'εβδ'),
    (Key: 'part.day.short';           Value: 'ημ'),
    (Key: 'part.hour';                Value: 'Ώρα'),
    (Key: 'part.minute';              Value: 'Λεπτό'),
    (Key: 'part.second';              Value: 'Δευτερόλεπτο'),
    (Key: 'part.millisecond';         Value: 'Χιλιοστό δευτερολέπτου'),
    (Key: 'part.hour.short';          Value: 'ώρ'),
    (Key: 'part.minute.short';        Value: 'λεπ'),
    (Key: 'part.second.short';        Value: 'δευτ'),
    (Key: 'part.millisecond.short';   Value: 'ms'),

    (Key: 'error.invalid-time-zone';      Value: 'Μη έγκυρη ζώνη ώρας "%s"'),
    (Key: 'error.invalid-quarter';        Value: 'Μη έγκυρη μορφή τριμήνου "%s"'),
    (Key: 'error.invalid-month-name';     Value: 'Μη έγκυρο όνομα μήνα "%s"'),
    (Key: 'error.invalid-weekday-name';   Value: 'Μη έγκυρο όνομα ημέρας της εβδομάδας "%s"'),
    (Key: 'error.invalid-year';           Value: 'Μη έγκυρο έτος %d (επιτρεπτό εύρος %d..%d)'),
    (Key: 'error.invalid-month';          Value: 'Μη έγκυρος μήνας %d (επιτρεπτό εύρος 1..12)'),
    (Key: 'error.invalid-day';            Value: 'Μη έγκυρη ημέρα του μήνα %d (επιτρεπτό εύρος 1..31)'),
    (Key: 'error.invalid-quarter-number'; Value: 'Μη έγκυρο τρίμηνο %d (επιτρεπτό εύρος 1..4)'),
    (Key: 'error.invalid-weekday';        Value: 'Μη έγκυρη ημέρα της εβδομάδας %d (επιτρεπτό εύρος 1..7)'),
    (Key: 'error.invalid-date';           Value: 'Μη έγκυρη ημερομηνία: έτος %d, μήνας %d, ημέρα %d'),
    (Key: 'error.invalid-day-of-year';    Value: 'Μη έγκυρη ημέρα του έτους %d στο έτος %d'),
    (Key: 'error.date-range';             Value: 'Η ημερομηνία είναι εκτός του εύρους 0001-01-01..9999-12-31'),
    (Key: 'error.invalid-time';           Value: 'Μη έγκυρη ώρα: %d ώρ %d λεπ %d δευτ %d ms'),
    (Key: 'error.time-range';             Value: 'Η ώρα της ημέρας %d ms είναι εκτός του εύρους 00:00:00.000..23:59:59.999')
  );

var
  Greek: Chrono.TLocale;

function GreekLocale: Chrono.TLocale;
begin
  Result := Greek;
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
  Greek := Chrono.TLocale.Create('el', Chrono.TLocale.English, Lookup);

finalization
  Greek.Free;

end.
