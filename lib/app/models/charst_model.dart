class ChartProductionModel {
  List<ProductionModel> chartData;

  ChartProductionModel({
    required this.chartData,
  });

  factory ChartProductionModel.fromJson(Map<String, dynamic> json) {
    return ChartProductionModel(
      chartData: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['chartData'] = chartData.map((x) => x.toJson()).toList();
    return data;
  }
}

class ProductionModel {
  String name;
  double value;

  ProductionModel({
    required this.name,
    required this.value,
  });

  factory ProductionModel.fromJson(Map<String, dynamic> json) {
    return ProductionModel(
      name: json['name'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value.toString();
    return data;
  }
}
