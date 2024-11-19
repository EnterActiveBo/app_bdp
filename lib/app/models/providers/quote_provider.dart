import 'package:appbdp/app/common/http_config.dart';
import 'package:appbdp/app/constants/api.const.dart';
import 'package:appbdp/app/models/quote_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class QuoteProvider extends GetConnect {
  GetStorage box = GetStorage('App');

  @override
  void onInit() {
    httpClient.baseUrl = urlV1;
    httpDefaultConfiguration(httpClient, box);
  }

  Future<List<QuoteModel>?> getQuotes() async {
    final response = await get('quotes');
    if (response.body != null && response.body['data'] is List) {
      return List<QuoteModel>.from(
        response.body['data'].map(
          (item) {
            return QuoteModel.fromJson(item);
          },
        ).toList(),
      );
    }
    return null;
  }

  Future<bool> setQuote(Map data) async {
    final response = await post('quotes', data);
    return response.isOk;
  }

  Future<bool> setSeller(Map data) async {
    final response = await post('seller', data);
    return response.isOk;
  }
}
