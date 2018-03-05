import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'data/all.dart';
import 'style_data/all.dart';
import 'widgets/all.dart';
import 'small_calendar_controller.dart';
import 'callbacks.dart';
import 'generator.dart';

class SmallCalendar extends StatefulWidget {
  /// Initial date that is displayed when the widget is created.
  final DateTime initialDate;

  /// Integer representing firstWeekday.
  final int firstWeekday;

  /// Style of day widgets.
  final DayStyleData dayStyle;

  /// If true weekday indication will be shown.
  final bool showWeekdayIndication;

  /// Height of weekday indication area
  final double weekdayIndicationHeight;

  /// Style of weekday indication.
  final WeekdayIndicationStyleData weekdayIndicationStyle;

  /// Map of <int>weekday and <String>weekdayName value pairs.
  final Map<int, String> dayNamesMap;

  /// Controller
  final SmallCalendarController controller;

  /// Callback that fires when user selects on a day.
  final DateTimeCallback onDayPressed;

  final YearMonthCallback onDisplayedMonthChanged;

  SmallCalendar._internal(
      {@required this.initialDate,
      @required this.firstWeekday,
      this.dayStyle,
      @required this.showWeekdayIndication,
      @required this.weekdayIndicationHeight,
      this.weekdayIndicationStyle,
      @required this.dayNamesMap,
      @required this.controller,
      this.onDayPressed,
      this.onDisplayedMonthChanged})
      : assert(initialDate != null),
        assert(firstWeekday != null),
        assert(showWeekdayIndication != null),
        assert(weekdayIndicationHeight != null),
        assert((firstWeekday >= DateTime.MONDAY) &&
            (firstWeekday <= DateTime.SUNDAY)),
        assert(dayNamesMap != null),
        assert(controller != null);

  factory SmallCalendar({
    DateTime initialDate,
    int firstWeekday = DateTime.monday,
    DayStyleData dayStyle,
    bool showWeekdayIndication = true,
    double weekdayIndicationHeight = 25.0,
    WeekdayIndicationStyleData weekdayIndicationStyle,
    Map<int, String> dayNamesMap = oneLetterEnglishDayNames,
    SmallCalendarController controller,
    DateTimeCallback onDayPressed,
    YearMonthCallback onDisplayedMonthChanged,
  }) {
    // checks that dayNamesMap contains a keyValue pair for every weekday
    if (showWeekdayIndication) {
      for (int i = DateTime.monday; i <= DateTime.sunday; i++) {
        if (!dayNamesMap.containsKey(i)) {
          throw new ArgumentError(
            "dayNamesMap shuld contain a key-value pair for every weekday (missing value for weekday: $i)",
          );
        }
      }
    }

    initialDate = initialDate ?? new DateTime.now();

    return new SmallCalendar._internal(
      initialDate: initialDate,
      firstWeekday: firstWeekday,
      dayStyle: dayStyle,
      showWeekdayIndication: showWeekdayIndication,
      weekdayIndicationHeight: weekdayIndicationHeight,
      weekdayIndicationStyle: weekdayIndicationStyle,
      dayNamesMap: dayNamesMap,
      controller: controller ?? new SmallCalendarController(),
      onDayPressed: onDayPressed,
      onDisplayedMonthChanged: onDisplayedMonthChanged,
    );
  }

  @override
  State createState() => new _SmallCalendarState();
}

class _SmallCalendarState extends State<SmallCalendar> {
  static const _initial_page = 1000000;

  PageController pageController;
  Month initialMonth;

  List<int> weekdayIndicationDays;

  @override
  void initState() {
    super.initState();

    initPageController();
    initInitialMonth();
    initWeekdayIndicationDays();

    widget.controller.addGoToDateListener(onGoToDate);
  }

  void initPageController() {
    pageController = new PageController(initialPage: _initial_page);
    pageController.addListener(onPageChanged);
  }

  void initInitialMonth() {
    initialMonth = new Month.fromDateTime(widget.initialDate);
  }

  void initWeekdayIndicationDays() {
    weekdayIndicationDays = generateWeekdays(widget.firstWeekday);
  }

  @override
  void dispose() {
    widget.controller.removeGoToDateListener(onGoToDate);

    super.dispose();
  }

  @override
  void didUpdateWidget(SmallCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeGoToDateListener(onGoToDate);
      widget.controller.addGoToDateListener(onGoToDate);
    }

    bool shouldRefresh = false;
    if (oldWidget.firstWeekday != widget.firstWeekday) {
      shouldRefresh = true;
      initWeekdayIndicationDays();
    }
    if (oldWidget.initialDate != widget.initialDate) {
      shouldRefresh = true;
      initPageController();
      initInitialMonth();
    }

    if (shouldRefresh) {
      setState(() {});
    }
  }

  void onPageChanged() {
    if (widget.onDisplayedMonthChanged != null) {
      int page = pageController.page.toInt();

      Month displayedMonth = initialMonth.add(
        page - _initial_page,
      );

      widget.onDisplayedMonthChanged(
        displayedMonth.year,
        displayedMonth.month,
      );
    }
  }

  void onGoToDate(DateTime date) {
    Month desiredMonth = new Month.fromDateTime(date);

    int difference = Month.getDifference(initialMonth, desiredMonth);
    pageController.jumpToPage(_initial_page + difference);
  }

  Widget monthCalendarBuilder(BuildContext context, int index) {
    return new MonthCalendar(
      month: initialMonth.add(index - _initial_page),
      firstWeekday: widget.firstWeekday,
      controller: widget.controller,
      showWeekdayIndication: widget.showWeekdayIndication,
      weekdayIndicationDays: weekdayIndicationDays,
      dayNames: widget.dayNamesMap,
      weekdayIndicationHeight: widget.weekdayIndicationHeight,
      onDayPressed: widget.onDayPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new SmallCalendarStyle(
        dayStyleData: widget.dayStyle,
        weekdayIndicationStyleData: widget.weekdayIndicationStyle,
        child: new PageView.builder(
          itemBuilder: monthCalendarBuilder,
          controller: pageController,
        ),
      ),
    );
  }
}
