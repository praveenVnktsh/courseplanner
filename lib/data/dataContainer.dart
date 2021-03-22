import 'package:courseplanner/data/courseModel.dart';
import 'package:courseplanner/utils/sheets.dart';

class Data {
  GSheet sheet = GSheet('1mg3OSXnyaIjBxnVJeKddrFK3yzAeZ9L6uZ67JmolHNU');
  List<CourseModel> courses = [];
  bool loaded = false;
  Future loadCourses() async {
    await sheet.getDataOnline('marks!A:A').then((value) {
      value.removeAt(0);
      value.forEach((element) {
        courses.add(CourseModel.fromJson(element[0]));
      });
      print(value);
      return;
    });
  }

  Data() {}
}
