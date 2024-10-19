import 'package:appbdp/app/common/storage_box.dart';
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

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    faq.value = faqStored(box);
    getFaq();
  }

  getFaq() async {
    List<FaqModel>? faqResponse = await faqProvider.getFaq();
    if (faqResponse is List<FaqModel>) {
      box.write(faqKey, faqResponse);
    }
  }

  setSearch(String? value) {
    search.value = value == "" ? null : value;
  }
}
