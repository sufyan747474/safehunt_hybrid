extension DateTimeExtension on DateTime {
  String toMessageDate() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (now.year == year && now.month == month && now.day == day) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}
