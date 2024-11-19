import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/course_model.dart';

class SupplierModel {
  String id;
  String title;
  String? detail;
  FileModel? image;
  TargetModel? group;
  List<TargetModel> economicActivities;
  List<TechnologyModel> technologies;
  List<OfficeModel> offices;

  SupplierModel({
    required this.id,
    required this.title,
    this.detail,
    this.image,
    this.group,
    required this.economicActivities,
    required this.technologies,
    required this.offices,
  });

  factory SupplierModel.fromJson(Map<String, dynamic> json) {
    return SupplierModel(
      id: json['id'],
      title: json['title'],
      detail: json['detail'],
      image: json['image'] != null ? FileModel.fromJson(json['image']) : null,
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
      technologies: json['technologies'] != null
          ? List<TechnologyModel>.from(
              json['technologies'].map(
                (item) {
                  return TechnologyModel.fromJson(item);
                },
              ).toList(),
            )
          : [],
      offices: json['offices'] != null
          ? List<OfficeModel>.from(
              json['offices'].map(
                (item) {
                  return OfficeModel.fromJson(item);
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
    data['image'] = image?.toJson();
    data['group'] = group?.toJson();
    data['economicActivities'] = economicActivities
        .map(
          (x) => x.toJson(),
        )
        .toList();
    data['technologies'] = technologies
        .map(
          (x) => x.toJson(),
        )
        .toList();
    data['offices'] = offices
        .map(
          (x) => x.toJson(),
        )
        .toList();
    return data;
  }

  bool haveTechnology(TechnologyModel item) {
    return technologies.any((element) => element.id == item.id);
  }
}

class TechnologyModel {
  String id;
  String title;
  String? detail;
  FileModel? image;

  TechnologyModel({
    required this.id,
    required this.title,
    this.detail,
    this.image,
  });

  factory TechnologyModel.fromJson(Map<String, dynamic> json) {
    return TechnologyModel(
      id: json['id'],
      title: json['title'],
      detail: json['detail'],
      image: json['image'] != null ? FileModel.fromJson(json['image']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['detail'] = detail;
    data['image'] = image?.toJson();
    return data;
  }

  String getTitleTruncated({
    int? max,
  }) {
    int maxLength = max ?? 15;
    if (title.length > maxLength) {
      return "${title.substring(0, maxLength)}...";
    }
    return title;
  }
}

class OfficeModel {
  String id;
  String title;
  bool head;
  String address;
  String? mapUrl;
  String? webUrl;
  List<OfficePhoneModel> phones;
  List<OfficeEmailModel> emails;
  List<OfficeScheduleModel> schedules;
  TargetModel? department;
  TargetModel? province;
  TargetModel? municipality;

  OfficeModel({
    required this.id,
    required this.title,
    required this.head,
    required this.address,
    this.mapUrl,
    this.webUrl,
    required this.phones,
    required this.emails,
    required this.schedules,
    this.department,
    this.province,
    this.municipality,
  });

  factory OfficeModel.fromJson(Map<String, dynamic> json) {
    return OfficeModel(
      id: json['id'],
      title: json['title'],
      head: json['head'] == 1,
      address: json['address'],
      mapUrl: json['mapUrl'],
      webUrl: json['webUrl'],
      phones: json['phones'] != null
          ? List<OfficePhoneModel>.from(
              json['phones'].map(
                (item) {
                  return OfficePhoneModel.fromJson(item);
                },
              ).toList(),
            )
          : [],
      emails: json['emails'] != null
          ? List<OfficeEmailModel>.from(
              json['emails'].map(
                (item) {
                  return OfficeEmailModel.fromJson(item);
                },
              ).toList(),
            )
          : [],
      schedules: json['schedules'] != null
          ? List<OfficeScheduleModel>.from(
              json['schedules'].map(
                (item) {
                  return OfficeScheduleModel.fromJson(item);
                },
              ).toList(),
            )
          : [],
      department: json['department'] != null
          ? TargetModel.fromJson(json['department'])
          : null,
      province: json['province'] != null
          ? TargetModel.fromJson(json['province'])
          : null,
      municipality: json['municipality'] != null
          ? TargetModel.fromJson(json['municipality'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['head'] = head ? 1 : 0;
    data['address'] = address;
    data['mapUrl'] = mapUrl;
    data['webUrl'] = webUrl;
    data['phones'] = phones
        .map(
          (x) => x.toJson(),
        )
        .toList();
    data['emails'] = emails
        .map(
          (x) => x.toJson(),
        )
        .toList();
    data['schedules'] = schedules
        .map(
          (x) => x.toJson(),
        )
        .toList();
    data['department'] = department?.toJson();
    data['province'] = province?.toJson();
    data['municipality'] = municipality?.toJson();
    return data;
  }
}

class OfficePhoneModel {
  String phone;
  String? detail;

  OfficePhoneModel({
    required this.phone,
    this.detail,
  });

  factory OfficePhoneModel.fromJson(Map<String, dynamic> json) {
    return OfficePhoneModel(
      phone: json['phone'],
      detail: json['detail'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['phone'] = phone;
    data['detail'] = detail;
    return data;
  }
}

class OfficeEmailModel {
  String email;
  String? detail;

  OfficeEmailModel({
    required this.email,
    this.detail,
  });

  factory OfficeEmailModel.fromJson(Map<String, dynamic> json) {
    return OfficeEmailModel(
      email: json['email'],
      detail: json['detail'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['detail'] = detail;
    return data;
  }
}

class OfficeScheduleModel {
  String schedule;
  String? detail;

  OfficeScheduleModel({
    required this.schedule,
    this.detail,
  });

  factory OfficeScheduleModel.fromJson(Map<String, dynamic> json) {
    return OfficeScheduleModel(
      schedule: json['schedule'],
      detail: json['detail'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['schedule'] = schedule;
    data['detail'] = detail;
    return data;
  }
}
