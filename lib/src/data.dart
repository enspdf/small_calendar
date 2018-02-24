import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

@immutable
class Month {
  final int year;
  final int month;

  Month(this.year, this.month);

  factory Month.fromDateTime(DateTime dateTime) {
    return new Month(
      dateTime.year,
      dateTime.month,
    );
  }

  factory Month.now() {
    return new Month.fromDateTime(new DateTime.now());
  }

  Month add(int numOfMonths) {
    int newYear = year;
    int newMonth = month;

    for (int i = 0; i < numOfMonths; i++) {
      newMonth++;
      if (newMonth == 13) {
        newYear++;
        newMonth = 1;
      }
    }

    return new Month(newYear, newMonth);
  }

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

const Map<int, String> oneLetterEnglishDayNames = const <int, String>{
  DateTime.MONDAY: "M",
  DateTime.TUESDAY: "T",
  DateTime.WEDNESDAY: "W",
  DateTime.THURSDAY: "T",
  DateTime.FRIDAY: "F",
  DateTime.SATURDAY: "S",
  DateTime.SUNDAY: "S",
};
