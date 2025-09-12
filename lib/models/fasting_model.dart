enum FastingStatus { inProgress, scheduled, completed }

class FastingModel {
  final String id;
  final FastingStatus status;
  final DateTime startTime;
  final DateTime endTime;
  final String actionText;

  FastingModel({
    required this.id,
    required this.status,
    required this.startTime,
    required this.endTime,
    required this.actionText,
  });

  String get statusText {
    switch (status) {
      case FastingStatus.inProgress:
        return 'In progress';
      case FastingStatus.scheduled:
        return 'Scheduled';
      case FastingStatus.completed:
        return 'Completed';
    }
  }

  String get formattedStartTime {
    return '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')} \non ${startTime.day} ${_getMonthName(startTime.month)} ${startTime.year}';
  }

  String get formattedEndTime {
    return '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')} \non ${endTime.day} ${_getMonthName(endTime.month)} ${endTime.year}';
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
}
