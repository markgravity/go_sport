import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('dd/MM/yyyy HH:mm');
    return formatter.format(dateTime);
  }

  static String formatDate(DateTime dateTime) {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }

  static String formatTime(DateTime dateTime) {
    final formatter = DateFormat('HH:mm');
    return formatter.format(dateTime);
  }

  static String formatRelative(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} phút trước';
    } else {
      return 'Vừa xong';
    }
  }

  static String formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays} ngày';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} giờ';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes} phút';
    } else {
      return '${duration.inSeconds} giây';
    }
  }

  static String formatVietnameseDate(DateTime dateTime) {
    final formatter = DateFormat('dd \'tháng\' MM, yyyy');
    return formatter.format(dateTime);
  }

  static String formatShortDate(DateTime dateTime) {
    final formatter = DateFormat('dd/MM');
    return formatter.format(dateTime);
  }

  static String formatMonthYear(DateTime dateTime) {
    final formatter = DateFormat('MM/yyyy');
    return formatter.format(dateTime);
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static bool isToday(DateTime date) {
    return isSameDay(date, DateTime.now());
  }

  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return isSameDay(date, yesterday);
  }

  static String formatSmartDate(DateTime dateTime) {
    if (isToday(dateTime)) {
      return 'Hôm nay ${formatTime(dateTime)}';
    } else if (isYesterday(dateTime)) {
      return 'Hôm qua ${formatTime(dateTime)}';
    } else if (DateTime.now().difference(dateTime).inDays < 7) {
      return formatRelative(dateTime);
    } else {
      return formatDate(dateTime);
    }
  }
}