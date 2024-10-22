import 'package:appbdp/app/models/providers/quote_provider.dart';
import 'package:appbdp/app/models/providers/user_provider.dart';
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
    Get.put<QuotesController>(
      QuotesController(),
    );
  }
}
