import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'small_calendar_controller.dart';
import 'small_calendar_tab.dart';
import 'data.dart';
import 'generator.dart';

class SmallCalendar extends StatefulWidget {
  final int totalNumberOfMonths;
  final bool showDayIndication;
  final int firstWeekday;

  final initialYear;
  final initialMonth;

  final Map<int, String> dayNamesMap;

  final SmallCalendarController controller;

  final double weekdayIndicationHeight;

  SmallCalendar({
    this.totalNumberOfMonths = 120,
    this.showDayIndication = true,
    this.firstWeekday = DateTime.MONDAY,
    @required this.initialYear,
    @required this.initialMonth,
    this.dayNamesMap = oneLetterEnglishDayNames,
    this.weekdayIndicationHeight = 20.0,
    @required this.controller,
  })
      : assert(controller != null);

  @override
  State createState() => new _SmallCalendarState();
}

class _SmallCalendarState extends State<SmallCalendar> {
  List<Widget> generateTabs() {
    Month firstMonth = generateMonthXMonthsAgo(
        initialMonth, widget.totalNumberOfMonths - initialIndex);

    return generateMonths(firstMonth, widget.totalNumberOfMonths)
        .map(
          (month) => new SmallCalendarTab(
                showDayIndication: widget.showDayIndication,
                dayNames: widget.dayNamesMap,
                firstWeekday: widget.firstWeekday,
                weekdayIndicationHeight: widget.weekdayIndicationHeight,
                month: month,
              ),
        )
        .toList();
  }

  int get initialIndex => widget.totalNumberOfMonths ~/ 2;

  Month get initialMonth => new Month(
        widget.initialYear,
        widget.initialMonth,
      );

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.green,
      child: new DefaultTabController(
        length: widget.totalNumberOfMonths,
        initialIndex: initialIndex,
        child: new TabBarView(
          children: generateTabs(),
        ),
      ),
    );
  }
}
