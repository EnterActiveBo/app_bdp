import 'package:appbdp/app/models/resource_model.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoController extends GetxController {
  final Rx<ResourceModel?> resource = (null as ResourceModel?).obs;
  final videoId = (null as String?).obs;
  YoutubePlayerController youTubeController = YoutubePlayerController(
    initialVideoId: "kMQxgwVH4t4",
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );



  @override
  void onClose() {
    super.onClose();
    youTubeController.dispose();
  }

  setResource(ResourceModel item) {
    resource.value = item;
    videoId.value = getVideoId(item);
    if (videoId.value is String) {
      youTubeController = YoutubePlayerController(
        initialVideoId: "${videoId.value}",
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    }
  }

  String? getVideoId(ResourceModel item) {
    String? youTubeId;
    if (item.videoType == "link") {
      youTubeId = YoutubePlayer.convertUrlToId("${item.url}");
    }
    return youTubeId;
  }
}
