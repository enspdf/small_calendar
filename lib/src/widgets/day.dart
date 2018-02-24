import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../small_calendar_controller.dart';
import '../callbacks.dart';

import 'small_calendar_style.dart';

class Day extends StatefulWidget {
  final DateTime date;
  final bool isExtendedDay;
  final SmallCalendarController controller;
  final OnDayPressed onDayPressed;

  Day({
    @required this.date,
    @required this.isExtendedDay,
    @required this.controller,
    @required this.onDayPressed,
  });

  @override
  State createState() => new _DayState();
}

class _DayState extends State<Day> {
  bool isToday;
  bool isSelected;
  bool hasTick1;
  bool hasTick2;
  bool hasTick3;

  @override
  void initState() {
    super.initState();

    initDefaultValues();

    initAsync();
  }

  void initDefaultValues() {
    isToday = false;
    isSelected = false;
    hasTick1 = false;
    hasTick2 = false;
    hasTick3 = false;
  }

  Future initAsync() async {
    // isToday
    widget.controller.isToday(widget.date).then((value) {
      setState(() {
        isToday = value;
      });
    });

    // isSelected
    widget.controller.isSelected(widget.date).then((value) {
      setState(() {
        isSelected = value;
      });
    });

    // hasTick1
    widget.controller.hasTick1(widget.date).then((value) {
      setState(() {
        hasTick1 = value;
      });
    });

    // hasTick2
    widget.controller.hasTick2(widget.date).then((value) {
      setState(() {
        hasTick2 = value;
      });
    });

    // hasTick3
    widget.controller.hasTick3(widget.date).then((value) {
      setState(() {
        hasTick3 = value;
      });
    });
  }

  @override
  void didUpdateWidget(Day oldWidget) {
    super.didUpdateWidget(oldWidget);

    bool didChangeController = oldWidget.controller != widget.controller;

    bool didChangeDate;
    DateTime oldDate = oldWidget.date;
    DateTime newDate = widget.date;
    didChangeDate = oldDate.year != newDate.year ||
        oldDate.month != newDate.month ||
        oldDate.day != newDate.day;

    if (didChangeController || didChangeDate) {
      setState(() {
        initDefaultValues();
      });

      initAsync();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: SmallCalendarStyle.of(context).dayStyleData.padding,
      child: new Material(
        color: Colors.transparent,
        child: new InkWell(
          onTap: (widget.onDayPressed != null)
              ? () {
                  widget.onDayPressed(widget.date);
                }
              : null,
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // text
              new Expanded(
                flex: 3,
                child: createDayNum(),
              ),
              // separation
              new Container(
                height: SmallCalendarStyle
                    .of(context)
                    .dayStyleData
                    .textTickSeparation,
              ),
              // ticks
              new Expanded(
                flex: 1,
                child: createTicks(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createDayNum() {
    Color circleColor = Colors.transparent;
    if (isToday) {
      circleColor = SmallCalendarStyle.of(context).dayStyleData.todayColor;
    }
    if (isSelected) {
      circleColor = SmallCalendarStyle.of(context).dayStyleData.selectedColor;
    }

    return new Container(
      decoration: new BoxDecoration(
        color: circleColor,
        shape: BoxShape.circle,
      ),
      child: new Center(
        child: new ClipRect(
          child: new Text(
            "${widget.date.day}",
            style: widget.isExtendedDay
                ? SmallCalendarStyle.of(context).dayStyleData.extendedDayTextStyle
                : SmallCalendarStyle.of(context).dayStyleData.dayTextStyle,
          ),
        ),
      ),
    );
  }

  Widget createTicks() {
    List<Widget> ticks = <Widget>[];

    // tick1
    if (hasTick1) {
      ticks.add(
        createTick(
          color: SmallCalendarStyle.of(context).dayStyleData.tick1Color,
        ),
      );
    }

    // tick2
    if (hasTick2) {
      ticks.add(
        createTick(
          color: SmallCalendarStyle.of(context).dayStyleData.tick2Color,
        ),
      );
    }

    // tick3
    if (hasTick3) {
      ticks.add(
        createTick(
          color: SmallCalendarStyle.of(context).dayStyleData.tick3Color,
        ),
      );
    }

    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: ticks,
    );
  }

  Widget createTick({@required Color color}) {
    return new Expanded(
      child: new Container(
        decoration: new BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget createTickSeparator() {
    return new Container(
      width: SmallCalendarStyle.of(context).dayStyleData.tickSeparation,
    );
  }
}
