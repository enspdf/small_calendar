import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class WeekdayIndicationStyleData {
  /// [TextStyle] of widget that is indicating a weekday.
  final TextStyle textStyle;

  /// Background [Color] of area that is indicating weekdays.
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
