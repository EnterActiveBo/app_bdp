import 'package:appbdp/app/models/banner_model.dart';

class NotificationModel {
  String id;
  String title;
  String? detail;
  bool button;
  String? buttonTitle;
  String? buttonUrl;
  DateTime startAt;
  DateTime endAt;
  bool view;
  FileModel image;

  NotificationModel({
    required this.id,
    required this.title,
    this.detail,
    required this.button,
    this.buttonTitle,
    this.buttonUrl,
    required this.startAt,
    required this.endAt,
    required this.view,
    required this.image,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      detail: json['detail'],
      button: json['button'] == 1,
      buttonTitle: json['buttonTitle'],
      buttonUrl: json['buttonUrl'],
      startAt: DateTime.parse(json['startAt']).toLocal(),
      endAt: DateTime.parse(json['endAt']).toLocal(),
      view: json['meta']['users_count'] == 1,
      image: FileModel.fromJson(json['image']),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['detail'] = detail;
    data['button'] = button ? 1 : 0;
    data['buttonTitle'] = buttonTitle;
    data['buttonUrl'] = buttonUrl;
    data['startAt'] = startAt.toString();
    data['endAt'] = endAt.toString();
    final meta = <String, dynamic>{};
    meta['users_count'] = view ? 1 : 0;
    data['meta'] = meta;
    data['image'] = image.toJson();
    return data;
  }
}
