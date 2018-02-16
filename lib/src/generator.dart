import 'package:meta/meta.dart';

List<int> generateWeekdays(int firstWeekday) {
  List<int> r = <int>[];

  int zeroBasedFirstWeekday = firstWeekday - 1;

  for (int i = 0; i < 7; i++) {
    r.add((((zeroBasedFirstWeekday + i) % 7)) + 1);
  }

  return r;
}
