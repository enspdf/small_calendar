import 'package:meta/meta.dart';

@immutable
class Month {
  final int year;
  final int month;

  Month(
    this.year,
    this.month,
  )
      : assert(year != null),
        assert(month != null),
        assert(month >= 1 && month <= 12);

  factory Month.fromDateTime(DateTime dateTime) {
    assert(dateTime != null);

    return new Month(
      dateTime.year,
      dateTime.month,
    );
  }

  factory Month.now() {
    return new Month.fromDateTime(new DateTime.now());
  }

  /// Returns a new [Month] with [numOfMonths] added to [this].
  Month add(int numOfMonths) {
    assert(numOfMonths != null);

    int yearChange = numOfMonths ~/ 12;
    int monthChange = (numOfMonths.abs() % 12) * numOfMonths.sign;

    int newYear = year + yearChange;
    int newMonthBase0 = _monthBase0 + monthChange;
    if (newMonthBase0 > 11) newYear++;
    if (newMonthBase0 < 0) newYear--;
    newMonthBase0 = newMonthBase0 % 12;

    return new Month(
      newYear,
      newMonthBase0 + 1,
    );
  }

  int get _monthBase0 => month - 1;

  @override
  bool operator ==(Object other) {
    if (other is Month) {
      return year == other.year && month == other.month;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => year.hashCode ^ month.hashCode;

  @override
  String toString() {
    return "$year.$month";
  }

  bool isBefore(Month other) {
    if (year < other.year) {
      return true;
    }

    if (year > other.year) {
      return false;
    }

    return month < other.month;
  }

  static int getDifference(Month month1, Month month2) {
    if (month1 == month2) {
      return 0;
    }

    if (month1.isBefore(month2)) {
      int r = 1;
      while (month1.add(r) != month2) {
        r++;
      }
      return r;
    } else {
      int r = -1;
      while (month1.add(r) != month2) {
        r--;
      }
      return r;
    }
  }
}
