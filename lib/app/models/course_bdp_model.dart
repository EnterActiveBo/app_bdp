import 'package:appbdp/app/common/utils.dart';

class CourseBdpModel {
  num id;
  String title;
  String? detail;
  String? content;
  DateTime startAt;
  DateTime endAt;
  num? hours;
  String? requirements;

  CourseBdpModel({
    required this.id,
    required this.title,
    this.detail,
    this.content,
    required this.startAt,
    required this.endAt,
    this.hours,
    this.requirements,
  });

  factory CourseBdpModel.fromJson(Map<String, dynamic> json) {
    return CourseBdpModel(
      id: json['sec_cursos'],
      title: json['titulo'],
      detail: json['detalle'],
      content: json['contenido'],
      startAt: DateTime.parse(json['fec_inicio']).toLocal(),
      endAt: DateTime.parse(json['fec_final']).toLocal(),
      hours: json['horas'],
      requirements: json['requerimientos'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['sec_cursos'] = id;
    data['titulo'] = title;
    data['detalle'] = detail;
    data['contenido'] = content;
    data['fec_inicio'] = startAt.toString();
    data['fec_final'] = endAt.toString();
    data['horas'] = hours;
    data['requerimientos'] = requirements;
    return data;
  }

  String getDate() {
    return "${dateBdp(startAt)} - ${dateBdp(endAt)} ";
  }
}

class TopicBdpModel {
  num id;
  num courseId;
  String title;
  String? detail;

  TopicBdpModel({
    required this.id,
    required this.courseId,
    required this.title,
    this.detail,
  });

  factory TopicBdpModel.fromJson(Map<String, dynamic> json) {
    return TopicBdpModel(
      id: json['sec_temas'],
      courseId: json['sec_cursos'],
      title: json['titulo'],
      detail: json['detalle'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['sec_temas'] = id;
    data['sec_cursos'] = courseId;
    data['titulo'] = title;
    data['detalle'] = detail;
    return data;
  }
}
