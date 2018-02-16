import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'small_calendar_controller.dart';
import 'small_calendar_tab.dart';
import 'data.dart';

class SmallCalendar extends StatefulWidget {
  final int totalNumberOfMonths;
  final bool showDayIndication;
  final int firstWeekday;

  final Map<int, String> dayNamesMap;

  final SmallCalendarController controller;

  final double weekdayIndicationHeight;

  SmallCalendar({
    this.totalNumberOfMonths = 120,
    this.showDayIndication = true,
    this.firstWeekday = DateTime.MONDAY,
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
    List<Widget> r = <Widget>[];

    for (int i = 0; i < widget.totalNumberOfMonths; i++) {
      r.add(new SmallCalendarTab(
        showDayIndication: widget.showDayIndication,
        dayNames: widget.dayNamesMap,
        firstWeekday: widget.firstWeekday,
        weekdayIndicationHeight: widget.weekdayIndicationHeight,
      ));
    }

    return r;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.green,
      child: new DefaultTabController(
        length: widget.totalNumberOfMonths,
        initialIndex: widget.totalNumberOfMonths ~/ 2,
        child: new TabBarView(
          children: generateTabs(),
        ),
      ),
    );
  }
}
