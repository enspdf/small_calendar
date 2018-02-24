import 'package:flutter/material.dart';

import 'package:small_calendar/small_calendar.dart';

import 'custom_small_calendar_controller.dart';

class SmallCalendarExampleApp extends StatefulWidget {
  @override
  State createState() => new _SmallCalendarExampleAppState();
}

class _SmallCalendarExampleAppState extends State<SmallCalendarExampleApp> {
  bool showWeekdayIndication = true;
  SmallCalendarController smallCalendarController =
      createSmallCalendarController();

  @override
  void initState() {
    super.initState();
  }

  Widget createSmallCalendar() {
    return new SmallCalendar(
      showWeekdayIndication: showWeekdayIndication,
      controller: smallCalendarController,
      firstWeekday: DateTime.monday,
      weekdayIndicationStyle: new WeekdayIndicationStyleData(
        backgroundColor: Theme.of(context).primaryColor,
        textStyle: new TextStyle(color: Colors.grey[300])
      ),
      dayStyle: new DayStyleData(
        tick3Color: Colors.orange,
      ),
      onDayPressed: (DateTime date) {
        print("$date");
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
        body: new Column(
          children: <Widget>[
            // calendar
            new Expanded(
              child: new Container(
                color: Colors.grey[300],
                child: new Center(
                  child: new Container(
                    width: 250.0,
                    height: 250.0,
                    color: Colors.white,
                    // Small Calendar ------------------------------------------
                    child: createSmallCalendar(),
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
                          onChanged: (value) {
                            setState(() {
                              showWeekdayIndication = value;
                            });
                          },
                        ),
                        new Text("Show Weekday Indication"),
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
        ),
      ),
    );
  }
}
