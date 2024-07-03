// child: FutureBuilder<Maindata>(
//           future: futuremaindata,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('${snapshot.error}');
//             } else if (snapshot.hasData) {
//               Maindata data = snapshot.data!;
//               addtemp = data.main.temp;
//               addhumidity = data.main.humidity;
//               addid = data.weather[0].id;
//               adddescription = data.weather[0].description;
//               addwindspeed = data.wind.speed;
//               return Text(adddescription);
//             }
//             return const Text('no data found');
//           },
//         ),