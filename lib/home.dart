import 'package:flutter/material.dart';
import 'package:weatherapp/detailscreen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = false;
  var cityname = " ";
  final _key = GlobalKey<FormState>();

  void buttonpresh() {
    setState(() {
      loading = true;
    });
    final checker = _key.currentState!.validate();
    if (checker) {
      _key.currentState!.save();
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Detailscreen(cityName: cityname)));
          loading = false; // Set loading to false to hide progress indicato
        });
      });
    } else {
      setState(() {
        loading = false; // Set loading to false to hide progress indicato
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("please enter valuue")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 194, 218, 237),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Home",
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
            const SizedBox(
              height: 60,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: const Text(
                "Enter your city name..........",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              margin: const EdgeInsets.all(12),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Enter City name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter correct value';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        cityname = value!;
                      },
                    ),
                    SizedBox(
                      height: 60,
                      width: 150,
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        color: Colors.blue,
                        child: TextButton(
                          onPressed: () {
                            buttonpresh(); // Start loading
                          },
                          child: loading
                              ? const CircularProgressIndicator(
                                  color: Colors.white, // Spinner color
                                )
                              : const Text(
                                  "Search",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
