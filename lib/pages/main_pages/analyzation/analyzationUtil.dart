bool isDateInRange(DateTime target, DateTime startDate, DateTime endDate) {
  startDate = startDate.subtract(const Duration(hours: 0, minutes: 0, seconds: 0));
  endDate = endDate.subtract(const Duration(hours: 0, minutes: 0, seconds: 0));
  return (!target.isBefore(startDate)) && target.isBefore(endDate.add(const Duration(days: 1)));
}