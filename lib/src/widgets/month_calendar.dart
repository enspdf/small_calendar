import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../data/all.dart';
import '../small_calendar_controller.dart';
import '../callbacks.dart';
import '../generator.dart';
import 'small_calendar_style.dart';
import 'weekday_indicator.dart';
import 'day_widget.dart';

class MonthCalendar extends StatefulWidget {
  final MonthData monthData;

  final SmallCalendarController controller;

  final bool showWeekdayIndication;
  final List<int> weekdayIndicationDays;
  final Map<int, String> dayNames;
  final double weekdayIndicationHeight;

  final DayCallback onDayPressed;

  MonthCalendar({
    @required this.monthData,
    @required this.controller,
    @required this.showWeekdayIndication,
    @required this.weekdayIndicationDays,
    @required this.dayNames,
    @required this.weekdayIndicationHeight,
    @required this.onDayPressed,
  })
      : super(key: new ObjectKey(monthData));

  @override
  State createState() => new _MonthCalendarState();
}

class _MonthCalendarState extends State<MonthCalendar> {
  bool isActive;
  List<DayData> days = <DayData>[];

  @override
  void initState() {
    super.initState();

    isActive = true;

    widget.controller.addDayRefreshListener(onRefreshDays);

    days = generateExtendedDaysOfMonth(
      widget.monthData.month,
      widget.monthData.firstWeekday,
    )
        .map((day) => new DayData(day: day))
        .toList();

    updateDays();
  }

  @override
  void dispose() {
    isActive = false;
    widget.controller.removeDayRefreshListener(onRefreshDays);

    super.dispose();
  }

  @override
  void didUpdateWidget(MonthCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeDayRefreshListener(onRefreshDays);
      widget.controller.addDayRefreshListener(onRefreshDays);
    }
  }

  Future updateDays() async {
    for (int i = 0; i < days.length; i++) {
      updateIsHasOfDay(days[i]).then((updatedDay) {
        if (!isActive) return;
        setState(() {
          days[i] = updatedDay;
        });
      });
    }
  }

  Future<DayData> updateIsHasOfDay(DayData dayData) async {
    DateTime dateTime = dayData.day.toDateTime();

    return dayData.copyWithIsHasChanged(
      isToday: await widget.controller.isToday(dateTime),
      isSelected: await widget.controller.isSelected(dateTime),
      hasTick1: await widget.controller.hasTick1(dateTime),
      hasTick2: await widget.controller.hasTick2(dateTime),
      hasTick3: await widget.controller.hasTick3(dateTime),
    );
  }

  void onRefreshDays() {
    updateDays();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[];

    // weekday indication
    if (widget.showWeekdayIndication) {
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

  Widget generateWeekdayIndication(BuildContext context) {
    return new Container(
      height: widget.weekdayIndicationHeight,
      color: SmallCalendarStyle
          .of(context)
          .weekdayIndicationStyleData
          .backgroundColor,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: widget.weekdayIndicationDays
            .map(
              (day) => new Expanded(
                    child:
                        new WeekdayIndicator(text: "${widget.dayNames[day]}"),
                  ),
            )
            .toList(),
      ),
    );
  }

  List<Widget> generateWeeks() {
    List<Widget> r = <Widget>[];

    // TODO here
  }

  Widget generateWeek(List<DayData> daysOfWeek) {
    return new Expanded(
      child: new Row(
        children: daysOfWeek
            .map(
              (day) => new Expanded(
                    child: new DayWidget(
                      dayData: day,
                      onPressed: widget.onDayPressed,
                    ),
                  ),
            )
            .toList(),
      ),
    );
  }
}
