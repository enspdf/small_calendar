import 'dart:async';

class SmallCalendarController {
//  const SmallCalendarController();

  Future<bool> isToday(DateTime date) async {
    DateTime now = new DateTime.now();
    return (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day);
  }

  Future<bool> isSelected(DateTime date) async {
    return false;
  }

  Future<bool> hasTick1(DateTime date) async {
    return false;
  }

  Future<bool> hasTick2(DateTime date) async {
    return false;
  }

  Future<bool> hasTick3(DateTime date) async {
    return false;
  }
}
