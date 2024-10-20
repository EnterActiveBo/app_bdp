import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/course_model.dart';

class ResourceModel {
  String id;
  String title;
  String? detail;
  String? url;
  String type;
  List<String> tags;
  FileModel? resource;
  FileModel? preview;
  CategoryResourceModel? category;
  CategoryResourceModel? categoryManager;

  ResourceModel({
    required this.id,
    required this.title,
    this.detail,
    this.url,
    required this.type,
    required this.tags,
    this.resource,
    this.preview,
    this.category,
    this.categoryManager,
  });

  factory ResourceModel.fromJson(Map<String, dynamic> json) {
    return ResourceModel(
      id: json['id'],
      title: json['title'],
      detail: json['detail'],
      url: json['url'],
      type: json['type'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      resource: json['resource'] != null
          ? FileModel.fromJson(json['resource'])
          : null,
      preview:
          json['preview'] != null ? FileModel.fromJson(json['preview']) : null,
      category: json['category'] != null
          ? CategoryResourceModel.fromJson(json['category'])
          : null,
      categoryManager: json['categoryManager'] != null
          ? CategoryResourceModel.fromJson(json['categoryManager'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['detail'] = detail;
    data['url'] = url;
    data['type'] = type;
    data['tags'] = tags;
    data['resource'] = resource?.toJson();
    data['preview'] = preview?.toJson();
    data['category'] = category?.toJson();
    data['categoryManager'] = categoryManager?.toJson();
    return data;
  }
}

class CategoryResourceModel {
  String id;
  String title;
  CategoryResourceModel? category;
  TargetModel? group;
  List<TargetModel> economicActivities;

  CategoryResourceModel({
    required this.id,
    required this.title,
    this.category,
    this.group,
    required this.economicActivities,
  });

  factory CategoryResourceModel.fromJson(Map<String, dynamic> json) {
    return CategoryResourceModel(
      id: json['id'],
      title: json['title'],
      category: json['category'] != null
          ? CategoryResourceModel.fromJson(json['category'])
          : null,
      group: json['group'] != null ? TargetModel.fromJson(json['group']) : null,
      economicActivities: json['economicActivities'] != null
          ? List<TargetModel>.from(
              json['economicActivities'].map(
                (x) => TargetModel.fromJson(x),
              ),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['category'] = category?.toJson();
    data['group'] = group?.toJson();
    data['economicActivities'] = economicActivities
        .map(
          (x) => x.toJson(),
        )
        .toList();
    return data;
  }
}
