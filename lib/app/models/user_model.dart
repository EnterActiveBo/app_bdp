class UserModel {
  String id;
  String name;
  String? firstLastName;
  String? secondLastName;
  String? email;
  ProfileModel? profile;
  SellerModel? seller;
  RoleModel role;

  UserModel({
    required this.id,
    required this.name,
    this.firstLastName,
    this.secondLastName,
    this.email,
    this.profile,
    this.seller,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      firstLastName: json['firstLastName'],
      secondLastName: json['secondLastName'],
      email: json['email'],
      profile: json['profile'] != null
          ? ProfileModel.fromJson(json['profile'])
          : null,
      seller:
          json['seller'] != null ? SellerModel.fromJson(json['seller']) : null,
      role: RoleModel.fromJson(json['role']),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['firstLastName'] = firstLastName;
    data['secondLastName'] = secondLastName;
    data['email'] = email;
    data['profile'] = profile?.toJson();
    data['seller'] = seller?.toJson();
    data['role'] = role.toJson();
    return data;
  }

  String getName() {
    String result = name;
    result += (firstLastName is String) ? " $firstLastName" : "";
    result += (secondLastName is String) ? " $secondLastName" : "";
    if (role.name == "client" &&
        profile is ProfileModel &&
        profile?.fullName is String) {
      result = profile!.fullName!;
    }
    return result.toUpperCase();
  }

  String? getFeatured() {
    if (role.name == "client") {
      return profile?.department?.name;
    }
    return role.showName;
  }

  bool isClient() {
    return role.name == "client";
  }
}

class ProfileModel {
  String id;
  String? email;
  String? address;
  String? phone;
  String? gender;
  String? name;
  String? fullName;
  String? firstLastName;
  String? secondLastName;
  String? cellPhone;
  String? documentType;
  String? documentNumber;
  String? documentComplement;
  String? documentExt;
  DateTime? birthDate;
  DepartmentModel? department;
  LocalityModel? locality;
  List<EconomicActivityModel> economicActivities;

  ProfileModel({
    required this.id,
    this.email,
    this.address,
    this.phone,
    this.gender,
    this.name,
    this.fullName,
    this.firstLastName,
    this.secondLastName,
    this.cellPhone,
    this.documentType,
    this.documentNumber,
    this.documentComplement,
    this.documentExt,
    this.birthDate,
    this.department,
    this.locality,
    required this.economicActivities,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      email: json['email'],
      address: json['address'],
      phone: json['phone'],
      gender: json['gender'],
      name: json['name'],
      fullName: json['fullName'],
      firstLastName: json['firstLastName'],
      secondLastName: json['secondLastName'],
      cellPhone: json['cellPhone'],
      documentType: json['documentType'],
      documentNumber: json['documentNumber'],
      documentComplement: json['documentComplement'],
      documentExt: json['documentExt'],
      birthDate: json['birthDate'] != null
          ? DateTime.parse(json['birthDate']).toLocal()
          : null,
      department: json['department'] != null
          ? DepartmentModel.fromJson(json['department'])
          : null,
      locality: json['locality'] != null
          ? LocalityModel.fromJson(json['locality'])
          : null,
      economicActivities: json['economicActivities'] != null
          ? List<EconomicActivityModel>.from(
              json['economicActivities'].map(
                (item) {
                  return EconomicActivityModel.fromJson(item);
                },
              ).toList(),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['address'] = address;
    data['phone'] = phone;
    data['gender'] = gender;
    data['name'] = name;
    data['fullName'] = fullName;
    data['firstLastName'] = firstLastName;
    data['secondLastName'] = secondLastName;
    data['cellPhone'] = cellPhone;
    data['documentType'] = documentType;
    data['documentNumber'] = documentNumber;
    data['documentComplement'] = documentComplement;
    data['documentExt'] = documentExt;
    data['birthDate'] = birthDate?.toString();
    data['department'] = department?.toJson();
    data['locality'] = locality?.toJson();
    data['economicActivities'] = economicActivities
        .map(
          (x) => x.toJson(),
        )
        .toList();
    return data;
  }

  String? getDepartmentLocality() {
    String? result = department?.name;
    if (locality is LocalityModel) {
      return "$result | ${locality?.name}";
    }
    return result;
  }
}

class DepartmentModel {
  String id;
  String name;

  DepartmentModel({
    required this.id,
    required this.name,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class LocalityModel {
  String id;
  String name;

  LocalityModel({
    required this.id,
    required this.name,
  });

  factory LocalityModel.fromJson(Map<String, dynamic> json) {
    return LocalityModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class EconomicActivityModel {
  String id;
  String name;
  String type;

  EconomicActivityModel({
    required this.id,
    required this.name,
    required this.type,
  });

  factory EconomicActivityModel.fromJson(Map<String, dynamic> json) {
    return EconomicActivityModel(
      id: json['id'],
      name: json['name'],
      type: json['meta']['pivot_type'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    final meta = <String, dynamic>{};
    meta['pivot_type'] = type;
    data['meta'] = meta;
    return data;
  }
}

class SellerModel {
  String id;
  String name;
  String? address;
  String? phone;
  String? email;
  String? terms;

  SellerModel({
    required this.id,
    required this.name,
    this.address,
    this.phone,
    this.email,
    this.terms,
  });

  factory SellerModel.fromJson(Map<String, dynamic> json) {
    return SellerModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      terms: json['terms'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['phone'] = phone;
    data['email'] = email;
    data['terms'] = terms;
    return data;
  }
}

class RoleModel {
  String id;
  String name;
  String showName;

  RoleModel({
    required this.id,
    required this.name,
    required this.showName,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json['id'],
      name: json['name'],
      showName: json['showName'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['showName'] = showName;
    return data;
  }
}
