import 'package:meta/meta.dart';

@immutable
class Day {
  final int year;
  final int month;
  final int day;

  final bool isExtended;

  Day(
    this.year,
    this.month,
    this.day,
    this.isExtended,
  );

  factory Day.fromDateTime(DateTime dateTime, bool isExtended) {
    return new Day(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      isExtended,
    );
  }

  DateTime toDateTime() => new DateTime(year, month, day);
}
