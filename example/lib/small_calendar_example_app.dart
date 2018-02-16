import 'package:flutter/material.dart';

import 'package:small_calendar/small_calendar.dart';

class SmallCalendarExampleApp extends StatefulWidget {
  @override
  State createState() => new _SmallCalendarExampleAppState();
}

class _SmallCalendarExampleAppState extends State<SmallCalendarExampleApp> {
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
            new Expanded(
              child: new Container(
                color: Colors.red[300],
                child: new Center(
                  child: new Container(
                    color: Colors.white,
                    width: 200.0,
                    child: new SmallCalendar(
                      initialYear: new DateTime.now().year,
                      initialMonth: new DateTime.now().month,
                      controller: new SmallCalendarController(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
