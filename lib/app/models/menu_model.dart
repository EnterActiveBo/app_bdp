class MenuModel {
  String title;
  String page;
  String svg;
  bool isPrimary;
  bool? disabled;

  MenuModel({
    required this.title,
    required this.page,
    required this.svg,
    required this.isPrimary,
    this.disabled,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      title: json['title'],
      page: json['page'],
      svg: json['svg'],
      isPrimary: json['svg'],
      disabled: json['disabled'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['page'] = page;
    data['svg'] = svg;
    data['isPrimary'] = isPrimary;
    data['disabled'] = disabled;
    return data;
  }

  String getSvgAsset() {
    return "assets/images/icons/$svg.svg";
  }
}
