import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class DayStyleData {
  final TextStyle dayTextStyle;
  final TextStyle extendedDayTextStyle;

  final Color todayColor;
  final Color selectedColor;

  final bool showTicks;

  final Color tick1Color;
  final Color tick2Color;
  final Color tick3Color;

  final EdgeInsetsGeometry padding;

  final double textTickSeparation;
  final double tickSeparation;

  DayStyleData.raw({
    @required this.dayTextStyle,
    @required this.extendedDayTextStyle,
    @required this.todayColor,
    @required this.selectedColor,
    @required this.showTicks,
    @required this.tick1Color,
    @required this.tick2Color,
    @required this.tick3Color,
    @required this.padding,
    @required this.textTickSeparation,
    @required this.tickSeparation,
  })
      : assert(dayTextStyle != null),
        assert(extendedDayTextStyle != null),
        assert(todayColor != null),
        assert(selectedColor != null),
        assert(showTicks != null),
        assert(tick1Color != null),
        assert(tick2Color != null),
        assert(tick3Color != null),
        assert(padding != null),
        assert(textTickSeparation != null),
        assert(tickSeparation != null);

  factory DayStyleData({
    TextStyle dayTextStyle,
    TextStyle extendedDayTextStyle,
    Color todayColor,
    Color selectedColor,
    bool showTicks = true,
    Color tick1Color,
    Color tick2Color,
    Color tick3Color,
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
    double textTickSeparation = 2.0,
    double tickSeparation = 0.0,
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
      padding: padding,
      textTickSeparation: textTickSeparation,
      tickSeparation: tickSeparation,
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
    EdgeInsetsGeometry padding,
    double textTickSeparation,
    double tickSeparation,
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
      padding: padding ?? this.padding,
      textTickSeparation: textTickSeparation ?? this.textTickSeparation,
      tickSeparation: tickSeparation ?? this.tickSeparation,
    );
  }
}
