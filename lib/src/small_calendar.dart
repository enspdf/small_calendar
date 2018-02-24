import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'style_data/all.dart';
import 'widgets/small_calendar_tab.dart';
import 'widgets/small_calendar_style.dart';

import 'small_calendar_controller.dart';
import 'data.dart';
import 'generator.dart';
import 'callbacks.dart';

class SmallCalendar extends StatefulWidget {
  final int totalNumberOfMonths;
  final bool showWeekdayIndication;

  final DateTime initialDate;
  final int firstWeekday;

  final DayStyleData dayStyle;
  final WeekdayIndicationStyleData weekdayIndicationStyle;

  final Map<int, String> dayNamesMap;

  final double weekdayIndicationHeight;

  final SmallCalendarController controller;

  final OnDayPressed onDayPressed;

  SmallCalendar._internal({
    @required this.totalNumberOfMonths,
    @required this.showWeekdayIndication,
    @required this.initialDate,
    @required this.firstWeekday,
    this.dayStyle,
    this.weekdayIndicationStyle,
    @required this.dayNamesMap,
    @required this.weekdayIndicationHeight,
    @required this.controller,
    @required this.onDayPressed,
  })
      : assert(totalNumberOfMonths != null),
        assert(showWeekdayIndication != null),
        assert(initialDate != null),
        assert(firstWeekday != null),
        assert((firstWeekday >= DateTime.MONDAY) &&
            (firstWeekday <= DateTime.SUNDAY)),
        assert(dayNamesMap != null),
        assert(weekdayIndicationHeight != null),
        assert(controller != null);

  factory SmallCalendar({
    int totalNumberOfMonths = 120,
    bool showWeekdayIndication = true,
    DateTime initialDate,
    int firstWeekday = DateTime.MONDAY,
    DayStyleData dayStyle,
    WeekdayIndicationStyleData weekdayIndicationStyle,
    Map<int, String> dayNamesMap = oneLetterEnglishDayNames,
    double weekdayIndicationHeight = 25.0,
    SmallCalendarController controller,
    OnDayPressed onDayPressed,
  }) {
    return new SmallCalendar._internal(
      totalNumberOfMonths: totalNumberOfMonths,
      showWeekdayIndication: showWeekdayIndication,
      initialDate: initialDate ?? new DateTime.now(),
      firstWeekday: firstWeekday,
      dayStyle: dayStyle,
      weekdayIndicationStyle: weekdayIndicationStyle,
      dayNamesMap: dayNamesMap,
      weekdayIndicationHeight: weekdayIndicationHeight,
      controller: controller ?? new SmallCalendarController(),
      onDayPressed: onDayPressed,
    );
  }

  @override
  State createState() => new _SmallCalendarState();
}

class _SmallCalendarState extends State<SmallCalendar> {
  List<Widget> generateTabs() {
    Month firstMonth = generateMonthXMonthsAgo(
      initialMonth,
      widget.totalNumberOfMonths - initialIndex,
    );

    return generateMonths(firstMonth, widget.totalNumberOfMonths)
        .map(
          (month) => new SmallCalendarTab(
                showWeekdayIndication: widget.showWeekdayIndication,
                dayNames: widget.dayNamesMap,
                firstWeekday: widget.firstWeekday,
                weekdayIndicationHeight: widget.weekdayIndicationHeight,
                controller: widget.controller,
                month: month,
                onDayPressed: widget.onDayPressed,
              ),
        )
        .toList();
  }

  int get initialIndex => widget.totalNumberOfMonths ~/ 2;

  Month get initialMonth => new Month(
        widget.initialDate.year,
        widget.initialDate.month,
      );

  @override
  Widget build(BuildContext context) {


    return new Container(
      child: new SmallCalendarStyle(
        dayStyleData: widget.dayStyle,
        weekdayIndicationStyleData: widget.weekdayIndicationStyle,
        child: new DefaultTabController(
          length: widget.totalNumberOfMonths,
          initialIndex: initialIndex,
          child: new TabBarView(
            children: generateTabs(),
          ),
        ),
      ),
    );
  }
}
