import 'package:appbdp/app/models/banner_model.dart';
import 'package:get/get.dart';

class PathologyModel {
  String id;
  String title;
  String problem;
  String information;
  String handling;
  List<TagPathologyModel> tags;
  List<ResourcePathologyModel> resources;

  PathologyModel({
    required this.id,
    required this.title,
    required this.problem,
    required this.information,
    required this.handling,
    required this.tags,
    required this.resources,
  });

  factory PathologyModel.fromJson(Map<String, dynamic> json) {
    return PathologyModel(
      id: json['id'],
      title: json['title'],
      problem: json['problem'],
      information: json['information'],
      handling: json['handling'],
      tags: json['tags'] != null
          ? List<TagPathologyModel>.from(
              json['tags'].map(
                (item) {
                  return TagPathologyModel.fromJson(item);
                },
              ).toList(),
            )
          : [],
      resources: json['resources'] != null
          ? List<ResourcePathologyModel>.from(
              json['resources'].map(
                (item) {
                  return ResourcePathologyModel.fromJson(item);
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
    data['problem'] = problem;
    data['information'] = information;
    data['handling'] = handling;
    data['tags'] = tags.map((i) => i.toJson()).toList();
    data['resources'] = resources.map((i) => i.toJson()).toList();
    return data;
  }

  ResourcePathologyModel? getImageFeatured() {
    return resources.firstWhereOrNull((resource) => resource.type == "image");
  }

  List<ResourcePathologyModel> getResourcesByType(String type) {
    return resources.where((resource) => resource.type == type).toList();
  }

  String? getTagsString() {
    if (tags.isEmpty) {
      return null;
    }
    return tags.map((tag) => tag.title).join(" | ");
  }
}

class TagPathologyModel {
  String id;
  String title;

  TagPathologyModel({
    required this.id,
    required this.title,
  });

  factory TagPathologyModel.fromJson(Map<String, dynamic> json) {
    return TagPathologyModel(
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}

class ResourcePathologyModel {
  String id;
  String title;
  String type;
  FileModel source;
  FileModel? preview;

  ResourcePathologyModel({
    required this.id,
    required this.title,
    required this.type,
    required this.source,
    this.preview,
  });

  factory ResourcePathologyModel.fromJson(Map<String, dynamic> json) {
    return ResourcePathologyModel(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      source: FileModel.fromJson(json['source']),
      preview:
          json['preview'] != null ? FileModel.fromJson(json['preview']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['type'] = type;
    data['source'] = source.toJson();
    data['preview'] = preview?.toJson();
    return data;
  }
}
