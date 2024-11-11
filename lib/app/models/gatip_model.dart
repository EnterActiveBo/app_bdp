class PricesProductModel {
  int code;
  String name;

  PricesProductModel({
    required this.code,
    required this.name,
  });

  factory PricesProductModel.fromJson(Map<String, dynamic> json) {
    return PricesProductModel(
      code: json['codigo'],
      name: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['codigo'] = code;
    data['nombre'] = name;
    return data;
  }

  String pricesProductAsString() {
    return '#$code $name';
  }

  bool isEqual(PricesProductModel model) {
    return code == model.code;
  }
}

class PricesYearModel {
  int year;
  String unit;
  double average;

  PricesYearModel({
    required this.year,
    required this.unit,
    required this.average,
  });

  factory PricesYearModel.fromJson(Map<String, dynamic> json) {
    return PricesYearModel(
      year: json['periodo'],
      unit: json['unidad'],
      average: json['promedio'] != null ? json['promedio'] + 0.0 : 0,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['periodo'] = year;
    data['unidad'] = unit;
    data['promedio'] = average;
    return data;
  }
}

class PricesCityModel {
  int year;
  String city;
  String unit;
  double average;

  PricesCityModel({
    required this.year,
    required this.city,
    required this.unit,
    required this.average,
  });

  factory PricesCityModel.fromJson(Map<String, dynamic> json) {
    return PricesCityModel(
      year: json['gestion'],
      city: json['ciudad'],
      unit: json['unidad'],
      average: json['promedio'] != null ? json['promedio'] + 0.0 : 0,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['gestion'] = year;
    data['ciudad'] = city;
    data['unidad'] = unit;
    data['promedio'] = average.toString();
    return data;
  }
}

class PricesAccumulatedModel {
  String label;
  String unit;
  double average;
  double min;
  double max;

  PricesAccumulatedModel({
    required this.label,
    required this.unit,
    required this.average,
    required this.min,
    required this.max,
  });

  factory PricesAccumulatedModel.fromJson(Map<String, dynamic> json) {
    return PricesAccumulatedModel(
      label: json['gestion'],
      unit: json['unidad'],
      average: json['promedio'] != null ? json['promedio'] + 0.0 : 0,
      min: json['minimo'] != null ? json['minimo'] + 0.0 : 0,
      max: json['maximo'] != null ? json['maximo'] + 0.0 : 0,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['gestion'] = label;
    data['unidad'] = unit;
    data['promedio'] = average.toString();
    data['minimo'] = min.toString();
    data['maximo'] = max.toString();
    return data;
  }
}

class ProductionCompositionModel {
  String detail;
  double quantity;

  ProductionCompositionModel({
    required this.detail,
    required this.quantity,
  });

  factory ProductionCompositionModel.fromJson(Map<String, dynamic> json) {
    return ProductionCompositionModel(
      detail: json['detalle'],
      quantity: json['cantidad'] != null ? json['cantidad'] + 0.0 : 0,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['detalle'] = detail;
    data['cantidad'] = quantity;
    return data;
  }
}

class ProductionLocationModel {
  String department;
  String municipality;
  String detail;
  double quantity;

  ProductionLocationModel({
    required this.department,
    required this.municipality,
    required this.detail,
    required this.quantity,
  });

  factory ProductionLocationModel.fromJson(Map<String, dynamic> json) {
    return ProductionLocationModel(
      department: json['nom_dep'],
      municipality: json['nom_mun'],
      detail: json['detalle'],
      quantity: json['cantidad'] != null ? json['cantidad'] + 0.0 : 0,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nom_dep'] = department;
    data['nom_mun'] = municipality;
    data['detalle'] = detail;
    data['cantidad'] = quantity;
    return data;
  }
}

class ProductionUnitModel {
  String unit;
  bool selected;
  ProductionUnitModel({
    required this.unit,
    required this.selected,
  });
  factory ProductionUnitModel.fromJson(Map<String, dynamic> json) {
    return ProductionUnitModel(
      unit: json['unidad'],
      selected: false,
    );
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['unidad'] = unit;
    return data;
  }

  bool isEqual(ProductionUnitModel model) {
    return unit == model.unit;
  }
}

class ProductionDepartmentModel {
  String value;
  String name;
  bool selected;
  ProductionDepartmentModel({
    required this.value,
    required this.name,
    required this.selected,
  });
  factory ProductionDepartmentModel.fromJson(Map<String, dynamic> json) {
    return ProductionDepartmentModel(
      value: json['value'],
      name: json['name'],
      selected: false,
    );
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['value'] = value;
    data['name'] = name;
    return data;
  }

  bool isEqual(ProductionDepartmentModel model) {
    return value == model.value;
  }
}

class ProductionMunicipalityModel {
  String code;
  String name;
  bool selected;
  ProductionMunicipalityModel({
    required this.code,
    required this.name,
    required this.selected,
  });
  factory ProductionMunicipalityModel.fromJson(Map<String, dynamic> json) {
    return ProductionMunicipalityModel(
      code: json['codigo'],
      name: json['municipio'],
      selected: false,
    );
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['codigo'] = code;
    data['municipio'] = name;
    return data;
  }

  bool isEqual(ProductionMunicipalityModel model) {
    return code == model.code;
  }
}

class ProductionRegionModel {
  String code;
  String name;
  bool selected;
  ProductionRegionModel({
    required this.code,
    required this.name,
    required this.selected,
  });
  factory ProductionRegionModel.fromJson(Map<String, dynamic> json) {
    return ProductionRegionModel(
      code: json['codigo'],
      name: json['region'],
      selected: false,
    );
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['codigo'] = code;
    data['region'] = name;
    return data;
  }

  bool isEqual(ProductionRegionModel model) {
    return code == model.code;
  }
}

class ProductionProductModel {
  String name;
  bool selected;
  ProductionProductModel({
    required this.name,
    required this.selected,
  });
  factory ProductionProductModel.fromJson(Map<String, dynamic> json) {
    return ProductionProductModel(
      name: json['producto'],
      selected: false,
    );
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['producto'] = name;
    return data;
  }

  bool isEqual(ProductionProductModel model) {
    return name == model.name;
  }
}

class ProductionItemModel {
  String name;
  bool selected;
  ProductionItemModel({
    required this.name,
    required this.selected,
  });
  factory ProductionItemModel.fromJson(Map<String, dynamic> json) {
    return ProductionItemModel(
      name: json['item'],
      selected: false,
    );
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['producto'] = name;
    return data;
  }

  bool isEqual(ProductionItemModel model) {
    return name == model.name;
  }
}
