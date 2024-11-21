import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/quote_model.dart';
import 'package:appbdp/app/models/user_model.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class PdfQuoteController extends GetxController {
  final Rx<QuoteModel?> quote = (null as QuoteModel?).obs;
  final Rx<UserModel?> user = (null as UserModel?).obs;
  final Rx<String?> logo = (null as String?).obs;
  final Rx<ImageProvider?> imageSeller = (null as ImageProvider?).obs;
  final PdfColor primaryColor = PdfColor.fromHex(appColorPrimary.toHex());
  final PdfColor secondaryColor = PdfColor.fromHex(appColorSecondary.toHex());
  final PdfColor thirdColor = PdfColor.fromHex(appColorThird.toHex());
  final PdfColor textColor = PdfColor.fromHex(appTextNormal.toHex());
  final PdfColor whiteColor = PdfColor.fromHex(appColorWhite.toHex());
  final PdfColor transparent = PdfColor.fromHex(appColorTransparent.toHex());

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
    getSellerImage(userValue);
  }

  setLogo(String? value) {
    logo.value = value;
  }

  getSellerImage(UserModel? userValue) async {
    if (userValue is UserModel &&
        userValue.seller is SellerModel &&
        userValue.seller!.image is FileModel) {
      imageSeller.value = await networkImage(userValue.seller!.image!.url);
    }
  }
}
