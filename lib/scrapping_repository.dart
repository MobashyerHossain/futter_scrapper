import 'package:get/get.dart';
import 'package:scrapper_test/constants.dart';
import 'package:scrapper_test/product_model.dart';
import 'package:scrapper_test/providers/ryans_scrapper_provider.dart';
import 'package:scrapper_test/providers/stars_scrapper_provider.dart';

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
              .getAllProductInfo(
                page: page,
                category: category,
              )
              .asStream();
        }
      case Constants.WEBSITE_STARTECH:
        {
          print(site);
          return _starScrapper
              .getAllProductInfo(
                page: page,
                category: category,
              )
              .asStream();
        }
      default:
        {
          print(site);
          return _starScrapper
              .getAllProductInfo(
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
          return _ryanScrapper.checkNextPage(
            page: page,
            category: category,
          );
        }
      case Constants.WEBSITE_STARTECH:
        {
          return _starScrapper.checkNextPage(
            page: page,
            category: category,
          );
        }
      default:
        {
          return _starScrapper.checkNextPage(
            page: page,
            category: category,
          );
        }
    }
  }
}
