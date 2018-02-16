import 'package:meta/meta.dart';

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
    if (i != 0) { //first month of result is same as parameter firstMonth
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
