import 'package:flutter/material.dart';

void main() {
  var x = 0;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<ScaffoldState> scaffoldky = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldky,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_left)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.topCenter,
              width: double.infinity,
              child: const Text(
                "what is your age? ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                ),
              )),
          Container(
            height: 200,
            alignment: Alignment.topCenter,
            width: double.infinity,
            child: Image.asset(
              fit: BoxFit.cover,
              "img/age.jpg",
              width: 400,
              height: 200,
            ),
          ),
          Container(
              alignment: Alignment.topCenter,
              width: 240,
              height: 60,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 97, 97, 97),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: const TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Your age ",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 245, 244, 244)),
                      suffixText: "Year",
                      suffixStyle: TextStyle(
                          color: Color.fromARGB(255, 255, 254, 254))))),
          Container(
              alignment: Alignment.topCenter,
              width: 290,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 2, 42, 244),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: MaterialButton(
                  minWidth: double.infinity,
                  child: const Text(
                    'Continue',
                    selectionColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {}))
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
    );
  }
}
