import 'package:appbdp/app/models/user_model.dart';
import 'package:get/get.dart';

String? getGender(String? gender) {
  switch (gender) {
    case "female":
      return "Femenino";
    case "male":
      return "Masculino";
    default:
      return null;
  }
}

String? getEconomicActivity(
  List<EconomicActivityModel> activities,
  String? type,
) {
  EconomicActivityModel? economicActivity = activities.firstWhereOrNull(
    (element) => element.type == type,
  );
  return economicActivity?.name;
}
