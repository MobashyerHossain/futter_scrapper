import 'package:get/get.dart';
import 'package:scrapper_test/error_page.dart';
import 'package:scrapper_test/product_model.dart';
import 'package:uuid/uuid.dart';
import 'package:web_scraper/web_scraper.dart';

const baseUrl = 'https://www.startech.com.bd';

class Scrapper {
  // startech
  Future<List<ProductModel>> getData({required int page}) async {
    final webScraper = WebScraper(baseUrl);
    List<Map<String, dynamic>> nameAndUrls = [];
    List<Map<String, dynamic>> thumbnails = [];
    List<Map<String, dynamic>> prices = [];
    List<ProductModel> products = [];
    var uuid = Uuid();

    try {
      if (await webScraper.loadWebPage('/component/casing?page=$page')) {
        nameAndUrls = webScraper.getElement('h4.product-name > a', ['href']);

        thumbnails = webScraper.getElement(
            'div.product-thumb > div.img-holder > a > img', ['src']);

        prices = webScraper.getElement('div.price > span', []);

        for (var i = 0; i < nameAndUrls.length; i++) {
          products.add(
            ProductModel.fromMap(
              {
                'id': uuid.v5(
                  Uuid.NAMESPACE_URL,
                  "${webScraper.baseUrl}/component/casing?page=$page/$i",
                ),
                'title': nameAndUrls[i]['title'],
                'url': nameAndUrls[i]['attributes']['href'],
                'thumb': thumbnails[i]['attributes']['src'],
                'price': prices[i * 2]['title'],
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
          error: e,
        ),
      );
    }

    return products;
  }
}
