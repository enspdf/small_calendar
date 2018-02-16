import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'widgets/weekday_indicator.dart';

import 'generator.dart';
import 'data.dart';

class SmallCalendarTab extends StatelessWidget {
  final bool showDayIndication;
  final Map<int, String> dayNames;
  final int firstWeekday;

  final Month month;

  final double weekdayIndicationHeight;

  SmallCalendarTab({
    @required this.showDayIndication,
    @required this.dayNames,
    @required this.firstWeekday,
    @required this.weekdayIndicationHeight,
    @required this.month,
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

    widgets.add(
      new Positioned(
        top: 50.0,
        left: 50.0,
        child: new Text("${month.year}.${month.month}"),
      ),
    );

    return new Stack(
      children: widgets,
    );
  }
}
