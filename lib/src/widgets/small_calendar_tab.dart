import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../generator.dart';
import '../data.dart';
import '../small_calendar_controller.dart';

import '../callbacks.dart';
import 'weekday_indicator.dart';
import 'small_calendar_style.dart';
import 'day.dart';

class SmallCalendarTab extends StatelessWidget {
  final bool showWeekdayIndication;
  final Map<int, String> dayNames;
  final int firstWeekday;

  final Month month;

  final SmallCalendarController controller;

  final double weekdayIndicationHeight;
  final OnDayPressed onDayPressed;

  SmallCalendarTab({
    @required this.showWeekdayIndication,
    @required this.dayNames,
    @required this.firstWeekday,
    @required this.weekdayIndicationHeight,
    @required this.month,
    @required this.controller,
    @required this.onDayPressed,
  });

  Widget generateWeekdayIndication(BuildContext context) {
    List<int> weekdays = generateWeekdays(firstWeekday);

    return new Container(
      height: weekdayIndicationHeight,
      color: SmallCalendarStyle
          .of(context)
          .weekdayIndicationStyleData
          .backgroundColor,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: weekdays.map((weekday) {
          return new Expanded(
            child: new WeekdayIndicator(
              text: dayNames[weekday],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget generateWeek(List<DateTime> daysOfWeek) {
    return new Expanded(
      child: new Row(
        children: daysOfWeek
            .map(
              (date) => new Expanded(
                    child: new Day(
                      date: date,
                      isExtendedDay: (date.month != month.month),
                      controller: controller,
                      onDayPressed: onDayPressed,
                    ),
                  ),
            )
            .toList(),
      ),
    );
  }

  List<Widget> generateWeeks() {
    List<Widget> r = <Widget>[];

    List<DateTime> days = generateExtendedDaysOfMonth(
      month,
      firstWeekday,
    );

    while (days.isNotEmpty) {
      // generates a week
      List<DateTime> daysOfWeek = days.getRange(0, 7).toList();
      days.removeRange(0, 7);
      r.add(
        generateWeek(daysOfWeek),
      );
    }

    return r;
  }

  @override
  Widget build(BuildContext context) {
    generateWeeks();

    List<Widget> widgets = <Widget>[];

    // weekday indication
    if (showWeekdayIndication) {
      widgets.add(
        generateWeekdayIndication(context),
      );
    }

    // weeks
    widgets.addAll(
      generateWeeks(),
    );

    return new Column(
      mainAxisSize: MainAxisSize.max,
      children: widgets,
    );
  }
}
