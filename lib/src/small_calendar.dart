import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:small_calendar/src/style_data/all.dart';
import 'package:small_calendar/src/widgets/all.dart';

import 'package:small_calendar/src/callbacks.dart';
import 'package:small_calendar/src/data.dart';
import 'package:small_calendar/src/small_calendar_controller.dart';
import 'package:small_calendar/src/util.dart';

class SmallCalendar extends StatefulWidget {
  /// Number of months that will be displayed
  final int totalNumberOfMonths;

  final bool showWeekdayIndication;

  final DateTime initialDate;
  final int firstWeekday;

  final DayStyleData dayStyle;
  final WeekdayIndicationStyleData weekdayIndicationStyle;

  final Map<int, String> dayNamesMap;

  final double weekdayIndicationHeight;

  final SmallCalendarController controller;

  final DateCallback onDayPressed;

  final Key key;

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
    @required this.key,
  })
      : assert(totalNumberOfMonths != null),
        assert(showWeekdayIndication != null),
        assert(initialDate != null),
        assert(firstWeekday != null),
        assert((firstWeekday >= DateTime.MONDAY) &&
            (firstWeekday <= DateTime.SUNDAY)),
        assert(dayNamesMap != null),
        assert(weekdayIndicationHeight != null),
        assert(controller != null),
        assert(key != null);

  factory SmallCalendar({
    int totalNumberOfMonths = 120,
    bool showWeekdayIndication = true,
    DateTime initialDate,
    int firstWeekday = DateTime.monday,
    DayStyleData dayStyle,
    WeekdayIndicationStyleData weekdayIndicationStyle,
    Map<int, String> dayNamesMap = oneLetterEnglishDayNames,
    double weekdayIndicationHeight = 25.0,
    SmallCalendarController controller,
    DateCallback onDayPressed,
  }) {
    initialDate = initialDate ?? new DateTime.now();

    return new SmallCalendar._internal(
      totalNumberOfMonths: totalNumberOfMonths,
      showWeekdayIndication: showWeekdayIndication,
      initialDate: initialDate,
      firstWeekday: firstWeekday,
      dayStyle: dayStyle,
      weekdayIndicationStyle: weekdayIndicationStyle,
      dayNamesMap: dayNamesMap,
      weekdayIndicationHeight: weekdayIndicationHeight,
      controller: controller ?? new SmallCalendarController(),
      onDayPressed: onDayPressed,
      key:
          new Key("${initialDate.year}.${initialDate.month}.${initialDate.day};"
              "totalNumOfMonths:$totalNumberOfMonths"),
    );
  }

  @override
  State createState() => new _SmallCalendarState();
}

class _SmallCalendarState extends State<SmallCalendar>
    with SingleTickerProviderStateMixin {
  List<Widget> tabs;
  Month firstMonth;
  TabController tabController;

  @override
  void initState() {
    super.initState();

    int initialIndex = widget.totalNumberOfMonths ~/ 2;

    Month initialMonth = new Month(
      widget.initialDate.year,
      widget.initialDate.month,
    );

    firstMonth = generateMonthXMonthsAgo(
      initialMonth,
      widget.totalNumberOfMonths - initialIndex,
    );

    tabController = new TabController(
      length: widget.totalNumberOfMonths,
      initialIndex: initialIndex,
      vsync: this,
    );

    tabs = generateTabs();

    registerGoToListener();
  }

  @override
  void dispose() {
    removeGoToListener();

    super.dispose();
  }

  @override
  void didUpdateWidget(SmallCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      registerGoToListener();
    }

    bool makeNewTabs = false;
    makeNewTabs = makeNewTabs ||
        oldWidget.showWeekdayIndication != widget.showWeekdayIndication;
    makeNewTabs = makeNewTabs || oldWidget.dayNamesMap != widget.dayNamesMap;
    makeNewTabs = makeNewTabs || oldWidget.firstWeekday != widget.firstWeekday;
    makeNewTabs = makeNewTabs ||
        oldWidget.weekdayIndicationHeight != widget.weekdayIndicationHeight;
    makeNewTabs = makeNewTabs || oldWidget.controller != widget.controller;
    makeNewTabs = makeNewTabs || oldWidget.onDayPressed != widget.onDayPressed;
    if (makeNewTabs) {
      setState(() {
        tabs = generateTabs();
      });
    }
  }

  void registerGoToListener() {
    widget.controller.addGoToListener(changeToTabThatDisplaysDate);
  }

  void removeGoToListener() {
    widget.controller.removeGoToListener(changeToTabThatDisplaysDate);
  }

  void changeToTabThatDisplaysDate(DateTime date) {
    int desiredTabNumber;

    if (date.isBefore(new DateTime(firstMonth.year, firstMonth.month))) {
      desiredTabNumber = 0;
    } else {
      desiredTabNumber = getDifferenceOfMonths(
        firstMonth,
        new Month.fromDateTime(date),
        widget.totalNumberOfMonths,
      );

      if (desiredTabNumber >= tabController.length) {
        desiredTabNumber = tabController.length - 1;
      }
    }

    tabController.animateTo(desiredTabNumber);
  }

  List<Widget> generateTabs() {
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

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new SmallCalendarStyle(
        dayStyleData: widget.dayStyle,
        weekdayIndicationStyleData: widget.weekdayIndicationStyle,
        child: new TabBarView(
          controller: tabController,
          children: generateTabs(),
        ),
      ),
    );
  }
}
