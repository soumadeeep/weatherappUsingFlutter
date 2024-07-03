import 'package:flutter/material.dart';
import 'package:weatherapp/apicall.dart'; // Ensure this file exists and is properly imported
import 'package:weatherapp/wdata.dart'; // Ensure this file exists and is properly imported

class Detailscreen extends StatefulWidget {
  final String cityName;

  const Detailscreen({Key? key, required this.cityName}) : super(key: key);

  @override
  State<Detailscreen> createState() => _DetailscreenState();
}

class _DetailscreenState extends State<Detailscreen> {
  List<String> imagedata = [
    "assets/cloudy.png",
    "assets/cloudy_rain.png",
    "assets/raining.png",
    "assets/snowflake.png",
    "assets/storm.png",
    "assets/sun1.png",
    "assets/thunderstorm.png"
  ];
  int index = 0;
  late Future<Maindata> futuremaindata;

  @override
  void initState() {
    super.initState();
    futuremaindata = ApiCall(widget.cityName).fetchdata();
  }

  double addtemp = 0;
  int addhumidity = 0;
  int addid = 0;
  String adddescription = "";
  String addmain = "";
  double addwindspeed = 0;

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 12, 12, 12)),
        title: const Text(
          "Report",
          style: TextStyle(
            fontSize: 23,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.only(top: screensize.height * 0.1),
                child: Image.asset(
                  "assets/weather_location_icon.png",
                  height: 70,
                  width: 70,
                ),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.only(top: screensize.height * 0),
                child: Text(
                  widget.cityName.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: FutureBuilder<Maindata>(
                future: futuremaindata,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      color: Colors.white,
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    Maindata data = snapshot.data!;
                    addtemp = data.main.temp;
                    addhumidity = data.main.humidity;
                    addid = data.weather[0].id;
                    addmain = data.weather[0].main;
                    adddescription = data.weather[0].description;
                    addwindspeed = data.wind.speed;
                    if (addid >= 0 && addid < 300) {
                      index = 6;
                    } else if (addid >= 300 && addid < 500) {
                      index = 1;
                    } else if (addid >= 500 && addid < 600) {
                      index = 2;
                    } else if (addid >= 600 && addid < 701) {
                      index = 3;
                    } else if (addid == 800) {
                      index = 5;
                    } else if (addid >= 801 && addid <= 804) {
                      index = 0;
                    } else {
                      index = 0;
                    }

                    return Column(
                      children: [
                        Card(
                          color: const Color.fromRGBO(225, 231, 235, 1),
                          shadowColor: const Color.fromRGBO(4, 28, 72, 1),
                          elevation: 15,
                          margin: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  height: 100,
                                  width: screensize.width * 0.4,
                                  child: Image.asset(imagedata[index]),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: SizedBox(
                                  height: 75,
                                  width: screensize.width * 0.29,
                                  child: Text(
                                    '${(addtemp - 273.15).toInt()}°C',
                                    style: const TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 50),
                                  height: 50,
                                  width: screensize.width,
                                  child: Text(
                                    'Condition: $addmain',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 50),
                                  height: 50,
                                  width: screensize.width,
                                  child: Text(
                                    'Description: $adddescription',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 50),
                                  height: 50,
                                  width: screensize.width,
                                  child: Text(
                                    'Humidity: $addhumidity%',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 50),
                                  height: 60,
                                  width: screensize.width,
                                  child: Text(
                                    'Windspeed: ${addwindspeed} Km/h',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return const Text('No data found');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
