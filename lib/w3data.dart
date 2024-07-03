class Main {
  double temp;
  int humidity;
  Main({required this.temp, required this.humidity});
  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(temp: json['temp'].toDouble(), humidity: json['humidity']);
  }
}
