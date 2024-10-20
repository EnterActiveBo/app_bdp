import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/query_widgets.dart';
import 'package:appbdp/app/models/faq_model.dart';
import 'package:appbdp/app/modules/faq/views/faq_item_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/faq_controller.dart';

class FaqView extends GetView<FaqController> {
  const FaqView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final search = TextEditingController();
    final FocusNode searchFocusNode = FocusNode();

    return Scaffold(
      appBar: const HeaderBdpView(
        primary: true,
        title: "Preguntas Frecuentes",
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          child: Column(
            children: [
              searchFilter(
                formKey,
                search: search,
                searchFocusNode: searchFocusNode,
                isFilter: controller.search.value is String,
                searchAction: (value) {
                  controller.setSearch(value);
                },
                action: () {
                  if (controller.search.value is String) {
                    controller.setSearch(null);
                    search.text = "";
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: () {
                  List<FaqModel> faq = controller.filterFaq();
                  return queryBdpWidget(
                    (!controller.loading.value && faq.isNotEmpty),
                    ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: faq.length,
                      itemBuilder: (context, index) {
                        FaqModel item = faq[index];
                        return FaqItemView(
                          faq: item,
                          mt: index == 0 ? 0 : 15,
                        );
                      },
                    ),
                    loading: controller.loading.value,
                  );
                }(),
              ).expand(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBdpView(),
    );
  }
}
