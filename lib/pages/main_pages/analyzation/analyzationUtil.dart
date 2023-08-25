bool isDateInRange(DateTime target, DateTime startDate, DateTime endDate) {
  return target.isAfter(startDate) && target.isBefore(endDate);
}