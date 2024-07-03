import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weatherapp/wdata.dart';

class ApiCall {
  static var _cityname;

  ApiCall(var cityname) {
    _cityname = cityname;
  }

  // Method to construct the API URL dynamically
  String getApiUrl() {
    return 'https://api.openweathermap.org/data/2.5/weather?q=$_cityname&appid=fb283aa515fa911c1185c7fad897a512';
  }

  Future<Maindata> fetchdata() async {
    final response = await http.get(Uri.parse(getApiUrl()));
    if (response.statusCode == 200) {
      return Maindata.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
