import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

import 'month.dart';

@immutable
class MonthData {
  final Month month;
  final int firstWeekday;

  MonthData(
    this.month,
    this.firstWeekday,
  );

  @override
  bool operator ==(Object other) {
    if (other is MonthData) {
      return (other.month == month && other.firstWeekday == firstWeekday);
    } else {
      return false;
    }
  }

  @override
  int get hashCode => month.hashCode ^ firstWeekday.hashCode;
}
