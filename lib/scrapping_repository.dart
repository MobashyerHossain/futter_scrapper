import 'package:get/get.dart';
import 'package:scrapper_test/product_model.dart';
import 'package:scrapper_test/scrapping_provider.dart';

class ScrappingRepository {
  final StartechScrapper _scrapper = Get.find<StartechScrapper>();

  Stream<List<BasicProductModel>> getData({
    required int page,
    required String category,
  }) {
    return _scrapper
        .getBasicProductData(
          page: page,
          category: category,
        )
        .asStream();
  }

  Future<bool> checkNextPageAvailibility({
    required int page,
    required String category,
  }) {
    // ignore: unrelated_type_equality_checks
    return _scrapper.checkNextPageAvailibility(
      page: page,
      category: category,
    );
  }
}
