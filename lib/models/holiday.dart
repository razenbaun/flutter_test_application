class Holiday {
  final String date;
  final String text;

  Holiday({required this.date, required this.text});

  factory Holiday.fromJson(Map<String, dynamic> json) {
    return Holiday(
      date: json['date_gregorian'],
      text: json['text'],
    );
  }

  DateTime get dateTime => DateTime.parse(date);
}
