import 'package:appbdp/app/models/providers/quote_provider.dart';
import 'package:appbdp/app/models/providers/user_provider.dart';
import 'package:appbdp/app/modules/quotes/pdfQuote/controllers/pdf_quote_controller.dart';
import 'package:get/get.dart';

import '../controllers/quotes_controller.dart';

class QuotesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProvider>(
      () => UserProvider(),
    );
    Get.lazyPut<QuoteProvider>(
      () => QuoteProvider(),
    );
    Get.lazyPut<PdfQuoteController>(
      () => PdfQuoteController(),
    );
    Get.put<QuotesController>(
      QuotesController(),
    );
  }
}
