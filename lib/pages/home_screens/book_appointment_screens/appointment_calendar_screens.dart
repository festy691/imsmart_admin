import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';

extension DateTimeExt on DateTime {
  DateTime get monthStart => DateTime(year, month);
  DateTime get dayStart => DateTime(year, month, day);

  DateTime addMonth(int count) {
    return DateTime(year, month + count, day);
  }

  bool isSameDate(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }

  bool get isToday {
    return isSameDate(DateTime.now());
  }
}

class AppointmentCalendar extends StatefulWidget {
  final List<DateTime> markedDates;

  const AppointmentCalendar({required this.markedDates, Key? key})
      : super(key: key);

  @override
  State<AppointmentCalendar> createState() => _AppointmentCalendarState();
}

class _AppointmentCalendarState extends State<AppointmentCalendar> {
  late DateTime selectedMonth;

  DateTime? selectedDate;

  @override
  void initState() {
    // Start from the current month
    selectedMonth = DateTime.now().monthStart;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.h,
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _Header(
            selectedMonth: selectedMonth,
            selectedDate: selectedDate,
            onChange: (value) => setState(() => selectedMonth = value),
          ),
          Expanded(
            child: _Body(
              selectedDate: selectedDate,
              selectedMonth: selectedMonth,
              markedDates: widget.markedDates,
              selectDate: (DateTime value) => setState(() {
                selectedDate = value;
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.selectedMonth,
    required this.selectedDate,
    required this.markedDates,
    required this.selectDate,
  });

  final DateTime selectedMonth;
  final DateTime? selectedDate;
  final List<DateTime> markedDates;

  final ValueChanged<DateTime> selectDate;

  @override
  Widget build(BuildContext context) {
    var data = CalendarMonthData(
      year: selectedMonth.year,
      month: selectedMonth.month,
      markedDates: markedDates,
    );

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text('M'),
              Text('T'),
              Text('W'),
              Text('T'),
              Text('F'),
              Text('S'),
              Text('S'),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 1.h,
              color: Colors.pink[200],
            ),
            for (var week in data.weeks)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: Row(
                  children: week.map((d) {
                    return Expanded(
                      child: _RowItem(
                        hasRightBorder: false,
                        date: d.date,
                        isActiveMonth: d.isActiveMonth,
                        onTap: () => selectDate(d.date),
                        isSelected: selectedDate != null &&
                            selectedDate!.isSameDate(d.date),
                        isMarked: markedDates.contains(d.date),
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _RowItem extends StatelessWidget {
  const _RowItem({
    required this.hasRightBorder,
    required this.isActiveMonth,
    required this.isSelected,
    required this.isMarked,
    required this.date,
    required this.onTap,
  });

  final bool hasRightBorder;
  final bool isActiveMonth;
  final VoidCallback onTap;
  final bool isSelected;
  final bool isMarked;

  final DateTime date;
  @override
  Widget build(BuildContext context) {
    final int number = date.day;
    final isToday = date.isToday;
    final bool isPassed = date.isBefore(DateTime.now());

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        height: 35.h,
        decoration: isSelected
            ? const BoxDecoration(
                color: Pallet.primaryColor, shape: BoxShape.circle)
            : isToday
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(35.r),
                    border: Border.all(
                      color: Pallet.primaryColor,
                    ),
                  )
                : isMarked
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(35.r),
                        color: Pallet.deepBlue,
                      )
                    : null,
        child: Text(
          number.toString(),
          style: TextStyle(
            fontSize: 14.sp,
            color: isMarked
                ? Pallet.primaryColor
                : isPassed
                    ? isActiveMonth
                        ? Pallet.grey.withOpacity(0.7)
                        : Pallet.transparent
                    : isActiveMonth
                        ? Pallet.black
                        : Colors.grey[300],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.selectedMonth,
    required this.selectedDate,
    required this.onChange,
  });

  final DateTime selectedMonth;
  final DateTime? selectedDate;

  final ValueChanged<DateTime> onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.w),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Month: ${selectedMonth.month}/${selectedMonth.year}',
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                onPressed: () {
                  onChange(selectedMonth.subtract(
                      const Duration(days: 30))); // Go to the previous month
                },
                icon: const Icon(Icons.arrow_left_sharp),
              ),
              IconButton(
                onPressed: () {
                  onChange(selectedMonth
                      .add(const Duration(days: 30))); // Go to the next month
                },
                icon: const Icon(Icons.arrow_right_sharp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CalendarMonthData {
  final int year;
  final int month;
  final List<DateTime> markedDates;

  int get daysInMonth => DateTime(year, month + 1, 0).day;
  int get firstDayOfWeekIndex => 0;

  int get weeksCount => ((daysInMonth + firstDayOffset) / 7).ceil();

  const CalendarMonthData({
    required this.year,
    required this.month,
    required this.markedDates,
  });

  int get firstDayOffset {
    final int weekdayFromMonday = DateTime(year, month).weekday - 1;

    return (weekdayFromMonday - ((firstDayOfWeekIndex - 1) % 7)) % 7 - 1;
  }

  List<List<CalendarDayData>> get weeks {
    final res = <List<CalendarDayData>>[];
    var firstDayMonth = DateTime(year, month, 1);
    var firstDayOfWeek = firstDayMonth.subtract(Duration(days: firstDayOffset));

    for (var w = 0; w < weeksCount; w++) {
      final week = List<CalendarDayData>.generate(
        7,
        (index) {
          final date = firstDayOfWeek.add(Duration(days: index));

          final isActiveMonth = date.year == year && date.month == month;

          return CalendarDayData(
            date: date,
            isActiveMonth: isActiveMonth,
            isActiveDate: markedDates.contains(date),
          );
        },
      );
      res.add(week);
      firstDayOfWeek = firstDayOfWeek.add(const Duration(days: 7));
    }
    return res;
  }
}

class CalendarDayData {
  final DateTime date;
  final bool isActiveMonth;
  final bool isActiveDate;

  const CalendarDayData({
    required this.date,
    required this.isActiveMonth,
    required this.isActiveDate,
  });
}
