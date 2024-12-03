import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/input_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/file_community_controller.dart';

class FileCommunityView extends GetView<FileCommunityController> {
  const FileCommunityView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        FileModel? document = controller.resource.value;
        return Scaffold(
          appBar: HeaderBdpView(
            primary: true,
            title: "Comunidad",
            url: controller.pdfUrl(),
          ),
          body: () {
            if (document?.extension == "pdf") {
              return const PDF().fromUrl(
                "${document?.url}",
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
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleBdp(
                      document!.originalName,
                      align: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 15,
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
                              document.extension.toUpperCase(),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            color: appColorPrimary,
                            width: 2,
                            height: 20,
                          ),
                          Expanded(
                            child: textRichBdp(
                              "Peso: ",
                              getFileSize(
                                document.size,
                              ),
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
                          document.url,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }(),
          bottomNavigationBar: const BottomBdpView(),
        );
      },
    );
  }
}
