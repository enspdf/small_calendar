import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:small_calendar/src/widgets/all.dart';

class WeekdayIndicator extends StatelessWidget {
  final String text;

  WeekdayIndicator({
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Text(
          text,
          style: SmallCalendarStyle
              .of(context)
              .weekdayIndicationStyleData
              .textStyle,
        ),
      ),
    );
  }
}
