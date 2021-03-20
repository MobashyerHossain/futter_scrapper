import 'package:money2/money2.dart';
import 'package:scrapper_test/product_model.dart';
import 'package:web_scraper/web_scraper.dart';

const baseUrl = 'https://www.startech.com.bd';

class Scrapper {
  Future<List<ProductModel>> getData({required int page}) async {
    final webScraper = WebScraper(baseUrl);
    List<Map<String, dynamic>> nameAndUrls = [];
    List<Map<String, dynamic>> thumbnails = [];
    List<Map<String, dynamic>> prices = [];
    List<ProductModel> products = [];

    if (await webScraper.loadWebPage('/component/casing?page=$page')) {
      nameAndUrls = webScraper.getElement('h4.product-name > a', ['href']);

      thumbnails = webScraper
          .getElement('div.product-thumb > div.img-holder > a > img', ['src']);

      prices = webScraper.getElement('div.price > span', []);

      for (var i = 0; i < nameAndUrls.length; i++) {
        products.add(
          ProductModel.fromMap(
            {
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
      throw Exception('Scrapping Unsuccesful');
    }

    return products;
  }
}
