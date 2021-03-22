import 'package:courseplanner/data/courseModel.dart';
import 'package:courseplanner/data/globals.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ViewCourse extends StatefulWidget {
  ViewCourse({this.courseIndex});
  int courseIndex;
  @override
  ViewCourseState createState() => ViewCourseState();
}

class ViewCourseState extends State<ViewCourse> {
  int index;
  List<Widget> columnList = [];
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  void initState() {
    super.initState();
    index = widget.courseIndex;
    List<DataRow> tableRows = [];
    double totalScore = 0.0;
    List<FlSpot> markspots = [];
    double tempIndex = 1;
    data.courses[index].marks.forEach((MarkModel mark) {
      tableRows.add(mark.getRow());
      totalScore += mark.netScore;
      markspots.add(FlSpot(tempIndex, mark.score * 100 / mark.total));
      tempIndex += 1;
    });
    data.courses[index].totalScore = totalScore;
    tableRows.add(DataRow(cells: [
      DataCell(Text(
        'Total = ',
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      DataCell(Text('')),
      DataCell(Text('')),
      DataCell(Text('')),
      DataCell(Text(totalScore.toString())),
    ]));
    DataTable table = DataTable(
      rows: tableRows,
      columns: [
        DataColumn(
            label: Text(
          'Assessment Name',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        DataColumn(
            label: Text(
          'Your Score',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        DataColumn(
            label: Text(
          'Total Marks',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        DataColumn(
            label: Text(
          'Weightage',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        DataColumn(
            label: Text(
          'Net Score',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ],
    );

    LineChart chart = LineChart(
      LineChartData(
          minY: 0,
          maxY: 100,
          gridData: FlGridData(
            show: false,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: const Color(0xff37434d),
                strokeWidth: 1,
              );
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: const Color(0xff37434d),
                strokeWidth: 1,
              );
            },
          ),
          borderData: FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xff37434d), width: 1)),
          lineBarsData: [
            LineChartBarData(
              spots: markspots,
              isCurved: true,
              colors: gradientColors,
              barWidth: 5,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                show: true,
                colors: gradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ),
            )
          ]),
    );
    columnList = [
      Text(
        data.courses[index].name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
      SizedBox(height: 7),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            data.courses[index].code,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black.withAlpha(120)),
          ),
          Text(
            ' - ' + data.courses[index].credits.toString() + ' credits',
            style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.black.withAlpha(120)),
          ),
        ],
      ),
      SizedBox(height: 15),
      Text(
        "Your scores",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 7),
      table,
      Text(
        "Percentage vs Time",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 30),
      Container(height: 300, width: 600, child: chart)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course Planner"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: columnList),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("My title"),
                content: Text("This is my message."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK")),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
