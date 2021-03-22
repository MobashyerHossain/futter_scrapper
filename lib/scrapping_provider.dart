import 'package:get/get.dart';
import 'package:scrapper_test/constants.dart';
import 'package:scrapper_test/error_page.dart';
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

class StartechScrapper extends Scrapper {
  @override
  getBasicProductData({
    required page,
    required category,
  }) async {
    final webScraper = WebScraper(Constants.STARTECH_BASE_URL);
    List<Map<String, dynamic>> nameAndUrls = [];
    List<Map<String, dynamic>> thumbnails = [];
    List<Map<String, dynamic>> prices = [];
    List<BasicProductModel> products = [];
    var uuid = Uuid();

    try {
      if (await webScraper.loadWebPage(
        Constants.STARTECH_PRODUCT_INDEX_URL
            .replaceAll('[1]', '$category')
            .replaceAll('[2]', '$page'),
      )) {
        nameAndUrls = webScraper.getElement(
          'h4.product-name > a',
          ['href'],
        );

        thumbnails = webScraper.getElement(
          'div.product-thumb > div.img-holder > a > img',
          ['src'],
        );

        prices = webScraper.getElement(
          'div.price > span',
          [],
        );

        for (var i = 0; i < nameAndUrls.length; i++) {
          products.add(
            BasicProductModel.fromMap(
              {
                'id': uuid.v5(
                  Uuid.NAMESPACE_URL,
                  Constants.STARTECH_PRODUCT_INDEX_URL +
                      '/item=$i'
                          .replaceAll('[1]', '$category')
                          .replaceAll('[2]', '$page'),
                ),
                'title': nameAndUrls[i]['title'],
                'url': nameAndUrls[i]['attributes']['href'],
                'thumb': thumbnails[i]['attributes']['src'],
                'price': int.parse(
                  prices[i * 2]['title'].replaceAll(RegExp('[^0-9]'), ''),
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
          error: Exception('Check Your Internet Connection!/n $e'),
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
    final webScraper = WebScraper(Constants.STARTECH_BASE_URL);
    try {
      if (await webScraper.loadWebPage(
        Constants.STARTECH_PRODUCT_INDEX_URL
            .replaceAll('[1]', '$category')
            .replaceAll('[2]', '$page'),
      )) {
        var prices = webScraper.getElement(
          'div.price > span',
          [],
        );
        if (prices.length > 0) {
          print('Next Check Succcessful');
          return Future<bool>.value(true);
        } else {
          print('Next Check Unsucccessful');
          return Future<bool>.value(false);
        }
      } else {
        print('WebPage Loading Unsucccessful');
        return Future<bool>.value(false);
      }
    } catch (e) {
      print('Exception : $e');
      return Future<bool>.value(false);
    }
  }
}

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
      if (await webScraper.loadWebPage(
        Constants.RYANS_PRODUCT_INDEX_URL
            .replaceAll('[1]', '$category')
            .replaceAll('[2]', '$page'),
      )) {
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
      if (await webScraper.loadWebPage(
        Constants.RYANS_PRODUCT_INDEX_URL
            .replaceAll('[1]', '$category')
            .replaceAll('[2]', '$page'),
      )) {
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
