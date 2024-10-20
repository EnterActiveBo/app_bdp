import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controllers/video_controller.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key});
  @override
  _VideoView createState() => _VideoView();
}

class _VideoView extends State<VideoView> {
  VideoController controller = Get.find();
  late VideoPlayerController _storedVideoController;
  ChewieController? _prettyVideoController;

  @override
  void initState() {
    super.initState();
    if (controller.videoId.value == null) {
      initializePlayer();
    }
  }

  @override
  void deactivate() {
    if (controller.videoId.value is String) {
      controller.youTubeController.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    if (controller.videoId.value == null) {
      _storedVideoController.dispose();
      _prettyVideoController?.dispose();
    }
    super.dispose();
  }

  Future<void> initializePlayer() async {
    if (controller.videoId.value == null) {
      _storedVideoController = VideoPlayerController.networkUrl(
        Uri.parse(
          controller.resource.value!.source!.url,
        ),
      );
      await Future.wait([
        _storedVideoController.initialize(),
      ]);
      _createPrettyVideoController();
      setState(() {});
    }
  }

  void _createPrettyVideoController() {
    _prettyVideoController = ChewieController(
      videoPlayerController: _storedVideoController,
      autoPlay: false,
      looping: false,
      progressIndicatorDelay: null,
      hideControlsTimer: const Duration(seconds: 1),
      materialProgressColors: ChewieProgressColors(
        playedColor: appColorSecondary,
        handleColor: appColorPrimary,
        backgroundColor: Colors.grey,
        bufferedColor: appColorTransparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.videoId.value is String
          ? YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: controller.youTubeController,
              ),
              builder: (context, player) {
                return Scaffold(
                  backgroundColor: appColorPrimary,
                  appBar: const HeaderBdpView(
                    primary: true,
                    title: "BDP Video",
                  ),
                  body: Center(
                    child: player,
                  ),
                );
              },
              onExitFullScreen: () {
                SystemChrome.setEnabledSystemUIMode(
                  SystemUiMode.manual,
                  overlays: SystemUiOverlay.values,
                );
                SystemChrome.setSystemUIOverlayStyle(
                  SystemUiOverlayStyle.dark,
                );
              },
            )
          : Scaffold(
              backgroundColor: appColorPrimary,
              appBar: const HeaderBdpView(
                primary: true,
                title: "BDP video",
              ),
              body: Center(
                child: _prettyVideoController != null &&
                        _prettyVideoController!
                            .videoPlayerController.value.isInitialized
                    ? Chewie(
                        controller: _prettyVideoController!,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 20),
                          titleBdp(
                            "Espere por favor ...",
                            color: appColorWhite,
                          ),
                        ],
                      ),
              ),
            ),
    );
  }
}
