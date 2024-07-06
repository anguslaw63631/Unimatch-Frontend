String formatTime(DateTime dateTime) {
  final fixedHour = dateTime.hour < 10 ? "0${dateTime.hour}" : dateTime.hour;
  final fixedMinute = dateTime.minute < 10 ? "0${dateTime.minute}" : dateTime.minute;
  return "${dateTime.day}/${dateTime.month} $fixedHour:$fixedMinute";
}