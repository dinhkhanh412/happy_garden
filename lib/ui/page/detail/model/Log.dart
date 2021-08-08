class Log {
  final String text;
  final String time;

  const Log({
    this.text,
    this.time,
  });

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(text: json['text'] as String, time: json['time'] as String);
  }
}
