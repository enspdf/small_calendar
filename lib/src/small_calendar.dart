import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:small_calendar/src/style_data/all.dart';
import 'package:small_calendar/src/widgets/all.dart';

import 'package:small_calendar/src/callbacks.dart';
import 'package:small_calendar/src/data.dart';
import 'package:small_calendar/src/small_calendar_controller.dart';
import 'package:small_calendar/src/util.dart';

class SmallCalendar extends StatefulWidget {
  /// If true weekday indication will be shown.
  final bool showWeekdayIndication;

  /// Initial date that is displayed when the widget is created.
  final DateTime initialDate;

  /// Integer representing firstWeekday.
  final int firstWeekday;

  /// Style of day widgets.
  final DayStyleData dayStyle;

  /// Style of weekday indication.
  final WeekdayIndicationStyleData weekdayIndicationStyle;

  /// Map of <int>weekday and <String>weekdayName value pairs.
  final Map<int, String> dayNamesMap;

  /// Height of weekday indication area
  final double weekdayIndicationHeight;

  /// Controller
  final SmallCalendarController controller;

  /// Callback that fires when user selects on a day.
  final DateCallback onDayPressed;

  final Key key;

  SmallCalendar._internal({
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
      : assert(showWeekdayIndication != null),
        assert(initialDate != null),
        assert(firstWeekday != null),
        assert((firstWeekday >= DateTime.MONDAY) &&
            (firstWeekday <= DateTime.SUNDAY)),
        assert(dayNamesMap != null),
        assert(weekdayIndicationHeight != null),
        assert(controller != null),
        assert(key != null);

  factory SmallCalendar({
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
    // checks that dayNamesMap contains a keyValue pair for every weekday
    if (showWeekdayIndication) {
      for (int i = DateTime.monday; i <= DateTime.sunday; i++) {
        if (!dayNamesMap.containsKey(i)) {
          throw new ArgumentError(
              "dayNamesMap shuld contain a key-value pair for every weekday");
        }
      }
    }

    initialDate = initialDate ?? new DateTime.now();

    return new SmallCalendar._internal(
      showWeekdayIndication: showWeekdayIndication,
      initialDate: initialDate,
      firstWeekday: firstWeekday,
      dayStyle: dayStyle,
      weekdayIndicationStyle: weekdayIndicationStyle,
      dayNamesMap: dayNamesMap,
      weekdayIndicationHeight: weekdayIndicationHeight,
      controller: controller ?? new SmallCalendarController(),
      onDayPressed: onDayPressed,
      key: new Key(
          "${initialDate.year}.${initialDate.month}.${initialDate.day};"),
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
