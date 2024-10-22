import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/input_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/pathology_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/document_pathology_controller.dart';

class DocumentPathologyView extends GetView<DocumentPathologyController> {
  const DocumentPathologyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        ResourcePathologyModel? document = controller.resource.value;
        return Scaffold(
          appBar: HeaderBdpView(
            primary: true,
            title: "BDP Documento",
            url: controller.pdfUrl(),
          ),
          body: () {
            if (document?.source.extension == "pdf") {
              return const PDF().fromUrl(
                "${document?.source.url}",
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
                        "Enfermedades",
                        size: 13,
                        weight: FontWeight.w600,
                        color: appColorThird,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Visibility(
                      visible: document?.preview is FileModel,
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
                          imageUrl: "${document?.preview?.url}",
                          width: Get.width,
                          height: Get.width / 2,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    titleBdp(
                      document!.title,
                      align: TextAlign.left,
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
                              document.source.extension.toUpperCase(),
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
                                document.source.size,
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
                          document.source.url,
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
