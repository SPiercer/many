import 'dart:math';

import 'package:flutter/material.dart';
import 'package:many/many.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String currentValue = 'Hello World';

  void set(String newMany) {
    setState(() => currentValue = newMany + ' ${Random().nextInt(100)}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Many Made with ❤️'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    child: const Text("listen Hourly"),
                    onPressed: () {
                      Many.listenHourly("Hourly", () => set("Hello Hourly"));
                    }),
                ElevatedButton(
                    child: const Text("listen Every 12 Hour"),
                    onPressed: () {
                      Many.listenEvery12Hours(
                          "12 Hour", () => set("Hello 12 Hour"));
                    }),
                ElevatedButton(
                    child: const Text("listen Daily"),
                    onPressed: () {
                      Many.listenDaily("Daily", () => set("Hello Daily"));
                    }),
                ElevatedButton(
                    child: const Text("listen Weekly"),
                    onPressed: () {
                      Many.listenWeekly("Weekly", () => set("Hello Weekly"));
                    }),
                ElevatedButton(
                    child: const Text("listen Monthly"),
                    onPressed: () {
                      Many.listenMonthly<void>(
                          "Monthly", () => set("Hello Monthly"));
                    }),
                ElevatedButton(
                    child: const Text("listen Yearly"),
                    onPressed: () {
                      Many.listenYearly<void>("Yearly", () => set("Hello Yearly"));
                    }),
                ElevatedButton(
                    child: const Text("listen Every 5 Sec"),
                    onPressed: () {
                      Many.listenCustom<void>(
                        "Custom",
                        () => set("Hello Custom"),
                        duration: const Duration(seconds: 5),
                      );
                    }),
                StreamBuilder<Widget?>(
                  stream: Many.listenCustom<Widget?>(
                    "CustomWidget3",
                    () => Text('${Random().nextInt(100)}'),
                    duration: const Duration(seconds: 3),
                  ),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!;
                    } else {
                      return const Text("please come back after 3 seconds");
                    }
                  },
                ),
                const SizedBox(
                  height: 22,
                ),
                Text(
                  currentValue,
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
