import 'package:appbdp/app/constants/api.const.dart';

class QuoteModel {
  String? id;
  String? buyer;
  DateTime? quoteAt;
  List<ItemQuoteModel> items;

  QuoteModel({
    this.id,
    this.buyer,
    this.quoteAt,
    required this.items,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      id: json['id'],
      buyer: json['buyer'],
      quoteAt: json['quoteAt'] != null
          ? DateTime.parse(json['quoteAt']).toLocal()
          : null,
      items: json['items'] != null
          ? List<ItemQuoteModel>.from(
              json['items'].map((x) => ItemQuoteModel.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['buyer'] = buyer;
    data['quoteAt'] = quoteAt?.toString();
    data['items'] = items.map((x) => x.toJson()).toList();
    return data;
  }

  double total() {
    if (items.isNotEmpty) {
      return items
          .map(
            (i) => i.total(),
          )
          .reduce(
            (total, i) => total + i,
          );
    }
    return 0;
  }

  String downloadUrl() {
    return "${urlV1}quotes/$id/download";
  }
}

class ItemQuoteModel {
  String item;
  int quantity;
  double price;

  ItemQuoteModel({
    required this.item,
    required this.quantity,
    required this.price,
  });

  factory ItemQuoteModel.fromJson(Map<String, dynamic> json) {
    return ItemQuoteModel(
      item: json['item'],
      quantity: json['quantity'],
      price: (json['price'] is String)
          ? double.parse(json['price'])
          : (json['price'] + .0),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['item'] = item;
    data['quantity'] = quantity;
    data['price'] = price.toString();
    return data;
  }

  double total() {
    return price * quantity;
  }
}
