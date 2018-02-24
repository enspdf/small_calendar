import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class WeekdayIndicationStyleData {
  final TextStyle textStyle;
  final Color backgroundColor;

  WeekdayIndicationStyleData.raw({
    @required this.textStyle,
    @required this.backgroundColor,
  })
      : assert(textStyle != null),
        assert(backgroundColor != null);

  factory WeekdayIndicationStyleData({
    TextStyle textStyle,
    Color backgroundColor,
  }) {
    return new WeekdayIndicationStyleData.raw(
      textStyle: textStyle ?? new TextStyle(),
      backgroundColor: backgroundColor ?? Colors.transparent,
    );
  }

  WeekdayIndicationStyleData copyWith({
    TextStyle textStyle,
    Color backgroundColor,
  }) {
    return new WeekdayIndicationStyleData.raw(
      textStyle: textStyle ?? this.textStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}
