import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/user_model.dart';
import 'package:flutter/material.dart';

class SupportModel {
  String id;
  String status;
  String title;
  String detail;
  DateTime createdAt;
  DateTime updatedAt;
  UserModel user;
  int messagesCount;
  List<MessageSupportModel> messages;

  SupportModel({
    required this.id,
    required this.status,
    required this.title,
    required this.detail,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.messagesCount,
    required this.messages,
  });

  factory SupportModel.fromJson(Map<String, dynamic> json) {
    return SupportModel(
      id: json['id'],
      status: json['status'],
      title: json['title'],
      detail: json['detail'],
      createdAt: DateTime.parse(json['createdAt']).toLocal(),
      updatedAt: DateTime.parse(json['updatedAt']).toLocal(),
      user: UserModel.fromJson(json['user']),
      messagesCount: json['meta']['messages_count'] ?? 0,
      messages: json['messages'] != null
          ? List<MessageSupportModel>.from(
              json['messages'].map(
                (x) => MessageSupportModel.fromJson(x),
              ),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['title'] = title;
    data['detail'] = detail;
    data['createdAt'] = createdAt.toString();
    data['updatedAt'] = updatedAt.toString();
    data['user'] = user.toJson();
    final meta = <String, dynamic>{};
    meta['messages_count'] = messagesCount;
    data['meta'] = meta;
    data['messages'] = messages.map((x) => x.toJson()).toList();
    return data;
  }

  String statusText() {
    switch (status) {
      case 'new':
        return 'Nuevo';
      case 'open':
        return 'En curso';
      case 'closed':
        return 'Cerrado';
      default:
        return 'Nuevo';
    }
  }

  Color statusColor() {
    switch (status) {
      case 'new':
        return appColorThirdOpacity;
      case 'open':
        return appBackgroundOpacity;
      case 'closed':
        return appColorSecondary;
      default:
        return appBackgroundOpacity;
    }
  }

  bool isActive() {
    return status == 'open' || status == 'new';
  }
}

class MessageSupportModel {
  String id;
  bool system;
  String? message;
  FileModel? source;
  DateTime createdAt;
  DateTime updatedAt;
  UserModel? user;

  MessageSupportModel({
    required this.id,
    required this.system,
    this.message,
    this.source,
    required this.createdAt,
    required this.updatedAt,
    this.user,
  });

  factory MessageSupportModel.fromJson(Map<String, dynamic> json) {
    return MessageSupportModel(
      id: json['id'],
      system: json['system'] == 1,
      message: json['message'],
      source:
          json['source'] != null ? FileModel.fromJson(json['source']) : null,
      createdAt: DateTime.parse(json['createdAt']).toLocal(),
      updatedAt: DateTime.parse(json['updatedAt']).toLocal(),
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['system'] = system ? 1 : 0;
    data['message'] = message;
    data['createdAt'] = createdAt.toString();
    data['updatedAt'] = updatedAt.toString();
    data['user'] = user?.toJson();
    data['source'] = source?.toJson();
    return data;
  }
}

class MetaListModel {
  int currentPage;
  int lastPage;
  int perPage;
  int total;

  MetaListModel({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory MetaListModel.fromJson(Map<String, dynamic> json) {
    return MetaListModel(
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

class SupportListModel {
  List<SupportModel> data;
  MetaListModel meta;

  SupportListModel({
    required this.data,
    required this.meta,
  });

  factory SupportListModel.fromJson(Map<String, dynamic> json) {
    return SupportListModel(
      data: List<SupportModel>.from(
        json['data'].map(
          (news) => SupportModel.fromJson(news),
        ),
      ),
      meta: MetaListModel.fromJson(
        json['meta'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    final dataJson = <String, dynamic>{};
    dataJson['data'] = data
        .map(
          (v) => v.toJson(),
        )
        .toList();
    dataJson['meta'] = meta.toJson();
    return dataJson;
  }
}
