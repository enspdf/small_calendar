import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:small_calendar/src/widgets/all.dart';

import 'package:small_calendar/src/callbacks.dart';
import 'package:small_calendar/src/small_calendar_controller.dart';

class Day extends StatefulWidget {
  final DateTime date;
  final bool isExtendedDay;
  final SmallCalendarController controller;
  final DateCallback onDayPressed;

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
  bool isActive;

  bool isToday;
  bool isSelected;
  bool hasTick1;
  bool hasTick2;
  bool hasTick3;

  @override
  void initState() {
    super.initState();

    isActive = true;

    initDefaultValues();

    gatherIsHasInformation();
    registerAsOnDayRefreshListener();
  }

  @override
  void dispose() {
    isActive = false;

    widget.controller.removeDayRefreshListener(onDayRefresh);

    super.dispose();
  }

  void initDefaultValues() {
    isToday = false;
    isSelected = false;
    hasTick1 = false;
    hasTick2 = false;
    hasTick3 = false;
  }

  Future gatherIsHasInformation() async {
    // isToday
    widget.controller.isToday(widget.date).then((value) {
      if (!isActive) return;

      setState(() {
        isToday = value;
      });
    });

    // isSelected
    widget.controller.isSelected(widget.date).then((value) {
      if (!isActive) return;

      setState(() {
        isSelected = value;
      });
    });

    // hasTick1
    widget.controller.hasTick1(widget.date).then((value) {
      if (!isActive) return;

      setState(() {
        hasTick1 = value;
      });
    });

    // hasTick2
    widget.controller.hasTick2(widget.date).then((value) {
      if (!isActive) return;

      setState(() {
        hasTick2 = value;
      });
    });

    // hasTick3
    widget.controller.hasTick3(widget.date).then((value) {
      if (!isActive) return;

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

      gatherIsHasInformation();
      oldWidget.controller.removeDayRefreshListener(onDayRefresh);
      registerAsOnDayRefreshListener();
    }
  }

  // onDayRefresh --------------------------------------------------------------

  void onDayRefresh() {
    setState(() {
      initDefaultValues();
    });

    gatherIsHasInformation();
  }

  void registerAsOnDayRefreshListener() {
    widget.controller.addDayRefreshListener(onDayRefresh);
  }

  // gui -----------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    VoidCallback onTap;
    if (widget.onDayPressed != null) {
      onTap = () {
        widget.onDayPressed(widget.date);
      };
    }

    List<Widget> mainColumnItems = <Widget>[
      // text
      new Expanded(
        flex: 3,
        child: createDayNum(),
      ),
    ];
    if (SmallCalendarStyle.of(context).dayStyleData.showTicks) {
      mainColumnItems.add(
        // separation
        new Container(
          height:
              SmallCalendarStyle.of(context).dayStyleData.textTickSeparation,
        ),
      );
      mainColumnItems.add(
        // ticks
        new Expanded(
          flex: 1,
          child: createTicks(),
        ),
      );
    }

    return new Container(
      padding: SmallCalendarStyle.of(context).dayStyleData.padding,
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
}
