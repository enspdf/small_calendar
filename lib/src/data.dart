import 'package:meta/meta.dart';

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
