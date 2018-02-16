import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'widgets/weekday_indicator.dart';

import 'generator.dart';

class SmallCalendarTab extends StatelessWidget {
  final bool showDayIndication;
  final Map<int, String> dayNames;
  final int firstWeekday;

  final double weekdayIndicationHeight;

  SmallCalendarTab({
    @required this.showDayIndication,
    @required this.dayNames,
    @required this.firstWeekday,
    @required this.weekdayIndicationHeight,
  });

  double calculateWidthOfDay(BuildContext context) {
    return context.size.width / 7;
  }

  Widget generateWeekdayIndicationWidget(BuildContext context) {
    List<int> weekdays = generateWeekdays(firstWeekday);

    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: weekdays.map((weekday) {
        return new Expanded(
          child: new WeekdayIndicator(
            text: dayNames[weekday],
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[];
    if (showDayIndication) {
      widgets.add(
        new Positioned(
          left: 0.0,
          right: 0.0,
          top: 0.0,
          height: weekdayIndicationHeight,
          child: generateWeekdayIndicationWidget(context),
        ),
      );
    }

    return new Stack(
      children: widgets,
    );
  }
}
