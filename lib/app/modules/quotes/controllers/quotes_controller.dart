import 'package:appbdp/app/common/storage_box.dart';
import 'package:appbdp/app/common/widgets/loader_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/providers/quote_provider.dart';
import 'package:appbdp/app/models/providers/user_provider.dart';
import 'package:appbdp/app/models/quote_model.dart';
import 'package:appbdp/app/models/user_model.dart';
import 'package:appbdp/app/modules/quotes/pdfQuote/controllers/pdf_quote_controller.dart';
import 'package:appbdp/app/modules/quotes/views/item_form_dialog_view.dart';
import 'package:appbdp/app/modules/quotes/views/new_view.dart';
import 'package:appbdp/app/modules/quotes/views/quotes_list_view.dart';
import 'package:appbdp/app/modules/quotes/views/seller_view.dart';
import 'package:appbdp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class QuotesController extends GetxController with GetTickerProviderStateMixin {
  GetStorage box = GetStorage('App');
  final QuoteProvider quoteProvider = Get.find();
  final PdfQuoteController pdfQuoteController = Get.find();
  String quoteKey = 'quotes';
  final RxList<QuoteModel> quotes = (List<QuoteModel>.of([])).obs;
  String newQuoteKey = 'newQuote';
  final Rx<QuoteModel> newQuote = QuoteModel(items: []).obs;
  final loadingQuotes = true.obs;
  final UserProvider userProvider = Get.find();
  String userKey = 'user';
  final Rx<UserModel?> user = (null as UserModel?).obs;
  final loadingUser = true.obs;
  // Tabs definition
  final Rx<TabController?> tabController = (null as TabController?).obs;
  List<Tab> enableTabs = <Tab>[
    const Tab(
      text: "Nueva",
    ),
    const Tab(
      text: "Cotizaciones",
    ),
    const Tab(
      text: "Vendedor",
    ),
  ];
  List<Widget> tabContents = <Widget>[
    const NewView(),
    const QuotesListView(),
    const SellerView(),
  ];

  //seller form
  final name = TextEditingController();
  final address = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final terms = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    tabController.value = TabController(
      vsync: this,
      length: enableTabs.length,
    );
    initData();
  }

  @override
  void onClose() {
    super.onClose();
    loadingQuotes.value = true;
    loadingUser.value = true;
  }

  initData() {
    initQuotes();
    initNewQuote();
    initUser();
  }

  initQuotes() {
    quotes.value = quotesStored(box);
    getQuotes();
  }

  getQuotes() async {
    List<QuoteModel>? quotesResponse = await quoteProvider.getQuotes();
    loadingQuotes.value = false;
    if (quotesResponse is List<QuoteModel>) {
      quotes.value = quotesResponse;
      box.write(quoteKey, quotesResponse);
    }
  }

  initNewQuote() {
    newQuote.value = newQuoteStored(box);
  }

  showItemDialog({
    int? index,
    ItemQuoteModel? item,
  }) {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    Get.dialog(
      barrierDismissible: false,
      ItemFormDialogView(
        index: index,
        item: item,
      ),
    );
  }

  itemAction(
    ItemQuoteModel item, {
    int? index,
  }) {
    if (index is int) {
      newQuote.value.items[index] = item;
    } else {
      newQuote.value.items.add(item);
    }
    refreshNewQuote(newQuote.value);
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  showDeleteItem(
    int index,
  ) {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    Get.dialog(
      dialogBdp(
        icon: Icons.delete_outline,
        iconColor: appErrorColor,
        title: '¿Eliminar item?',
        btnText: 'Sí, eliminar',
        btnBackgroundColor: appErrorColor,
        action: () {
          deleteItem(index);
        },
      ),
    );
  }

  deleteItem(int index) {
    newQuote.value.items.removeAt(index);
    refreshNewQuote(newQuote.value);
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  refreshNewQuote(QuoteModel newData) {
    box.write(newQuoteKey, newData);
    newQuote.value = newQuoteStored(box);
    newQuote.refresh();
  }

  bool cleanNewQuote() {
    bool cleaned = false;
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    Get.dialog(
      dialogBdp(
        icon: Icons.cleaning_services_outlined,
        title: '¿Limpiar cotización?',
        btnText: 'Sí, limpiar',
        action: () {
          cleaned = true;
          refreshNewQuote(
            QuoteModel(items: []),
          );
          Get.back();
        },
      ),
    );
    return cleaned;
  }

  saveQuote(Map data) async {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    Get.dialog(
      dialogBdp(
        icon: Icons.save_outlined,
        title: 'Crear nueva cotización?',
        btnText: 'Sí, crear',
        action: () async {
          Get.dialog(
            barrierDismissible: false,
            loadingDialog(),
          );
          bool success = await quoteProvider.setQuote(data);
          Get.dialog(
            dialogBdp(
              icon: success ? Icons.check_outlined : Icons.error_outlined,
              title: success
                  ? "Cotización Guardada Exitosamente"
                  : "Error al Guardar Cotización",
              btnText: success ? "Ver Cotizaciones" : null,
              action: () {
                Get.back();
                tabController.value!.animateTo(1);
                loadingQuotes.value = true;
                getQuotes();
              },
            ),
          );
          if (success) {
            getQuotes();
            refreshNewQuote(
              QuoteModel(items: []),
            );
          }
        },
      ),
    );
  }

  initUser() {
    user.value = userStored(box);
    setSellerData();
    getUser();
  }

  getUser() async {
    UserModel? userResponse = await userProvider.getProfile();
    if (userResponse is UserModel) {
      user.value = userResponse;
      box.write(userKey, userResponse);
      setSellerData();
    }
  }

  setSellerData() {
    if (user.value?.seller is SellerModel) {
      name.text = user.value?.seller?.name ?? "";
      address.text = user.value?.seller?.address ?? "";
      phone.text = user.value?.seller?.phone ?? "";
      email.text = user.value?.seller?.email ?? "";
      terms.text = user.value?.seller?.terms ?? "";
    }
  }

  saveSeller(Map data) async {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    Get.dialog(
      dialogBdp(
        icon: Icons.save_outlined,
        title: '¿Guardar datos?',
        btnText: 'Sí, guardar',
        action: () async {
          Get.dialog(
            barrierDismissible: false,
            loadingDialog(),
          );
          bool success = await quoteProvider.setSeller(data);
          if (success) {
            getUser();
          }
          Get.dialog(
            dialogBdp(
              icon: success ? Icons.check_outlined : Icons.error_outlined,
              title: success
                  ? "Datos Guardados Exitosamente"
                  : "Error al Guardar Datos",
            ),
          );
        },
      ),
    );
  }

  String? getToken() {
    return box.read('token');
  }

  setPdfQuote(QuoteModel value) {
    pdfQuoteController.setQuote(
      value,
      user.value!,
    );
    Get.toNamed(Routes.PDF_QUOTE);
  }
}
