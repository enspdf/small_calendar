import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:small_calendar/src/callbacks.dart';

import '../data/all.dart';
import 'small_calendar_style.dart';

class DayWidget extends StatelessWidget {
  final DayData dayData;
  final DateTimeCallback onPressed;

  DayWidget({
    @required this.dayData,
    @required this.onPressed,
  })
      : super(key: new ObjectKey(dayData.day));

  @override
  Widget build(BuildContext context) {
    bool showTicks = SmallCalendarStyle.of(context).dayStyleData.showTicks;

    VoidCallback onTap;
    if (onPressed != null) {
      onTap = () {
        onPressed(dayData.day.toDateTime());
      };
    }

    List<Widget> mainColumnItems = <Widget>[];

    // text
    mainColumnItems.add(
      new Expanded(
        flex: 3,
        child: createDayNum(context),
      ),
    );

    // text-tick separation
    if (showTicks) {
      mainColumnItems.add(
        new Container(
          height:
              SmallCalendarStyle.of(context).dayStyleData.textTickSeparation,
        ),
      );
    }

    // ticks
    if (showTicks) {
      mainColumnItems.add(
        new Expanded(
          flex: 1,
          child: createTicks(context),
        ),
      );
    }

    return new Container(
      margin: SmallCalendarStyle.of(context).dayStyleData.margin,
      child: new Material(
        color: Colors.transparent,
        child: new InkWell(
          onTap: onTap,
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: mainColumnItems,
          ),
        ),
      ),
    );
  }

  Widget createDayNum(BuildContext context) {
    Color circleColor = Colors.transparent;
    if (dayData.isToday) {
      circleColor = SmallCalendarStyle.of(context).dayStyleData.todayColor;
    }
    if (dayData.isSelected) {
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
            "${dayData.day.day}",
            style: dayData.day.isExtended
                ? SmallCalendarStyle
                    .of(context)
                    .dayStyleData
                    .extendedDayTextStyle
                : SmallCalendarStyle.of(context).dayStyleData.dayTextStyle,
          ),
        ),
      ),
    );
  }

  Widget createTicks(BuildContext context) {
    List<Widget> ticks = <Widget>[];

    // tick1
    if (dayData.hasTick1) {
      ticks.add(
        createTick(
          color: SmallCalendarStyle.of(context).dayStyleData.tick1Color,
        ),
      );
    }

    // tick2
    if (dayData.hasTick2) {
      ticks.add(
        createTick(
          color: SmallCalendarStyle.of(context).dayStyleData.tick2Color,
        ),
      );
    }

    // tick3
    if (dayData.hasTick3) {
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
}
