import 'dart:async';

import 'package:small_calendar/small_calendar.dart';

class CustomSmallCalendarController extends SmallCalendarController {
  @override
  Future<bool> isSelected(DateTime date) async {
    if (date.day == 10){
      return true;
    }

    return false;
  }

  @override
  Future<bool> hasTick1(DateTime date) async {
    if (date.day == 1 || date.day == 4 || date.day == 5) {
      return true;
    }

    return false;
  }

  @override
  Future<bool> hasTick2(DateTime date) async {
    if (date.day == 2 || date.day == 4 || date.day == 5) {
      return true;
    }

    return false;
  }

  @override
  Future<bool> hasTick3(DateTime date) async {
    if (date.day == 3 || date.day == 5) {
      return true;
    }

    return false;
  }


}
