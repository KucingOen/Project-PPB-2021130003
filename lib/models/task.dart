class Task {
  final String title;
  final String dateReminder;
  final String timeReminder;
  final String note;

  Task({
    required this.title,
    required this.dateReminder,
    required this.timeReminder,
    required this.note,
  });

  // Convert the Task instance to a map (useful for JSON serialization)
  Map<String, dynamic> toMap() {
    return {
      'taskTitle': title,
      'dateReminder': dateReminder,
      'timeReminder': timeReminder,
      'note': note
    };
  }

  // Factory constructor to create an Task from a Firebase snapshot
  factory Task.fromMap(Map<dynamic, dynamic> data) {
    return Task(
      title: data['taskTitle'] ?? '',
      dateReminder: data['dateReminder'] ?? '',
      timeReminder: data['timeReminder'] ?? '',
      note: data['note'] ?? '',
    );
  }
}