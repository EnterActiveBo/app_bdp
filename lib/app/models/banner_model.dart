import 'package:appbdp/app/common/utils.dart';

class BannerModel {
  String id;
  String title;
  bool button;
  String? buttonTitle;
  String? buttonUrl;
  FileModel image;
  BannerModel({
    required this.id,
    required this.title,
    required this.button,
    this.buttonTitle,
    this.buttonUrl,
    required this.image,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      title: json['title'],
      button: json['button'] == 1,
      buttonTitle: json['buttonTitle'],
      buttonUrl: json['buttonUrl'],
      image: FileModel.fromJson(json['image']),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['button'] = button;
    data['buttonTitle'] = buttonTitle;
    data['buttonUrl'] = buttonUrl;
    data['image'] = image.toJson();
    return data;
  }
}

class FileModel {
  String id;
  String name;
  String originalName;
  String mimeType;
  num size;
  String extension;
  String url;

  FileModel({
    required this.id,
    required this.name,
    required this.originalName,
    required this.mimeType,
    required this.size,
    required this.extension,
    required this.url,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      id: json['id'],
      name: json['name'],
      originalName: json['originalName'],
      mimeType: json['mimeType'],
      size: json['size'],
      extension: json['extension'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['originalName'] = originalName;
    data['mimeType'] = mimeType;
    data['size'] = size;
    data['extension'] = extension;
    data['url'] = url;
    return data;
  }

  bool isImage() {
    return searchString(
      mimeType,
      "image",
    );
  }
}
