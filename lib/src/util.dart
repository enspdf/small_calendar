import 'data.dart';

List<int> generateWeekdays(int firstWeekday) {
  List<int> r = <int>[];

  int zeroBasedFirstWeekday = firstWeekday - 1;

  for (int i = 0; i < 7; i++) {
    r.add((((zeroBasedFirstWeekday + i) % 7)) + 1);
  }

  return r;
}

List<Month> generateMonths(Month firstMonth, int numOfMonthsToGenerate) {
  List<Month> r = <Month>[];

  int year = firstMonth.year;
  int month = firstMonth.month;

  for (int i = 0; i < numOfMonthsToGenerate; i++) {
    if (i != 0) {
      //first month of result is same as parameter firstMonth
      month++;
    }
    if (month == 13) {
      month = 1;
      year++;
    }

    r.add(
      new Month(
        year,
        month,
      ),
    );
  }

  return r;
}

Month generateMonthXMonthsAgo(
  Month initialMonth,
  int numOfMonthsAgo,
) {
  int year = initialMonth.year;
  int month = initialMonth.month;

  for (int i = 1; i <= numOfMonthsAgo; i++) {
    month--;
    if (month == 0) {
      month = 12;
      year--;
    }
  }

  return new Month(year, month);
}

/// Generates a list of [DateTime]s to be displayed for specific calendar [month].
///
/// Resulting list also contains days that do not belong to [month], but do
/// belong to a week of which at least one day does belong to [month].
///
/// eg.
/// If first day of [mont] is on Wednesday and [firstWeekday] is Monday,
/// the first two days of generated list will be the last two days of the month the is before the [month].
List<DateTime> generateExtendedDaysOfMonth(Month month, int firstWeekday) {
  List<DateTime> r = <DateTime>[];
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
    r.add(currentDay);
    currentDay = currentDay.add(new Duration(days: 1));
  }

  // adds actual days of month
  while (currentDay.month == month.month) {
    r.add(currentDay);
    currentDay = currentDay.add(new Duration(days: 1));
  }

  // adds days after the end of the month
  while (currentDay.weekday != firstWeekday) {
    r.add(currentDay);
    currentDay = currentDay.add(new Duration(days: 1));
  }

  return r;
}

DateTime _lowerToFirstWeekday(DateTime day, int firstWeekday) {
  DateTime dayUtc = new DateTime.utc(day.year, day.month, day.day);

  while (dayUtc.weekday != firstWeekday) {
    dayUtc = dayUtc.add(new Duration(days: -1));
  }

  return dayUtc;
}

int getDifferenceOfMonths(Month month1, Month month2, int maxDifference) {
  int r = 0;
  while (month1 != month2) {
    month1 = month1.add(1);
    r++;

    if (r >= maxDifference) {
      return maxDifference;
    }
  }

  return r;
}
