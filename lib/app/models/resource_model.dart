import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/course_model.dart';

class ResourceModel {
  String id;
  String title;
  String? detail;
  String? url;
  String type;
  String? videoType;
  List<String> tags;
  FileModel? source;
  FileModel? preview;
  CategoryResourceModel? category;
  CategoryResourceModel? categoryManager;
  DateTime updatedAt;

  ResourceModel({
    required this.id,
    required this.title,
    this.detail,
    this.url,
    required this.type,
    this.videoType,
    required this.tags,
    this.source,
    this.preview,
    this.category,
    this.categoryManager,
    required this.updatedAt,
  });

  factory ResourceModel.fromJson(Map<String, dynamic> json) {
    return ResourceModel(
      id: json['id'],
      title: json['title'],
      detail: json['detail'],
      url: json['url'],
      type: json['type'],
      videoType: json['videoType'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      source:
          json['source'] != null ? FileModel.fromJson(json['source']) : null,
      preview:
          json['preview'] != null ? FileModel.fromJson(json['preview']) : null,
      category: json['category'] != null
          ? CategoryResourceModel.fromJson(json['category'])
          : null,
      categoryManager: json['categoryManager'] != null
          ? CategoryResourceModel.fromJson(json['categoryManager'])
          : null,
      updatedAt: DateTime.parse(json['updatedAt']).toLocal(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['detail'] = detail;
    data['url'] = url;
    data['type'] = type;
    data['videoType'] = videoType;
    data['tags'] = tags;
    data['source'] = source?.toJson();
    data['preview'] = preview?.toJson();
    data['category'] = category?.toJson();
    data['categoryManager'] = categoryManager?.toJson();
    data['updatedAt'] = updatedAt.toString();
    return data;
  }

  String getCategory() {
    if (category is CategoryResourceModel) {
      return category?.title ?? "BDP";
    }
    if (categoryManager is CategoryResourceModel) {
      return categoryManager?.title ?? "BDP";
    }
    return "BDP";
  }

  String? getTagsString() {
    if (tags.isNotEmpty) {
      return tags.map((tag) => tag.toString()).toList().join(" | ");
    }
    return null;
  }
}

class CategoryResourceModel implements Comparable<CategoryResourceModel> {
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

  @override
  int compareTo(CategoryResourceModel other) {
    return title.compareTo(other.title);
  }
}
