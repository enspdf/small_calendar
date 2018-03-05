import 'dart:async';

import 'package:flutter/material.dart';

import 'package:small_calendar/small_calendar.dart';

void main() {
  runApp(
    new SmallCalendarExampleApp(),
  );
}

class SmallCalendarExampleApp extends StatefulWidget {
  @override
  State createState() => new _SmallCalendarExampleAppState();
}

class _SmallCalendarExampleAppState extends State<SmallCalendarExampleApp> {
  bool showWeekdayIndication = true;
  bool showTicks = true;
  SmallCalendarController smallCalendarController =
      createSmallCalendarController();

  @override
  void initState() {
    super.initState();
  }

  Widget createSmallCalendar(BuildContext context) {
    return new SmallCalendar(
      firstWeekday: DateTime.monday,
      controller: smallCalendarController,
      dayStyle: new DayStyleData(
        showTicks: showTicks,
        tick3Color: Colors.yellow[700],
      ),
      showWeekdayIndication: showWeekdayIndication,
      weekdayIndicationStyle: new WeekdayIndicationStyleData(
          backgroundColor: Theme.of(context).primaryColor),
      onDayPressed: (DateTime date) {
        Scaffold.of(context).showSnackBar(new SnackBar(
              content: new Text(
                "Pressed on ${date.year}.${date.month}.${date.day}",
              ),
            ));
      },
      onDisplayedMonthChanged: (int year, int month){
        print("Displaying $year.$month");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "small_calendar example",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("small_calendar example"),
        ),
        body:
            // Creates an inner BuildContext so that the onDayPressed method in SmallCalendar
            // can refer to the Scaffold with Scaffold.of().
            new Builder(
          builder: (BuildContext context) {
            return new Column(
              children: <Widget>[
                // calendar
                new Expanded(
                  child: new Container(
                    color: Colors.grey[300],
                    child: new Center(
                      child: new Container(
                        width: 250.0,
                        height: 250.0,
                        color: Theme.of(context).cardColor,
                        // Small Calendar ------------------------------------------
                        child: createSmallCalendar(context),
                        // ---------------------------------------------------------
                      ),
                    ),
                  ),
                ),
                // controls
                new Expanded(
                  child: new SingleChildScrollView(
                    child: new Column(
                      children: <Widget>[
                        // show weekday indication
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Checkbox(
                              value: showWeekdayIndication,
                              onChanged: (newValue) {
                                setState(() {
                                  showWeekdayIndication = newValue;
                                });
                              },
                            ),
                            new Text("Show Weekday Indication"),
                          ],
                        ),
                        // show ticks
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Checkbox(
                                value: showTicks,
                                onChanged: (newValue) {
                                  setState(() {
                                    showTicks = newValue;
                                  });
                                }),
                            new Text("Show Ticks"),
                          ],
                        ),
                        new RaisedButton(
                          child: new Text("Go to today"),
                          onPressed: () {
                            setState(() {
                              smallCalendarController.goToToday();
                            });
                          },
                        ),
                        new Divider(),
                        new Text(
                          """For example purpuses:
                    * every first day of month has tick1
                    * every second day of month has tick2
                    * every third day of month has tick3
                    * every fourth day of month has tick1 and tick2
                    * every fifth day of month has tick1, tick2 and tick3
                    * every tenth day of month is selected
                    """,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

SmallCalendarController createSmallCalendarController() {
  Future<bool> hasTick1Callback(DateTime date) async {
    if (date.day == 1 || date.day == 4 || date.day == 5) {
      return true;
    }

    return false;
  }

  Future<bool> hasTick2Callback(DateTime date) async {
    if (date.day == 2 || date.day == 4 || date.day == 5) {
      return true;
    }

    return false;
  }

  Future<bool> hasTick3Callback(DateTime date) async {
    if (date.day == 3 || date.day == 5) {
      return true;
    }

    return false;
  }

  return new SmallCalendarController(
    isSelectedCallback: (DateTime date) async {
      if (date.day == 10) {
        return true;
      }

      return false;
    },
    hasTick1Callback: hasTick1Callback,
    hasTick2Callback: hasTick2Callback,
    hasTick3Callback: hasTick3Callback,
  );
}
