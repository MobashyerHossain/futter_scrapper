import 'package:get/get.dart';
import 'package:scrapper_test/constants.dart';
import 'package:scrapper_test/product_model.dart';
import 'package:scrapper_test/scrapping_provider.dart';

class ScrappingRepository {
  final RyansScrapper _ryanScrapper = Get.find<RyansScrapper>();
  final StartechScrapper _starScrapper = Get.find<StartechScrapper>();

  Stream<List<BasicProductModel>> getData({
    required int page,
    required String category,
    required String site,
  }) {
    switch (site) {
      case Constants.WEBSITE_RYANS:
        {
          print(site);
          return _ryanScrapper
              .getBasicProductData(
                page: page,
                category: category,
              )
              .asStream();
        }
      case Constants.WEBSITE_STARS:
        {
          print(site);
          return _starScrapper
              .getBasicProductData(
                page: page,
                category: category,
              )
              .asStream();
        }
      default:
        {
          print(site);
          return _starScrapper
              .getBasicProductData(
                page: page,
                category: category,
              )
              .asStream();
        }
    }
  }

  Future<bool> checkNextPageAvailibility({
    required int page,
    required String category,
    required String site,
  }) {
    // ignore: unrelated_type_equality_checks
    switch (site) {
      case Constants.WEBSITE_RYANS:
        {
          return _ryanScrapper.checkNextPageAvailibility(
            page: page,
            category: category,
          );
        }
      case Constants.WEBSITE_STARS:
        {
          return _starScrapper.checkNextPageAvailibility(
            page: page,
            category: category,
          );
        }
      default:
        {
          return _starScrapper.checkNextPageAvailibility(
            page: page,
            category: category,
          );
        }
    }
  }
}
