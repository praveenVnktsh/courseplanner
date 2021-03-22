import 'dart:convert';

import 'package:flutter/material.dart';

class CourseModel {
  String name;
  String code;
  List<MarkModel> marks;
  String grade;
  List<String> buckets;
  int credits;
  double totalScore;
  CourseModel(
      {this.name,
      this.code,
      this.marks,
      this.grade,
      this.buckets,
      this.credits});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
      'marks': marks?.map((x) => x.toMap())?.toList(),
      'grade': grade,
      'buckets': buckets,
      'credits': credits,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      name: map['name'],
      code: map['code'],
      credits: map['credits'],
      marks:
          List<MarkModel>.from(map['marks']?.map((x) => MarkModel.fromMap(x))),
      grade: map['grade'],
      buckets: List<String>.from(map['buckets']),
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
  double netScore;
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

  DataRow getRow() {
    this.netScore = score * weight / (total);
    return DataRow(cells: [
      DataCell(Text(name)),
      DataCell(Text(score.toString())),
      DataCell(Text(total.toString())),
      DataCell(Text(weight.toString())),
      DataCell(Text(netScore.toString())),
    ]);
  }
}
