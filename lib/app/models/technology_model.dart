import 'package:appbdp/app/models/banner_model.dart';

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
}
