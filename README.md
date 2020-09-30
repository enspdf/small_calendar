# small_calendar

small_calendar widget.

<img src="https://raw.githubusercontent.com/ZedTheLed/small_calendar/master/images/Screenshot_1.png" height="350px"/>

## Usage

1. Create new SmallCalendarData (this widget provides data to SmallCalendar-s down the widget tree)
(Optionally) Create SmallCalendarStyle (to change the looks of SmallCalendar)
2. Create SmallCalendarPager (to enable swiping between months)
3. In pageBuilder of SmallCalendarPager create a new SmallCalendar
4. If you wish to display SmallCalendar for only one Month (without the ability to swipe between months), omit the SmallCalendarPager.

### Add Dependency

```yaml
dependencies:
    small_calendar: "^0.3.0"
```

### Import It

```dart
import 'package:small_calendar/small_calendar.dart';
```
## Styling

<img src="https://raw.githubusercontent.com/ZedTheLed/small_calendar/master/images/items_explanation.png" height="300px"/>

* **1.** - weekdayIndicationHeight
* **2.** - WeekdayIndicationStyleData/textStyle
* **3.** - WeekdayIndicationStyleData/backgroundColor
* **4.** - DayStyleData/extendedDayTextStyle
* **5.** - DayStyleData/dayTextStyle
* **6.** - tick
* **7.** - textTickSeparation 
* **8.** - selectedColor
* **9.** - todayColor
