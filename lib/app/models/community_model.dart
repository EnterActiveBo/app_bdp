import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/user_model.dart';
import 'package:get/get.dart';

class CommunityModel {
  String id;
  String title;
  String detail;
  DateTime updatedAt;
  List<ResourceCommunityModel> resources;
  UserModel user;
  MetaCommunityModel meta;
  List<CommunityModel> children;

  CommunityModel({
    required this.id,
    required this.title,
    required this.detail,
    required this.updatedAt,
    required this.resources,
    required this.user,
    required this.meta,
    required this.children,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      id: json['id'],
      title: json['title'],
      detail: json['detail'],
      updatedAt: DateTime.parse(json['updatedAt']).toLocal(),
      resources: json['resources'] != null
          ? List<ResourceCommunityModel>.from(
              json['resources'].map((r) {
                return ResourceCommunityModel.fromJson(r);
              }).toList(),
            )
          : [],
      user: UserModel.fromJson(json['user']),
      meta: MetaCommunityModel.fromJson(json['meta']),
      children: json['children'] != null
          ? List<CommunityModel>.from(
              json['children'].map((r) {
                return CommunityModel.fromJson(r);
              }).toList(),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['detail'] = detail;
    data['updatedAt'] = updatedAt.toString();
    data['resources'] = resources.map((x) => x.toJson()).toList();
    data['user'] = user.toJson();
    data['meta'] = meta.toJson();
    data['children'] = children.map((x) => x.toJson()).toList();
    return data;
  }

  FileModel? getImageFeatured() {
    return resources
        .firstWhereOrNull(
          (resource) => searchString(resource.source.mimeType, "image"),
        )
        ?.source;
  }

  List<FileModel> getImages() {
    return resources
        .where(
          (resource) => searchString(resource.source.mimeType, "image"),
        )
        .map(
          (resource) => resource.source,
        )
        .toList();
  }

  List<FileModel> getFiles() {
    return resources
        .where(
          (resource) => !searchString(resource.source.mimeType, "image"),
        )
        .map(
          (resource) => resource.source,
        )
        .toList();
  }
}

class MetaCommunityModel {
  int interactions;
  bool view;
  bool positive;
  bool negative;

  MetaCommunityModel({
    required this.interactions,
    required this.view,
    required this.positive,
    required this.negative,
  });

  factory MetaCommunityModel.fromJson(Map<String, dynamic> json) {
    return MetaCommunityModel(
      interactions: json['interactions'],
      view: json['view'] == 1,
      positive: json['positive'] == 1,
      negative: json['negative'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['interactions'] = interactions;
    data['view'] = view ? 1 : 0;
    data['positive'] = positive ? 1 : 0;
    data['negative'] = negative ? 1 : 0;

    return data;
  }
}

class CommunityListModel {
  List<CommunityModel> data;
  MetaCommunityListModel meta;

  CommunityListModel({
    required this.data,
    required this.meta,
  });

  factory CommunityListModel.fromJson(Map<String, dynamic> json) {
    return CommunityListModel(
      data: List<CommunityModel>.from(
        json['data'].map(
          (news) => CommunityModel.fromJson(news),
        ),
      ),
      meta: MetaCommunityListModel.fromJson(
        json['meta'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    final dataJson = <String, dynamic>{};
    dataJson['data'] = data.map((v) => v.toJson()).toList();
    dataJson['meta'] = meta.toJson();
    return dataJson;
  }
}

class MetaCommunityListModel {
  int currentPage;
  int lastPage;
  int perPage;
  int total;

  MetaCommunityListModel({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory MetaCommunityListModel.fromJson(Map<String, dynamic> json) {
    return MetaCommunityListModel(
      currentPage: json['currentPage'],
      lastPage: json['lastPage'],
      perPage: json['perPage'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['lastPage'] = lastPage;
    data['perPage'] = perPage;
    data['total'] = total;
    return data;
  }

  bool isLastPage() {
    return currentPage == lastPage;
  }
}

class ResourceCommunityModel {
  String? id;
  FileModel source;

  ResourceCommunityModel({
    this.id,
    required this.source,
  });

  factory ResourceCommunityModel.fromJson(Map<String, dynamic> json) {
    return ResourceCommunityModel(
      id: json['id'],
      source: FileModel.fromJson(json['source']),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['source'] = source.toJson();
    return data;
  }

  Map<String, dynamic> toSend() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['source_id'] = source.id;
    return data;
  }
}
