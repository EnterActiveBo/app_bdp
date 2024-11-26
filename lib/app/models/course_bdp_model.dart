import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/constants/api.const.dart';

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

class ModuleBdpModel {
  num id;
  num topicId;
  String title;
  String type;
  String? detail;
  String? file;

  ModuleBdpModel({
    required this.id,
    required this.topicId,
    required this.title,
    required this.type,
    this.detail,
    this.file,
  });

  factory ModuleBdpModel.fromJson(Map<String, dynamic> json) {
    return ModuleBdpModel(
      id: json['sec_recursos'],
      topicId: json['sec_temas'],
      title: json['titulo'],
      type: json['tipo_archivo'],
      detail: json['detalle'],
      file: json['archivo'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['sec_recursos'] = id;
    data['sec_temas'] = topicId;
    data['titulo'] = title;
    data['tipo_archivo'] = type;
    data['detalle'] = detail;
    data['archivo'] = file;
    return data;
  }

  String getUrl() {
    return "${urlV1}courses-aula/$file/get-resources";
  }

  String getType() {
    String result = "documento";
    switch (type) {
      case "2":
        result = "video";
        break;
      case "3":
        result = "imagen";
        break;
      case "4":
        result = "audio";
        break;
      default:
    }
    return result;
  }
}
