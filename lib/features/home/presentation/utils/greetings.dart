String getGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 10) {
    return 'Chào buổi sáng';
  } else if (hour < 14) {
    return 'Chào buổi trưa';
  } else if (hour < 18) {
    return 'Chào buổi chiều';
  } else {
    return 'Chào buổi tối';
  }
}