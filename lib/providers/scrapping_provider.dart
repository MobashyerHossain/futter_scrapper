import 'package:scrapper_test/product_model.dart';
import 'package:uuid/uuid.dart';
import 'package:web_scraper/web_scraper.dart';

abstract class Scrapper {
  Future<List<BasicProductModel>> getBasicProductData({
    required page,
    required category,
  }) async {
    final webScraper = WebScraper('x.com');
    List<Map<String, dynamic>> nameAndUrls = [];
    List<Map<String, dynamic>> thumbnails = [];
    List<Map<String, dynamic>> prices = [];
    List<BasicProductModel> products = [];
    var uuid = Uuid();

    try {
      if (await webScraper.loadWebPage('/abc')) {
        for (var i = 0; i < 20; i++) {
          products.add(
            BasicProductModel(
              id: uuid.v5(Uuid.NAMESPACE_URL, 'x'),
              title: nameAndUrls[i]['name'],
              url: nameAndUrls[i]['url'],
              price: int.parse(prices[i]['price']),
              thumb: thumbnails[i]['thumb'],
            ),
          );
        }
        // Scrapping data
      }
    } catch (e) {
      print(e);
    }
    return products;
  }

  Future<List<BasicProductModel>> getDetailProductData({
    required String productUrl,
  }) async {
    return [
      BasicProductModel.sampleModel(),
    ];
  }

  Future<bool> checkNextPageAvailibility({
    required page,
    required category,
  }) {
    return Future.value(false);
  }
}
