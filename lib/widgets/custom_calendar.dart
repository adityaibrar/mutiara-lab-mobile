import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/theme.dart';

class CustomCalendar extends StatefulWidget {
  final TextEditingController dateController;
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  const CustomCalendar({
    super.key,
    required this.dateController,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      padding: EdgeInsetsGeometry.only(bottom: 24.h, left: 16.w, right: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TableCalendar(
            availableCalendarFormats: {CalendarFormat.month: 'Month'},
            firstDay: DateTime.now().subtract(const Duration(days: 365)),
            lastDay: DateTime.now().add(const Duration(days: 30)),
            focusedDay: widget.selectedDate,
            selectedDayPredicate: (day) => isSameDay(day, widget.selectedDate),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                widget.dateController.text =
                    '${selectedDay.day}-${selectedDay.month}-${selectedDay.year}';
              });
              widget.onDateSelected(selectedDay);
              Navigator.pop(context);
            },
            calendarStyle: CalendarStyle(
              holidayTextStyle: TextStyle(color: redColor),
              isTodayHighlighted: false,
              selectedDecoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(weekendStyle: redTextStyle),
          ),
        ],
      ),
    );
  }
}
