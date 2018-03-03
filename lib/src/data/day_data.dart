import 'package:meta/meta.dart';

import 'day.dart';

@immutable
class DayData {
  final Day day;

  final bool isToday;
  final bool isSelected;
  final bool hasTick1;
  final bool hasTick2;
  final bool hasTick3;

  DayData({
    @required this.day,
    this.isToday = false,
    this.isSelected = false,
    this.hasTick1 = false,
    this.hasTick2 = false,
    this.hasTick3 = false,
  })
      : assert(day != null),
        assert(isToday != null),
        assert(isSelected != null),
        assert(hasTick1 != null),
        assert(hasTick2 != null),
        assert(hasTick3 != null);

  DayData copyWithIsHasChanged({
    bool isToday,
    bool isSelected,
    bool hasTick1,
    bool hasTick2,
    bool hasTick3,
  }) {
    return new DayData(
      day: day,
      isToday: isToday ?? this.isToday,
      isSelected: isSelected ?? this.isSelected,
      hasTick1: hasTick1 ?? this.hasTick1,
      hasTick2: hasTick2 ?? this.hasTick2,
      hasTick3: hasTick3 ?? this.hasTick3,
    );
  }
}
