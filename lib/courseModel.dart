import 'dart:convert';

class CourseModel {
  String name;
  String code;
  List<MarkModel> marks;
  String grade;
  CourseModel({this.name, this.code, this.marks, this.grade});
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
      'marks': marks?.map((x) => x.toMap())?.toList(),
      'grade': grade,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      name: map['name'],
      code: map['code'],
      marks:
          List<MarkModel>.from(map['marks']?.map((x) => MarkModel.fromMap(x))),
      grade: map['grade'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String source) =>
      CourseModel.fromMap(json.decode(source));
}

class MarkModel {
  String name;
  double score;
  double weight;
  double total;
  MarkModel({this.name, this.score, this.weight, this.total});
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'score': score,
      'weight': weight,
      'total': total,
    };
  }

  factory MarkModel.fromMap(Map<String, dynamic> map) {
    return MarkModel(
      name: map['name'],
      score: map['score'],
      weight: map['weight'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MarkModel.fromJson(String source) =>
      MarkModel.fromMap(json.decode(source));
}
