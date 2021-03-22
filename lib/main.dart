import 'package:courseplanner/screens/mainScreen.dart';
import 'package:flutter/material.dart';

import 'data/dataContainer.dart';
import 'data/globals.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  data = Data();
  data.loadCourses().then((f) {
    print(f);
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Planner',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(),
    );
  }
}
