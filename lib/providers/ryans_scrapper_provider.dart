import 'package:get/get.dart';
import 'package:scrapper_test/constants.dart';
import 'package:scrapper_test/error_page.dart';
import 'package:scrapper_test/product_model.dart';
import 'package:scrapper_test/providers/scrapping_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:web_scraper/web_scraper.dart';

class RyansScrapper extends Scrapper {
  @override
  getBasicProductData({
    required page,
    required category,
  }) async {
    final webScraper = WebScraper(Constants.RYANS_BASE_URL);
    List<Map<String, dynamic>> nameAndUrls = [];
    List<Map<String, dynamic>> thumbnails = [];
    List<Map<String, dynamic>> prices = [];
    List<BasicProductModel> products = [];
    var uuid = Uuid();

    try {
      var url = Constants.RYANS_PRODUCT_INDEX_URL
          .replaceAll('[1]', '${Constants.RYANS_CATEGORY_LIST[category]}')
          .replaceAll('[2]', '$page');
      print(url);
      if (await webScraper.loadWebPage(url)) {
        nameAndUrls = webScraper.getElement(
          'div.product-content-info > a.product-title-grid',
          ['href'],
        );

        thumbnails = webScraper.getElement(
          'div.product-thumb > a > img',
          ['src'],
        );

        prices = webScraper.getElement(
          'div.price-label > div.special-price > span',
          [],
        );

        for (var i = 0; i < nameAndUrls.length; i++) {
          products.add(
            BasicProductModel.fromMap(
              {
                'id': uuid.v5(
                  Uuid.NAMESPACE_URL,
                  Constants.RYANS_PRODUCT_INDEX_URL +
                      '/item=$i'
                          .replaceAll('[1]', '$category')
                          .replaceAll('[2]', '$page'),
                ),
                'title': nameAndUrls[i]['title'],
                'url': nameAndUrls[i]['attributes']['href'],
                'thumb': thumbnails[i]['attributes']['src'],
                'price': int.parse(
                  prices[i]['title'].replaceAll(RegExp('[^0-9]'), ''),
                ),
              },
            ),
          );
        }
        print('Scrapping Succesful');
      } else {
        print('Scrapping Unsuccesful');
        throw Exception('Api Connection Failed');
      }
    } catch (e) {
      Get.to(
        () => ErrorPage(
          error: Exception('Check Your Internet Connection! $e'),
        ),
      );
    }

    return products;
  }

  @override
  checkNextPageAvailibility({
    required page,
    required category,
  }) async {
    final webScraper = WebScraper(Constants.RYANS_BASE_URL);
    try {
      var url = Constants.RYANS_PRODUCT_INDEX_URL
          .replaceAll('[1]', '${Constants.RYANS_CATEGORY_LIST[category]}')
          .replaceAll('[2]', '$page');

      if (await webScraper.loadWebPage(url)) {
        var prices = webScraper.getElement(
          'div.price-label > div.special-price > span',
          [],
        );

        if (prices.length > 0) {
          return Future<bool>.value(true);
        } else {
          return Future<bool>.value(false);
        }
      } else {
        return Future<bool>.value(false);
      }
    } catch (e) {
      return Future<bool>.value(false);
    }
  }
}
