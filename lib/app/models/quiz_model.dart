import 'package:flutter/material.dart';

class QuizModel {
  String code;
  String title;
  String? detail;
  List<ItemQuizModel> form;

  QuizModel({
    required this.code,
    required this.title,
    this.detail,
    required this.form,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      code: json['code'],
      title: json['title'],
      detail: json['detail'],
      form: json['form'] != null
          ? List<ItemQuizModel>.from(
              json['form'].map(
                (x) => ItemQuizModel.fromJson(x),
              ),
            )
          : [],
    );
  }

  bool readyToSave() {
    return form.every(
      (x) => x.responses.isNotEmpty,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['title'] = title;
    data['detail'] = detail;
    data['form'] = form.map((x) => x.toJson()).toList();
    return data;
  }

  Map<String, dynamic> toStore() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['form'] = form.map((x) => x.toForm()).toList();
    data['response'] = form.map((x) => x.toStore()).toList();
    return data;
  }
}

class ItemQuizModel {
  String title;
  int limit;
  List<String> options;
  List<String> responses;
  List<ExtraQuizModel>? extra;

  ItemQuizModel({
    required this.title,
    required this.limit,
    required this.options,
    required this.responses,
    this.extra,
  });

  factory ItemQuizModel.fromJson(Map<String, dynamic> json) {
    return ItemQuizModel(
      title: json['title'],
      limit: json['limit'],
      options: json['options'] != null
          ? List<String>.from(
              json['options'],
            )
          : [],
      responses: json['responses'] != null
          ? List<String>.from(
              json['responses'],
            )
          : [],
      extra: json['extra'] != null
          ? List<ExtraQuizModel>.from(
              json['extra'].map(
                (x) => ExtraQuizModel.fromJson(x),
              ),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['limit'] = limit;
    data['options'] = options;
    data['responses'] = responses;
    data['extra'] = extra?.map((x) => x.toJson()).toList();
    return data;
  }

  Map<String, dynamic> toForm() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['options'] = options;
    data['limit'] = limit;
    data['extra'] = extra?.map((x) => x.toJson()).toList();
    return data;
  }

  Map<String, dynamic> toStore() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['options'] = responses;
    data['extra'] = extra?.map((x) => x.toStore()).toList();
    return data;
  }
}

class QuizResponseModel {
  String id;
  String code;
  DateTime updatedAt;

  QuizResponseModel({
    required this.id,
    required this.code,
    required this.updatedAt,
  });

  factory QuizResponseModel.fromJson(Map<String, dynamic> json) {
    return QuizResponseModel(
      id: json['id'],
      code: json['code'],
      updatedAt: DateTime.parse(json['updatedAt']).toLocal(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['updatedAt'] = updatedAt.toString();
    return data;
  }
}

class ExtraQuizModel {
  String title;
  String? value;
  TextEditingController editController;

  ExtraQuizModel({
    required this.title,
    this.value,
    required this.editController,
  });

  factory ExtraQuizModel.fromJson(Map<String, dynamic> json) {
    return ExtraQuizModel(
      title: json['title'],
      value: json['value'],
      editController: TextEditingController(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['value'] = value;
    return data;
  }

  Map<String, dynamic> toForm() {
    final data = <String, dynamic>{};
    data['title'] = title;
    return data;
  }

  Map<String, dynamic> toStore() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['value'] = editController.text;
    return data;
  }
}
