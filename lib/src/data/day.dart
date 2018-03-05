import 'package:meta/meta.dart';

import 'month.dart';

@immutable
class Day {
  final Month month;
  final int day;

  final bool isExtended;

  Day(
    this.month,
    this.day,
    this.isExtended,
  );

  factory Day.fromDateTime(DateTime dateTime, bool isExtended) {
    Month month = new Month(
      dateTime.year,
      dateTime.month,
    );

    return new Day(
      month,
      dateTime.day,
      isExtended,
    );
  }

  DateTime toDateTime() => new DateTime(
        month.year,
        month.month,
        day,
      );

  @override
  bool operator ==(Object other) {
    if (other is Day) {
      return hashCode == other.hashCode;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => month.hashCode ^ day.hashCode ^ isExtended.hashCode;
}
