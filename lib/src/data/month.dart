import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

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
  int get hashCode {
    return hashObjects([
      year,
      month,
    ]);
  }

  @override
  bool operator ==(other) {
    if (other is Month) {
      return other.year == year && other.month == month;
    } else {
      return false;
    }
  }

  @override
  String toString() {
    return "$year.$month";
  }
}
