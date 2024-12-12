import 'package:appbdp/app/common/widgets/input_widgets.dart';
import 'package:appbdp/app/common/widgets/items_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/supplier_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/material.dart';

class ItemSupplierView extends StatefulWidget {
  final SupplierModel supplier;
  final double? mt;
  final void Function() action;
  const ItemSupplierView({
    super.key,
    required this.supplier,
    required this.action,
    this.mt,
  });
  @override
  ItemSupplierViewState createState() => ItemSupplierViewState();
}

class ItemSupplierViewState extends State<ItemSupplierView> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    OfficeModel central = widget.supplier.offices.firstWhere(
      (office) => office.head,
      orElse: () => widget.supplier.offices.first,
    );
    List<Widget> phones = officeExtra(central, 'phones');
    List<Widget> emails = officeExtra(central, 'emails');
    List<Widget> schedules = officeExtra(central, 'schedules');
    Widget leadingWidget = Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: appColorThird,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        "assets/images/icons/proveedores.svg",
        colorFilter: const ColorFilter.mode(
          appColorWhite,
          BlendMode.srcIn,
        ),
        width: 50,
        height: 50,
      ),
    );
    if (widget.supplier.image is FileModel) {
      leadingWidget = Container(
        decoration: const BoxDecoration(
          color: appColorThird,
          shape: BoxShape.circle,
        ),
        clipBehavior: Clip.antiAlias,
        child: CachedNetworkImage(
          imageUrl: "${widget.supplier.image?.url}",
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      );
    }
    return Container(
      margin: EdgeInsets.only(
        top: widget.mt ?? 0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: appBackgroundOpacity,
      ),
      child: ExpansionTile(
        initiallyExpanded: false,
        childrenPadding: const EdgeInsets.only(
          top: 0,
          left: 5,
          right: 5,
          bottom: 10,
        ),
        tilePadding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        leading: leadingWidget,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: widget.supplier.offices.isNotEmpty,
              child: titleBdp(
                widget.supplier.getDepartment(),
                color: appColorThird,
                size: 14,
                textHeight: 0,
              ),
            ),
            titleBdp(
              widget.supplier.title,
              align: TextAlign.left,
            ),
          ],
        ),
        subtitle: textBdp(
          widget.supplier.detail,
          overflow: TextOverflow.ellipsis,
          align: TextAlign.left,
          max: 2,
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
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                iconTextActionBdp(
                  title: central.address,
                ),
                SizedBox(
                  height: phones.isNotEmpty ? 5 : 0,
                ),
                Visibility(
                  visible: phones.isNotEmpty,
                  child: iconTextActionBdp(
                    icon: Icons.phone_android_outlined,
                    contentWidget: Column(
                      children: phones,
                    ).expand(),
                  ),
                ),
                SizedBox(
                  height: emails.isNotEmpty ? 5 : 0,
                ),
                Visibility(
                  visible: emails.isNotEmpty,
                  child: iconTextActionBdp(
                    icon: Icons.alternate_email_outlined,
                    contentWidget: Column(
                      children: emails,
                    ).expand(),
                  ),
                ),
                SizedBox(
                  height: schedules.isNotEmpty ? 5 : 0,
                ),
                Visibility(
                  visible: schedules.isNotEmpty,
                  child: iconTextActionBdp(
                    icon: Icons.calendar_month_outlined,
                    contentWidget: Column(
                      children: schedules,
                    ).expand(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                buttonBdp(
                  "Ver Más",
                  () {
                    widget.action();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
