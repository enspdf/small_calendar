import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class DayStyleData {
  /// [TextStyle] of widget representing the day of month number.
  final TextStyle dayTextStyle;

  /// [TextStyle] of widget representing the day of month number, if the day is
  /// of previous or next month.
  final TextStyle extendedDayTextStyle;

  /// [Color] of indicator that specific day is today.
  final Color todayColor;

  /// [Color] of indicator that specific day is selected.
  final Color selectedColor;

  /// If true ticks will be shown.
  final bool showTicks;

  /// [Color] of tick1.
  final Color tick1Color;

  /// [Color] of tick2.
  final Color tick2Color;

  /// [Color] of tick3.
  final Color tick3Color;

  /// Margin around a widget representing a day.
  final EdgeInsetsGeometry margin;

  /// Height of separation between day of month text and ticks.
  final double textTickSeparation;

  DayStyleData.raw({
    @required this.dayTextStyle,
    @required this.extendedDayTextStyle,
    @required this.todayColor,
    @required this.selectedColor,
    @required this.showTicks,
    @required this.tick1Color,
    @required this.tick2Color,
    @required this.tick3Color,
    @required this.margin,
    @required this.textTickSeparation,
  })
      : assert(dayTextStyle != null),
        assert(extendedDayTextStyle != null),
        assert(todayColor != null),
        assert(selectedColor != null),
        assert(showTicks != null),
        assert(tick1Color != null),
        assert(tick2Color != null),
        assert(tick3Color != null),
        assert(margin != null),
        assert(textTickSeparation != null);

  factory DayStyleData({
    TextStyle dayTextStyle,
    TextStyle extendedDayTextStyle,
    Color todayColor,
    Color selectedColor,
    bool showTicks = true,
    Color tick1Color,
    Color tick2Color,
    Color tick3Color,
    EdgeInsetsGeometry margin =
        const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
    double textTickSeparation = 2.0,
  }) {
    return new DayStyleData.raw(
      dayTextStyle: dayTextStyle ?? new TextStyle(),
      extendedDayTextStyle:
          extendedDayTextStyle ?? new TextStyle(fontWeight: FontWeight.w300),
      todayColor: todayColor ?? Colors.blue[200],
      selectedColor: selectedColor ?? Colors.purple[200],
      showTicks: showTicks,
      tick1Color: tick1Color ?? Colors.red,
      tick2Color: tick2Color ?? Colors.green,
      tick3Color: tick3Color ?? Colors.blue,
      margin: margin,
      textTickSeparation: textTickSeparation,
    );
  }

  DayStyleData copyWith({
    TextStyle dayTextStyle,
    TextStyle extendedDayTextStyle,
    Color todayColor,
    Color selectedColor,
    bool showTicks,
    Color tick1Color,
    Color tick2Color,
    Color tick3Color,
    EdgeInsetsGeometry margin,
    double textTickSeparation,
  }) {
    return new DayStyleData.raw(
      dayTextStyle: dayTextStyle ?? this.dayTextStyle,
      extendedDayTextStyle: extendedDayTextStyle ?? this.extendedDayTextStyle,
      todayColor: todayColor ?? this.todayColor,
      selectedColor: selectedColor ?? this.selectedColor,
      showTicks: showTicks ?? this.showTicks,
      tick1Color: tick1Color ?? this.tick1Color,
      tick2Color: tick2Color ?? this.tick2Color,
      tick3Color: tick3Color ?? this.tick3Color,
      margin: margin ?? this.margin,
      textTickSeparation: textTickSeparation ?? this.textTickSeparation,
    );
  }
}
