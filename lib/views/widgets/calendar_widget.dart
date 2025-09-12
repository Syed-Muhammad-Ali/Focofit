import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/widgets/text.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime selectedDate = DateTime.now(); // Default to today's date
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // Set selected date to today by default
    selectedDate = DateTime.now();
    // Scroll to current date position
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentDate();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCurrentDate() {
    final currentDate = DateTime.now();
    final daysFromStart =
        currentDate.difference(DateTime(currentDate.year, 1, 1)).inDays;
    final itemWidth = 62.0; // 50 width + 12 margin
    final screenWidth = MediaQuery.of(context).size.width;
    final centerOffset = screenWidth / 2 - itemWidth / 2;

    _scrollController.animateTo(
      (daysFromStart * itemWidth) - centerOffset,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  List<Map<String, dynamic>> _generateYearDates() {
    List<Map<String, dynamic>> dates = [];
    final currentYear = DateTime.now().year;

    for (int month = 1; month <= 12; month++) {
      final daysInMonth = DateTime(currentYear, month + 1, 0).day;

      for (int day = 1; day <= daysInMonth; day++) {
        final date = DateTime(currentYear, month, day);
        final dayName = _getDayName(date.weekday);

        dates.add({
          'date': date,
          'day': dayName,
          'dayNumber': day.toString(),
          'month': month,
        });
      }
    }

    return dates;
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'SEG';
      case DateTime.tuesday:
        return 'TER';
      case DateTime.wednesday:
        return 'QUA';
      case DateTime.thursday:
        return 'QUI';
      case DateTime.friday:
        return 'SEX';
      case DateTime.saturday:
        return 'SAB';
      case DateTime.sunday:
        return 'DOM';
      default:
        return 'DOM';
    }
  }

  bool _isSelectedDate(DateTime date) {
    return selectedDate.year == date.year &&
        selectedDate.month == date.month &&
        selectedDate.day == date.day;
  }

  bool _isFutureDate(DateTime date) {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final checkDate = DateTime(date.year, date.month, date.day);
    return checkDate.isAfter(todayDate);
  }

  @override
  Widget build(BuildContext context) {
    final yearDates = _generateYearDates();
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            yearDates.map((dateInfo) {
              final date = dateInfo['date'] as DateTime;
              final isSelected = _isSelectedDate(date);
              final isToday =
                  DateTime.now().year == date.year &&
                  DateTime.now().month == date.month &&
                  DateTime.now().day == date.day;
              final isFuture = _isFutureDate(date);

              return GestureDetector(
                onTap:
                    isFuture
                        ? null
                        : () {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                child: Container(
                  width: 50,
                  margin: EdgeInsets.only(right: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        dateInfo['day'],
                        fontSize: 12,
                        color:
                            isFuture
                                ? Colors.grey[400]
                                : (isToday
                                    ? AppColor.primaryColor
                                    : Colors.grey[600]),
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? AppColor.primaryColor
                                  : Colors.transparent,
                          shape: BoxShape.circle,
                          border:
                              isToday && !isSelected
                                  ? Border.all(
                                    color: AppColor.primaryColor,
                                    width: 2,
                                  )
                                  : null,
                        ),
                        child: Center(
                          child: AppText(
                            dateInfo['dayNumber'],
                            fontSize: 16,
                            color:
                                isFuture
                                    ? Colors.grey[400]
                                    : (isSelected
                                        ? Colors.white
                                        : Colors.black),
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
