import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/community_model.dart';
import 'package:appbdp/app/modules/community/fileCommunity/controllers/file_community_controller.dart';
import 'package:appbdp/app/routes/app_pages.dart';
import 'package:get/get.dart';

class DocumentsCommunityController extends GetxController {
  final Rx<CommunityModel?> community = (null as CommunityModel?).obs;
  final FileCommunityController fileCommunityController = Get.find();




  setCommunity(CommunityModel value) {
    community.value = value;
  }

  setDocument(FileModel value) {
    fileCommunityController.setResource(value);
    Get.toNamed(Routes.FILE_COMMUNITY);
  }
}
