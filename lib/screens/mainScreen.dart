import 'package:courseplanner/data/courseModel.dart';
import 'package:courseplanner/data/globals.dart';
import 'package:courseplanner/screens/viewCourse.dart';
import 'package:courseplanner/utils/sheets.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course Planner"),
      ),
      body: Center(
          child: ListView.builder(
        itemBuilder: (context, index) {
          Widget widget = Container(
            height: 150,
            width: 150,
            child: Card(
                color: Colors.black.withAlpha(10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewCourse(
                                courseIndex: index,
                              )),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.courses[index].name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(data.courses[index].code),
                      ],
                    ),
                  ),
                )),
          );
          return Draggable(
            childWhenDragging: Container(),
            feedback: widget,
            child: widget,
          );
        },
        itemCount: data.courses.length,
      )),
    );
  }
}
