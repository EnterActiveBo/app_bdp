import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/input_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:video_player/video_player.dart';

import '../controllers/course_bdp_module_controller.dart';

class CourseBdpModuleView extends StatefulWidget {
  const CourseBdpModuleView({super.key});
  @override
  CourseBdpModuleState createState() => CourseBdpModuleState();
}

class CourseBdpModuleState extends State<CourseBdpModuleView> {
  final CourseBdpModuleController controller = Get.find();
  late VideoPlayerController _storedVideoController;
  ChewieController? _prettyVideoController;

  @override
  void initState() {
    super.initState();
    // initializePlayer();
  }

  @override
  void dispose() {
    if (controller.module.value?.type == "2") {
      _storedVideoController.dispose();
      _prettyVideoController?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        Widget content = Center(
          child: Column(
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
        );
        if (!controller.loadingModule.value) {
          switch (controller.module.value?.type) {
            case "1":
              content = pdfView(
                controller.module.value!.getUrl(),
              );
              break;
            case "2":
              initializePlayer();
              content = videoView();
              break;
            default:
              content = documentView();
          }
        }
        return Scaffold(
          backgroundColor:
              controller.module.value?.type == "2" ? appColorPrimary : null,
          appBar: const HeaderBdpView(
            primary: true,
            title: "Cursos BDP",
          ),
          body: content,
        );
      },
    );
  }

  Future<void> initializePlayer() async {
    if (controller.module.value?.type == "2") {
      _storedVideoController = VideoPlayerController.networkUrl(
        Uri.parse(
          controller.module.value!.getUrl(),
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
      optionsTranslation: OptionsTranslation(
        playbackSpeedButtonText: 'Velocidad de reproducción',
        subtitlesButtonText: 'Subtítulos',
        cancelButtonText: 'Cerrar',
      ),
      materialProgressColors: ChewieProgressColors(
        playedColor: appColorSecondary,
        handleColor: appColorPrimary,
        backgroundColor: Colors.grey,
        bufferedColor: appColorTransparent,
      ),
    );
  }

  Widget pdfView(String url) {
    return const PDF().fromUrl(
      url,
      placeholder: (double progress) => Center(
        child: Text('$progress %'),
      ),
      errorWidget: (dynamic error) => Center(
        child: Text(
          error.toString(),
        ),
      ),
    );
  }

  Widget videoView() {
    Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 20),
        titleBdp(
          "Espere por favor ...",
          color: appColorWhite,
        ),
      ],
    );
    if (_prettyVideoController != null &&
        _prettyVideoController!.videoPlayerController.value.isInitialized) {
      content = Chewie(
        controller: _prettyVideoController!,
      );
    }
    return Center(
      child: content,
    );
  }

  Widget documentView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              decoration: boxDecorationRoundedWithShadow(
                10,
                backgroundColor: appBackgroundOpacity,
                shadowColor: appColorTransparent,
              ),
              child: titleBdp(
                "Curso BDP",
                size: 13,
                weight: FontWeight.w600,
                color: appColorThird,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Visibility(
              visible: controller.module.value?.type == "3",
              child: Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                ),
                decoration: boxDecorationRoundedWithShadow(
                  20,
                  shadowColor: appColorTransparent,
                ),
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                  imageUrl: controller.module.value!.getUrl(),
                  width: Get.width,
                  height: Get.width / 2,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            titleBdp(
              controller.module.value?.title ?? "",
              align: TextAlign.left,
            ),
            Visibility(
              visible: controller.module.value?.detail is String,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: textBdp(
                  controller.module.value?.detail,
                  align: TextAlign.left,
                  size: 14,
                ),
              ),
            ),
            Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
              decoration: boxDecorationRoundedWithShadow(
                6,
                backgroundColor: appBackground,
                shadowColor: appColorTransparent,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: textRichBdp(
                      "Tipo de Archivo: ",
                      "Imagen".toUpperCase(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            buttonBdp(
              "Descargar",
              () {
                downloadFile(
                  controller.module.value!.getUrl(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
