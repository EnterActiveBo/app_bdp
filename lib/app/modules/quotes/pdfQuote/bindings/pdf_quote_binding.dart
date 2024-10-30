import 'package:get/get.dart';

import '../controllers/pdf_quote_controller.dart';

class PdfQuoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PdfQuoteController>(
      () => PdfQuoteController(),
    );
  }
}
