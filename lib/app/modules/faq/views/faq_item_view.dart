import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/faq_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class FaqItemView extends StatefulWidget {
  final FaqModel faq;
  final double? mt;
  const FaqItemView({
    super.key,
    required this.faq,
    this.mt,
  });

  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<FaqItemView> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: widget.mt ?? 0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: appBackground,
      ),
      child: ExpansionTile(
        initiallyExpanded: false,
        childrenPadding: const EdgeInsets.only(
          top: 0,
          left: 5,
          right: 5,
          bottom: 10,
        ),
        title: HtmlWidget(
          widget.faq.question,
          textStyle: const TextStyle(
            fontFamily: "exo2",
            color: appColorPrimary,
            fontSize: 17,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
        trailing: Icon(
          isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          color: appColorThird,
          size: 30,
        ),
        onExpansionChanged: (t) {
          setState(
            () {
              isExpanded = !isExpanded;
            },
          );
        },
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: HtmlWidget(
              widget.faq.answer,
              textStyle: const TextStyle(
                color: appTextNormal,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
