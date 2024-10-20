import 'package:appbdp/app/common/storage_box.dart';
import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/models/faq_model.dart';
import 'package:appbdp/app/models/providers/faq_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FaqController extends GetxController {
  GetStorage box = GetStorage('App');
  String faqKey = 'faq';
  FaqProvider faqProvider = Get.find();
  final RxList<FaqModel> faq = (List<FaqModel>.of([])).obs;
  final Rx<String?> search = (null as String?).obs;
  final loading = true.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  @override
  void onClose() {
    super.onClose();
    loading.value = true;
    search.value = null;
  }

  initData() {
    faq.value = faqStored(box);
    getFaq();
  }

  getFaq() async {
    List<FaqModel>? faqResponse = await faqProvider.getFaq();
    loading.value = false;
    if (faqResponse is List<FaqModel>) {
      faq.value = faqResponse;
      box.write(faqKey, faqResponse);
    }
  }

  setSearch(String? value) {
    search.value = value == "" ? null : value;
  }

  List<FaqModel> filterFaq() {
    return faq.where((faq) {
      bool filter = true;
      if (search.value is String) {
        filter &= searchString(
          removeAllHtmlTags(faq.question),
          search.value,
        );
        filter |= searchString(
          removeAllHtmlTags(faq.answer),
          search.value,
        );
      }
      return filter;
    }).toList();
  }
}
