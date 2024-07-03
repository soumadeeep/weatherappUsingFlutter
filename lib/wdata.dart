import 'package:weatherapp/w2data.dart';
import 'package:weatherapp/w3data.dart';
import 'package:weatherapp/w4data.dart';

class Maindata {
  List<Weather> weather;
  Main main;
  Wind wind;
  Maindata({required this.weather, required this.main, required this.wind});
  factory Maindata.fromJson(Map<String, dynamic> json) {
    return Maindata(
        weather:
            (json['weather'] as List).map((i) => Weather.fromJson(i)).toList(),
        main: Main.fromJson(json['main']),
        wind: Wind.fromJson(json['wind']));
  }
}
