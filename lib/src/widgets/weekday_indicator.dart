import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

class WeekdayIndicator extends StatelessWidget {
  final String text;

  WeekdayIndicator({
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.red,
      child: new Center(
        child: new Text(text),
      ),
    );
  }
}
