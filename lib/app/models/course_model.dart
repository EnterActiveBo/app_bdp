import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/models/banner_model.dart';

class CourseModel {
  String id;
  String title;
  String detail;
  DateTime startAt;
  DateTime endAt;
  String schedule;
  String? gender;
  String? meetingUrl;
  FileModel? image;
  TargetModel? department;
  TargetModel? province;
  TargetModel? municipality;
  TargetModel? locality;
  TargetModel? group;
  List<TargetModel> economicActivities;

  CourseModel({
    required this.id,
    required this.title,
    required this.detail,
    required this.startAt,
    required this.endAt,
    required this.schedule,
    this.gender,
    this.meetingUrl,
    this.image,
    this.department,
    this.province,
    this.municipality,
    this.locality,
    this.group,
    required this.economicActivities,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      title: json['title'],
      detail: json['detail'],
      startAt: DateTime.parse(json['startAt']).toLocal(),
      endAt: DateTime.parse(json['endAt']).toLocal(),
      schedule: json['schedule'],
      gender: json['gender'],
      meetingUrl: json['meetingUrl'],
      image: json['image'] != null ? FileModel.fromJson(json['image']) : null,
      department: json['department'] != null
          ? TargetModel.fromJson(json['department'])
          : null,
      province: json['province'] != null
          ? TargetModel.fromJson(json['province'])
          : null,
      municipality: json['municipality'] != null
          ? TargetModel.fromJson(json['municipality'])
          : null,
      locality: json['locality'] != null
          ? TargetModel.fromJson(json['locality'])
          : null,
      group: json['group'] != null ? TargetModel.fromJson(json['group']) : null,
      economicActivities: json['economicActivities'] != null
          ? List<TargetModel>.from(
              json['economicActivities'].map(
                (item) {
                  return TargetModel.fromJson(item);
                },
              ).toList(),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['detail'] = detail;
    data['startAt'] = startAt.toString();
    data['endAt'] = endAt.toString();
    data['schedule'] = schedule;
    data['gender'] = gender;
    data['meetingUrl'] = meetingUrl;
    data['image'] = image?.toJson();
    data['department'] = department?.toJson();
    data['province'] = province?.toJson();
    data['municipality'] = municipality?.toJson();
    data['locality'] = locality?.toJson();
    data['group'] = group?.toJson();
    data['economicActivities'] = economicActivities
        .map(
          (x) => x.toJson(),
        )
        .toList();
    return data;
  }

  String getDate() {
    return "${dateBdp(startAt)} - ${dateBdp(endAt)} ";
  }

  String getAttrs() {
    List<String> attrs = [];
    attrs.addAll(
      economicActivities.map((x) => x.name),
    );
    if (department is TargetModel) {
      attrs.add(department!.name);
    }
    if (gender is String) {
      attrs.add(gender == 'male' ? 'Hombres' : 'Mujeres');
    }
    if (attrs.isNotEmpty) {
      return attrs.join(" | ");
    }
    return "Abierto a todos los clientes";
  }
}

class TargetModel {
  String id;
  String name;

  TargetModel({
    required this.id,
    required this.name,
  });

  factory TargetModel.fromJson(Map<String, dynamic> json) {
    return TargetModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
