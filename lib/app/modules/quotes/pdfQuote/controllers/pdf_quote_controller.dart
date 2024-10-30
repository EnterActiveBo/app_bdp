import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/quote_model.dart';
import 'package:appbdp/app/models/user_model.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pdf/pdf.dart';

class PdfQuoteController extends GetxController {
  final Rx<QuoteModel?> quote = (null as QuoteModel?).obs;
  final Rx<UserModel?> user = (null as UserModel?).obs;
  final Rx<String?> logo = (null as String?).obs;
  final PdfColor primaryColor = PdfColor.fromHex(appColorPrimary.toHex());
  final PdfColor secondaryColor = PdfColor.fromHex(appColorSecondary.toHex());
  final PdfColor thirdColor = PdfColor.fromHex(appColorThird.toHex());
  final PdfColor textColor = PdfColor.fromHex(appTextNormal.toHex());
  final PdfColor whiteColor = PdfColor.fromHex(appColorWhite.toHex());
  final PdfColor transparent = PdfColor.fromHex(appColorTransparent.toHex());

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    quote.value = null;
    super.onClose();
  }

  setQuote(
    QuoteModel quoteValue,
    UserModel userValue,
  ) {
    quote.value = quoteValue;
    user.value = userValue;
  }

  setLogo(String? value) {
    logo.value = value;
  }
}
