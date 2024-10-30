import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/query_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/quote_model.dart';
import 'package:appbdp/app/modules/quotes/controllers/quotes_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class QuotesListView extends GetView<QuotesController> {
  const QuotesListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        child: Column(
          children: [
            SingleChildScrollView(
              child: () {
                List<QuoteModel> quotes = controller.quotes;
                return queryBdpWidget(
                  !controller.loadingQuotes.value && quotes.isNotEmpty,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: quotes.asMap().entries.map(
                      (quote) {
                        return containerBdp(
                          mt: quote.key == 0 ? 0 : 15,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  titleBdp(
                                    "Cotización: ${quote.value.buyer}",
                                    align: TextAlign.left,
                                  ),
                                  textBdp(
                                    dateBdp(quote.value.quoteAt),
                                    color: appTextNormal,
                                  ),
                                ],
                              ).expand(),
                              iconButton(
                                Icons.arrow_forward_ios_outlined,
                                action: () {
                                  controller.setPdfQuote(quote.value);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  loading: controller.loadingQuotes.value,
                );
              }(),
            ).expand(),
          ],
        ),
      ),
    );
  }
}
