import 'package:flutter/material.dart';
import 'package:focofit/constants/colors.dart';
import 'package:focofit/views/pages/fasting/fasting_progress_page.dart';
import 'package:focofit/views/widgets/app_button.dart';
import 'package:focofit/views/widgets/header_container.dart';
import 'package:focofit/views/widgets/text.dart';
import 'package:get/get.dart';

class FastingPlansPage extends StatefulWidget {
  const FastingPlansPage({super.key});

  @override
  State<FastingPlansPage> createState() => _FastingPlansPageState();
}

class _FastingPlansPageState extends State<FastingPlansPage> {
  int? selectedPlanIndex;
  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
  DateTime currentMonth = DateTime.now();

  final List<Map<String, dynamic>> fastingPlans = [
    {'fasting': 12, 'eating': 12, 'fastingHours': 12, 'eatingHours': 12},
    {'fasting': 16, 'eating': 8, 'fastingHours': 16, 'eatingHours': 8},
    {'fasting': 18, 'eating': 6, 'fastingHours': 18, 'eatingHours': 6},
    {'fasting': 10, 'eating': 14, 'fastingHours': 10, 'eatingHours': 14},
    {'fasting': 8, 'eating': 16, 'fastingHours': 8, 'eatingHours': 16},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: AppColor.textColor),
      //     onPressed: () => Get.back(),
      //   ),
      //   centerTitle: true,
      //   title: const AppText(
      //     'Fasting plans',
      //     fontSize: 20,
      //     fontWeight: FontWeight.bold,
      //     color: AppColor.textColor,
      //   ),
      // ),
      body: Column(
        children: [
          HeaderContainer(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Image.asset(
                      'assets/icons/Back.png',
                      height: 39,
                      width: 39,
                    ),
                  ),
                  Center(
                    child: AppText(
                      'Fasting plan',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textColor,
                    ),
                  ),
                  Image.asset(
                    'assets/icons/Back.png',
                    height: 39,
                    width: 39,
                    color: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Fasting plans list
          Expanded(
            child: ListView.builder(
              itemCount: fastingPlans.length,
              itemBuilder: (context, index) {
                final plan = fastingPlans[index];
                final isSelected = selectedPlanIndex == index;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPlanIndex = index;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border:
                            isSelected
                                ? Border.all(
                                  color: AppColor.primaryColor,
                                  width: 2,
                                )
                                : Border.all(color: Color(0xffD2D2D2)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            // Fasting hours display
                            Text(
                              '${plan['fasting']} - ${plan['eating']}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColor.textColor,
                              ),
                            ),
                            const SizedBox(width: 20),
                            // Vertical divider
                            Container(
                              width: 1,
                              height: 50,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(width: 20),
                            // Plan details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time,
                                        color: AppColor.primaryColor,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${plan['fastingHours']} hours fasting',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColor.textColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Image.asset('assets/icons/eat.png'),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${plan['eatingHours']} hours eating',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColor.textColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // Confirm selection button
          AppButton(
            label: 'Confirm selection',
            bgColor:
                selectedPlanIndex != null
                    ? AppColor.primaryColor
                    : Colors.grey[400],
            txtClr: Colors.white,
            ontap: selectedPlanIndex != null ? _showStartScheduleDialog : null,
            height: 56,

            isElevation: false,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  void _showStartScheduleDialog() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Title
              const Text(
                'When do you want to start?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 16),
              // Description
              const Text(
                'Do you want to start now or would you prefer to schedule the start of the fast for later?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
              ),
              const SizedBox(height: 24),
              // Start button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.back();

                    // Calculate start and end times based on selected plan
                    final now = DateTime.now();
                    final selectedPlan = fastingPlans[selectedPlanIndex!];
                    final startTime = now;
                    final endTime = now.add(
                      Duration(hours: selectedPlan['fastingHours']),
                    );

                    // Navigate to fasting progress page
                    Get.to(
                      () => FastingProgressPage(
                        fastingHours: selectedPlan['fastingHours'],
                        eatingHours: selectedPlan['eatingHours'],
                        startTime: startTime,
                        endTime: endTime,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9900),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Start',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Schedule button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () {
                    Get.back();
                    _showTimePickerDialog();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF333333),
                    side: const BorderSide(color: Colors.black, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    'Schedule',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showTimePickerDialog() {
    TimeOfDay selectedTime = const TimeOfDay(hour: 12, minute: 59);

    // Force rebuild of the widget to get latest selectedDate
    setState(() {});

    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, timeSetState) {
          // Update the time picker state when selectedDate changes
          WidgetsBinding.instance.addPostFrameCallback((_) {
            timeSetState(() {});
          });
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Color(0xffD2D2D2),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Title
                  const Text(
                    'Choose your time',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Divider
                  Container(height: 1, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  // Description
                  const Text(
                    'Choose the best time to start your fast',
                    style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
                  ),
                  const SizedBox(height: 24),
                  // Time picker
                  Container(
                    height: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Hours picker
                        Expanded(
                          child: ListWheelScrollView(
                            itemExtent: 50,
                            diameterRatio: 1.5,
                            physics: const FixedExtentScrollPhysics(),
                            controller: FixedExtentScrollController(
                              initialItem: selectedTime.hour,
                            ),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedTime = TimeOfDay(
                                  hour: index,
                                  minute: selectedTime.minute,
                                );
                              });
                            },
                            children: List.generate(24, (index) {
                              final hour = index;
                              final isSelected = hour == selectedTime.hour;
                              return Center(
                                child: Text(
                                  hour.toString().padLeft(2, '0'),
                                  style: TextStyle(
                                    fontSize: isSelected ? 24 : 18,
                                    fontWeight:
                                        isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                    color:
                                        isSelected
                                            ? AppColor.primaryColor
                                            : Colors.grey[600],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        // Colon separator
                        const Text(
                          ' : ',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Minutes picker
                        Expanded(
                          child: ListWheelScrollView(
                            itemExtent: 50,
                            diameterRatio: 1.5,
                            physics: const FixedExtentScrollPhysics(),
                            controller: FixedExtentScrollController(
                              initialItem: selectedTime.minute,
                            ),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedTime = TimeOfDay(
                                  hour: selectedTime.hour,
                                  minute: index,
                                );
                              });
                            },
                            children: List.generate(60, (index) {
                              final minute = index;
                              final isSelected = minute == selectedTime.minute;
                              return Center(
                                child: Text(
                                  minute.toString().padLeft(2, '0'),
                                  style: TextStyle(
                                    fontSize: isSelected ? 24 : 18,
                                    fontWeight:
                                        isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                    color:
                                        isSelected
                                            ? AppColor.primaryColor
                                            : Colors.grey[600],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Date selector
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'On ${selectedDate.day}${_getDaySuffix(selectedDate.day)} ${_getMonthName(selectedDate.month)} ${selectedDate.year}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF333333),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            _showDatePickerDialog();
                            // Reopen time picker with updated date
                          },
                          child: const Text(
                            'Change',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFFF9900),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Confirm button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        _showScheduledConfirmationDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9900),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
      isScrollControlled: true,
    );
  }

  void _showDatePickerDialog() {
    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {});
          });
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Color(0xffd2d2d2),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Title
                  const Text(
                    'Choose the date',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Calendar
                  Container(height: 350, child: _buildCustomCalendar()),
                  const SizedBox(height: 24),
                  // Confirm button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        _showTimePickerDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9900),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
      isScrollControlled: true,
    );
  }

  void _showScheduledConfirmationDialog() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Title
              const Text(
                'Scheduled fasting',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 24),
              // Success icon
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 24),
              // Message
              const Text(
                'You will be notified when the fasting time is approaching',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
              ),
              const SizedBox(height: 24),
              // Confirm button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.back();
                    Get.snackbar(
                      'Fast Scheduled',
                      'Your fast has been scheduled successfully!',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9900),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  Widget _buildCustomCalendar() {
    DateTime firstDayOfMonth = DateTime(
      currentMonth.year,
      currentMonth.month,
      1,
    );
    DateTime lastDayOfMonth = DateTime(
      currentMonth.year,
      currentMonth.month + 1,
      0,
    );
    int daysInMonth = lastDayOfMonth.day;
    int firstWeekday = firstDayOfMonth.weekday;

    return Column(
      children: [
        // Month navigation
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  currentMonth = DateTime(
                    currentMonth.year,
                    currentMonth.month - 1,
                    1,
                  );
                });
              },
              icon: const Icon(Icons.chevron_left, color: Color(0xFF333333)),
            ),
            Text(
              '${_getMonthName(currentMonth.month)} ${currentMonth.year}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentMonth = DateTime(
                    currentMonth.year,
                    currentMonth.month + 1,
                    1,
                  );
                });
              },
              icon: const Icon(Icons.chevron_right, color: Color(0xFF333333)),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Days of week header
        Row(
          children:
              ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT']
                  .map(
                    (day) => Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
        const SizedBox(height: 16),
        // Calendar grid
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: 42, // 6 weeks * 7 days
            itemBuilder: (context, index) {
              int dayNumber = index - firstWeekday + 1;
              bool isCurrentMonth = dayNumber > 0 && dayNumber <= daysInMonth;
              bool isSelected =
                  isCurrentMonth &&
                  dayNumber == selectedDate.day &&
                  selectedDate.month == currentMonth.month &&
                  selectedDate.year == currentMonth.year;
              bool isToday =
                  isCurrentMonth &&
                  dayNumber == DateTime.now().day &&
                  currentMonth.month == DateTime.now().month &&
                  currentMonth.year == DateTime.now().year;

              if (dayNumber <= 0 || dayNumber > daysInMonth) {
                return Container(); // Empty space for previous/next month days
              }

              return GestureDetector(
                onTap: () {
                  print(
                    'Selected date: $dayNumber/${currentMonth.month}/${currentMonth.year}',
                  );
                  setState(() {
                    selectedDate = DateTime(
                      currentMonth.year,
                      currentMonth.month,
                      dayNumber,
                    );
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color:
                        isSelected ? AppColor.primaryColor : Colors.transparent,
                    shape: BoxShape.circle,
                    border:
                        isToday && !isSelected
                            ? Border.all(color: AppColor.primaryColor, width: 2)
                            : null,
                  ),
                  child: Center(
                    child: Text(
                      dayNumber.toString(),
                      style: TextStyle(
                        fontSize: isSelected ? 18 : 16,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color:
                            isSelected
                                ? Colors.white
                                : isToday
                                ? AppColor.primaryColor
                                : const Color(0xFF333333),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
