import 'dart:typed_data';

import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/quote_model.dart';
import 'package:appbdp/app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../controllers/pdf_quote_controller.dart';

class PdfQuoteView extends GetView<PdfQuoteController> {
  const PdfQuoteView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBdpView(
        primary: true,
        title: "Cotización PDF",
      ),
      body: PdfPreview(
        initialPageFormat: PdfPageFormat.letter,
        allowPrinting: false,
        canDebug: false,
        maxPageWidth: 700,
        pageFormats: const <String, PdfPageFormat>{
          'Carta': PdfPageFormat.letter,
          'A4': PdfPageFormat.a4,
        },
        pdfFileName: "${simpleUid(controller.quote.value!.id!)}.pdf",
        loadingWidget: const CircularProgressIndicator(
          color: appColorSecondary,
        ),
        scrollViewDecoration: const BoxDecoration(
          color: appColorWhite,
        ),
        build: (format) {
          return _generatePdf(format, controller.quote.value!);
        },
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, QuoteModel quote) async {
    final pdf = pw.Document();
    String logo = await rootBundle.loadString('assets/images/header_logo.svg');
    controller.setLogo(logo);
    final fontTitle = await PdfGoogleFonts.exo2Regular();

    pdf.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          format,
          fontTitle,
        ),
        header: _buildHeader,
        build: (context) => [
          _contentHeader(context),
          _contentTable(context),
          pw.SizedBox(height: 20),
          _contentFooter(context),
          pw.SizedBox(height: 20),
          _termsAndConditions(context),
        ],
      ),
    );

    return pdf.save();
  }

  pw.PageTheme _buildTheme(
    PdfPageFormat pageFormat,
    pw.Font bold,
  ) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        bold: bold,
      ),
    );
  }

  pw.Widget _buildHeader(pw.Context context) {
    String? logo = controller.logo.value;
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Container(
                    height: 50,
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      'Cotización',
                      style: pw.TextStyle(
                        color: controller.primaryColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      borderRadius: const pw.BorderRadius.all(
                        pw.Radius.circular(2),
                      ),
                      color: controller.thirdColor,
                    ),
                    padding: const pw.EdgeInsets.only(
                      left: 20,
                      top: 10,
                      bottom: 10,
                      right: 20,
                    ),
                    alignment: pw.Alignment.centerLeft,
                    height: 50,
                    child: pw.DefaultTextStyle(
                      style: pw.TextStyle(
                        color: controller.whiteColor,
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                      ),
                      child: pw.GridView(
                        crossAxisCount: 2,
                        children: [
                          pw.Text('Cotización:'),
                          pw.Text(
                            simpleUid(controller.quote.value!.id!),
                            maxLines: 1,
                          ),
                          pw.Text('Fecha:'),
                          pw.Text(dateBdp(controller.quote.value!.quoteAt)!),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.Expanded(
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Container(
                    alignment: pw.Alignment.topRight,
                    padding: const pw.EdgeInsets.only(bottom: 8, left: 30),
                    height: 72,
                    child: logo != null ? pw.SvgImage(svg: logo) : pw.PdfLogo(),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (context.pageNumber > 1) pw.SizedBox(height: 20)
      ],
    );
  }

  pw.Widget _contentHeader(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Container(
            margin: const pw.EdgeInsets.symmetric(horizontal: 20),
            // padding: const pw.EdgeInsets.only(right: 5),
            height: 65,
            child: pw.FittedBox(
              child: pw.Text(
                'Total: Bs ${priceFormat(controller.quote.value!.total())}',
                style: pw.TextStyle(
                  color: controller.primaryColor,
                  // fontStyle: pw.FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
        pw.Expanded(
          child: pw.Row(
            children: [
              pw.Container(
                margin: const pw.EdgeInsets.only(left: 10, right: 10),
                height: 70,
                child: pw.Text(
                  'Comprador:',
                  style: pw.TextStyle(
                    color: controller.primaryColor,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Container(
                  height: 70,
                  child: pw.RichText(
                    text: pw.TextSpan(
                      text: "${controller.quote.value!.buyer}",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = [
      '#',
      'Ítem',
      'Precio [Bs]',
      'Cantidad',
      'Total [Bs]',
    ];

    return pw.TableHelper.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
        color: controller.primaryColor,
      ),
      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.center,
        4: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
        color: controller.whiteColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: controller.primaryColor,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        controller.quote.value!.items.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => controller.quote.value!.items[row].getIndex(
            col,
            indexItem: row,
          ),
        ),
      ),
    );
  }

  pw.Widget _contentFooter(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 8),
                child: pw.Text(
                  'Información del Vendedor:',
                  style: pw.TextStyle(
                    color: controller.user.value?.seller is SellerModel
                        ? controller.primaryColor
                        : controller.transparent,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                controller.user.value?.seller?.name ?? "",
                style: pw.TextStyle(
                  fontSize: 8,
                  lineSpacing: 5,
                  color: controller.user.value?.seller is SellerModel
                      ? null
                      : controller.transparent,
                ),
              ),
              pw.Text(
                controller.user.value?.seller?.address ?? "",
                style: pw.TextStyle(
                  fontSize: 8,
                  lineSpacing: 5,
                  color: controller.user.value?.seller is SellerModel
                      ? null
                      : controller.transparent,
                ),
              ),
              pw.Text(
                controller.user.value?.seller?.phone ?? "",
                style: pw.TextStyle(
                  fontSize: 8,
                  lineSpacing: 5,
                  color: controller.user.value?.seller is SellerModel
                      ? null
                      : controller.transparent,
                ),
              ),
              pw.Text(
                controller.user.value?.seller?.email ?? "",
                style: pw.TextStyle(
                  fontSize: 8,
                  lineSpacing: 5,
                  color: controller.user.value?.seller is SellerModel
                      ? null
                      : controller.transparent,
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          flex: 1,
          child: pw.DefaultTextStyle(
            style: pw.TextStyle(
              fontSize: 10,
              color: controller.primaryColor,
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.DefaultTextStyle(
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Total Bs:'),
                      pw.Text(
                        priceFormat(
                          controller.quote.value!.total(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _termsAndConditions(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border(
                    top: pw.BorderSide(
                      color: controller.primaryColor,
                    ),
                  ),
                ),
                padding: const pw.EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                ),
                child: pw.Text(
                  'Términos y Condiciones',
                  style: pw.TextStyle(
                    fontSize: 7,
                    color: controller.primaryColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                pw.LoremText().paragraph(40),
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: 5,
                  lineSpacing: 2,
                  color: controller.textColor,
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.SizedBox(),
        ),
      ],
    );
  }
}
