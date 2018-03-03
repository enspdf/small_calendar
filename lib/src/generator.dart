import 'data/all.dart';

/// Generates a list of [Day]s to be displayed for specific calendar [Month].
///
/// Resulting list also contains days that do not belong to [month], but do
/// belong to a week of which at least one day does belong to [month].
///
/// eg.
/// If first day of [mont] is on Wednesday and [firstWeekday] is Monday,
/// the first two days of generated list will be the last two days of the month the is before the [month].
List<Day> generateExtendedDaysOfMonth(Month month, int firstWeekday) {
  List<Day> r = <Day>[];
  DateTime currentDay;

  // adds days before the start of the month
  currentDay = _lowerToFirstWeekday(
    new DateTime.utc(
      month.year,
      month.month,
    ),
    firstWeekday,
  );
  while (currentDay.month != month.month) {
    r.add(
      new Day.fromDateTime(currentDay, true),
    );
    currentDay = currentDay.add(new Duration(days: 1));
  }

  // adds actual days of month
  while (currentDay.month == month.month) {
    r.add(
      new Day.fromDateTime(currentDay, false),
    );
    currentDay = currentDay.add(new Duration(days: 1));
  }

  // adds days after the end of the month
  while (currentDay.weekday != firstWeekday) {
    r.add(
      new Day.fromDateTime(currentDay, true),
    );
    currentDay = currentDay.add(new Duration(days: 1));
  }

  return r;
}

DateTime _lowerToFirstWeekday(DateTime day, int firstWeekday) {
  while (day.weekday != firstWeekday) {
    day = day.add(new Duration(days: -1));
  }

  return day;
}
