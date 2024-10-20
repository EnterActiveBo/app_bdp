import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/providers/resource_provider.dart';
import 'package:appbdp/app/models/resource_model.dart';
import 'package:appbdp/app/modules/goodPractices/resources/document/controllers/document_controller.dart';
import 'package:appbdp/app/modules/goodPractices/resources/video/controllers/video_controller.dart';
import 'package:appbdp/app/modules/goodPractices/resources/views/file_list_view.dart';
import 'package:appbdp/app/modules/goodPractices/resources/views/link_list_view.dart';
import 'package:appbdp/app/modules/goodPractices/resources/views/video_list_view.dart';
import 'package:appbdp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ResourcesController extends GetxController
    with GetTickerProviderStateMixin {
  DocumentController documentController = Get.find();
  VideoController videoController = Get.find();
  ResourceProvider resourceProvider = Get.find();
  final Rx<CategoryResourceModel?> category =
      (null as CategoryResourceModel?).obs;
  final RxList<ResourceModel> resources = (List<ResourceModel>.of([])).obs;
  final Rx<String?> searchFile = (null as String?).obs;
  final Rx<String?> searchVideo = (null as String?).obs;
  final Rx<String?> searchLink = (null as String?).obs;
  final loading = true.obs;

  // Tabs definition
  final Rx<TabController?> tabController = (null as TabController?).obs;
  List<Tab> enableTabs = <Tab>[
    const Tab(
      text: "Documentos",
    ),
    const Tab(
      text: "Videos",
    ),
    const Tab(
      text: "Enlaces",
    ),
  ];
  List<Widget> tabContents = <Widget>[
    const FileListView(),
    const VideoListView(),
    const LinkListView(),
  ];

  @override
  void onInit() {
    super.onInit();
    tabController.value = TabController(
      vsync: this,
      length: enableTabs.length,
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    reset();
  }

  setCategory(CategoryResourceModel value) {
    reset();
    category.value = value;
    getResources();
  }

  getResources() async {
    if (category.value is CategoryResourceModel) {
      List<ResourceModel>? resourcesResponse =
          await resourceProvider.getResources(category.value?.id ?? "");
      loading.value = false;
      if (resourcesResponse is List<ResourceModel>) {
        resources.value = resourcesResponse;
      }
    }
  }

  setSearchFile(String? value) {
    searchFile.value = value == "" ? null : value;
  }

  setSearchVideo(String? value) {
    searchVideo.value = value == "" ? null : value;
  }

  setSearchLink(String? value) {
    searchLink.value = value == "" ? null : value;
  }

  List<ResourceModel> filterResources(String type) {
    return resources.where((resource) {
      bool filter = resource.type == type;
      switch (type) {
        case 'file':
          if (searchFile.value is String) {
            filter &= searchString(
              resource.title,
              searchFile.value,
            );
            filter |= searchString(
              resource.detail ?? "",
              searchFile.value,
            );
            filter |= searchString(
              resource.getTagsString() ?? "",
              searchFile.value,
            );
          }
          break;

        case 'video':
          if (searchVideo.value is String) {
            filter &= searchString(
              resource.title,
              searchVideo.value,
            );
            filter |= searchString(
              resource.detail ?? "",
              searchVideo.value,
            );
            filter |= searchString(
              resource.getTagsString() ?? "",
              searchVideo.value,
            );
          }
          break;

        case 'link':
          if (searchLink.value is String) {
            filter &= searchString(
              resource.title,
              searchLink.value,
            );
            filter |= searchString(
              resource.detail ?? "",
              searchLink.value,
            );
            filter |= searchString(
              resource.getTagsString() ?? "",
              searchLink.value,
            );
          }
          break;

        default:
      }

      return filter;
    }).toList();
  }

  String? getVideoThumb(ResourceModel resource) {
    String? image;
    if (resource.videoType == "link") {
      String? youTubeId = YoutubePlayer.convertUrlToId("${resource.url}");
      if (youTubeId != null) {
        image = YoutubePlayer.getThumbnail(
          videoId: youTubeId,
          quality: ThumbnailQuality.high,
        );
      }
    } else {
      if (resource.preview is FileModel) {
        image = resource.preview?.url;
      }
    }
    return image;
  }

  setVideo(ResourceModel value) {
    videoController.setResource(value);
    Get.toNamed(Routes.VIDEO);
  }

  setDocument(ResourceModel value) {
    documentController.setDocument(value);
    Get.toNamed(Routes.DOCUMENT);
  }

  reset() {
    loading.value = true;
    searchFile.value = null;
    searchVideo.value = null;
    searchLink.value = null;
  }
}
