class Marker {
  final double posX;
  final double posY;
  final String title;
  final DateTime time;

  Marker({
    this.posX,
    this.posY,
    this.title,
    this.time
  });

  factory Marker.fromJson(Map<String, dynamic> json) {
    return Marker(
      posX: json['posX'],
      posY: json['posY'],
      time: DateTime.parse(json['time']),
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() => {
      'title': this.title,
      'time': this.time.toIso8601String(),
      'posX': this.posX,
      "posY": this.posY
    };
  
}