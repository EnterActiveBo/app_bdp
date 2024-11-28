import 'package:appbdp/app/models/providers/quiz_provider.dart';
import 'package:get/get.dart';

import '../controllers/quiz_controller.dart';

class QuizBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizProvider>(
      () => QuizProvider(),
    );
    Get.put<QuizController>(
      QuizController(),
    );
  }
}
