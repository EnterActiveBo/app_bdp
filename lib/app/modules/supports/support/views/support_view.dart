import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/input_widgets.dart';
import 'package:appbdp/app/common/widgets/query_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/support_model.dart';
import 'package:appbdp/app/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/support_controller.dart';

class SupportView extends GetView<SupportController> {
  const SupportView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController message = TextEditingController();
    FocusNode messageFocus = FocusNode();
    FocusNode submitFocusNode = FocusNode();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: HeaderBdpView(
        primary: true,
        title: "Soporte en Línea",
        iconAction: Icons.refresh_outlined,
        action: () {
          controller.reloadSupport();
        },
      ),
      body: Obx(
        () {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                child: Stack(
                  children: [
                    containerBdp(
                      pv: 10,
                      ph: 10,
                      child: Column(
                        children: [
                          titleBdp(
                            controller.support.value?.user.chatUser() ?? "",
                            weight: FontWeight.normal,
                            size: 14,
                            textHeight: 0,
                          ),
                          titleBdp(
                            controller.support.value?.title ?? "",
                            textHeight: 0,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: controller.user.value?.isClient() == false &&
                          controller.support.value?.isActive() == true,
                      child: Positioned(
                        top: 5,
                        right: 5,
                        child: iconButton(
                          Icons.close,
                          pd: 5,
                          size: 15,
                          color: appColorYellow,
                          action: () {
                            controller.closeSupport();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: controller.loading.value,
                child: Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: loadingBdp(),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: RawScrollbar(
                      thumbVisibility: true,
                      controller: controller.scrollController.value,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7.5,
                      ),
                      radius: const Radius.circular(10),
                      thumbColor: appColorPrimary,
                      child: ListView.separated(
                        controller: controller.scrollController.value,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        reverse: true,
                        itemBuilder: (_, index) {
                          return chatItem(
                            controller.support.value!.messages.reversed
                                .toList()[index],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            color: Colors.transparent,
                            height: 10,
                          );
                        },
                        itemCount:
                            controller.support.value?.messages.length ?? 0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: controller.support.value?.isActive() == false ? 10 : 0,
              ),
              Visibility(
                visible: controller.support.value?.isActive() == true,
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: textFieldBdp(
                            hintText: "Escribe tu mensaje ...",
                            textEditingController: message,
                            textType: TextFieldType.MULTILINE,
                            focusNode: messageFocus,
                            nextNode: submitFocusNode,
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            fillColor: appBackgroundOpacity,
                            borderColor: appColorTransparent,
                            borderRadius: 30,
                            isRequired: false,
                            minLines: 1,
                            maxLines: 2,
                            suffixIcon: iconButton(
                              Icons.attach_file,
                              color: appColorTransparent,
                              iconColor: appColorThird,
                              action: () {
                                controller.uploadFile();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        iconButton(
                          Icons.send_outlined,
                          color: appColorThird,
                          action: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (formKey.currentState!.validate()) {
                              controller.storeMessage({
                                "message": message.text,
                              });
                              message.text = "";
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget chatItem(
    MessageSupportModel message, {
    double? mt,
  }) {
    bool mine = true;
    Color background = appColorThirdOpacity;
    if (controller.user.value?.role.name == "client") {
      mine = message.user == null && message.system == false;
    } else {
      mine = message.user?.id == controller.user.value?.id;
    }
    if (!mine) {
      background = (message.user == null && !message.system)
          ? appColorSecondary.withOpacity(0.1)
          : appBackgroundOpacity;
    }
    return GestureDetector(
      onLongPress: () {
        if (mine || message.message is String) {
          controller.showBottomSheet(
            message,
            showDelete: mine && controller.support.value?.isActive() == true,
          );
        }
      },
      child: Column(
        crossAxisAlignment:
            mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: BoxConstraints(
              minWidth: 100,
              maxWidth: Get.width - 100,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            margin: EdgeInsets.only(
              top: mt ?? 0,
            ),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
                bottomLeft: Radius.circular(mine ? 10 : 0),
                bottomRight: Radius.circular(mine ? 0 : 10),
              ),
            ),
            child: Column(
              crossAxisAlignment:
                  mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                textBdp(
                  message.message,
                  align: TextAlign.left,
                  textHeight: 1.2,
                  size: 13,
                ),
                sourceItem(
                  source: message.source,
                  background: background == appBackgroundOpacity
                      ? appColorThirdOpacity
                      : appBackgroundOpacity,
                ),
                const SizedBox(
                  height: 5,
                ),
                titleBdp(
                  dateDifferenceHumans(message.createdAt),
                  color: appColorThird,
                  size: 12,
                  weight: FontWeight.normal,
                ),
                Visibility(
                  visible: !mine,
                  child: () {
                    String owner = "BDP";
                    if (!message.system) {
                      if (message.user is UserModel) {
                        owner = message.user!.chatUser();
                      } else {
                        owner = controller.support.value!.user.chatUser();
                      }
                    }
                    return titleBdp(
                      owner,
                      size: 12,
                      weight: FontWeight.normal,
                    );
                  }(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sourceItem({
    FileModel? source,
    Color? background,
  }) {
    Widget? content;
    Function? action;
    double pd = 0;
    if (source is FileModel) {
      if (source.isImage()) {
        content = CachedNetworkImage(
          imageUrl: source.url,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
        action = () {
          controller.showImage(source);
        };
      } else {
        pd = 10;
        content = Row(
          children: [
            iconRounded(
              Icons.download_outlined,
              mr: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width,
                    child: titleBdp(
                      source.originalName,
                      size: 14,
                      align: TextAlign.left,
                      weight: FontWeight.normal,
                    ),
                  ),
                  titleBdp(
                    getFileSize(source.size),
                    color: appColorThird,
                    size: 12,
                    weight: FontWeight.normal,
                  ),
                ],
              ),
            ),
          ],
        );
        action = () {
          controller.showDownload(source.url);
        };
      }
    }
    return containerBdp(
      child: content,
      ph: pd,
      pv: pd,
      backgroundColor: background ?? appBackgroundOpacity,
      action: action,
    );
  }
}
