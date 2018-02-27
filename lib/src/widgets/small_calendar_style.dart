import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:small_calendar/src/style_data/all.dart';

class SmallCalendarStyle extends InheritedWidget {
  final DayStyleData dayStyleData;
  final WeekdayIndicationStyleData weekdayIndicationStyleData;

  SmallCalendarStyle._internal({
    @required this.dayStyleData,
    @required this.weekdayIndicationStyleData,
    @required Widget child,
  })
      : super(child: child);

  factory SmallCalendarStyle({
    DayStyleData dayStyleData,
    WeekdayIndicationStyleData weekdayIndicationStyleData,
    @required Widget child,
  }) {
    return new SmallCalendarStyle._internal(
      dayStyleData: dayStyleData ?? new DayStyleData(),
      weekdayIndicationStyleData:
          weekdayIndicationStyleData ?? new WeekdayIndicationStyleData(),
      child: child,
    );
  }

  static SmallCalendarStyle of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(SmallCalendarStyle);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    if (oldWidget is SmallCalendarStyle) {
      return oldWidget.dayStyleData != dayStyleData ||
          oldWidget.weekdayIndicationStyleData != weekdayIndicationStyleData;
    } else {
      return true;
    }
  }
}
