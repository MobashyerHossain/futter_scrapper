import 'package:get/get.dart';
import 'package:scrapper_test/product_model.dart';
import 'package:scrapper_test/scrapping_provider.dart';

class ScrappingRepository {
  final RyansScrapper _scrapper = Get.find<RyansScrapper>();

  Stream<List<BasicProductModel>> getData({required int page}) {
    return _scrapper
        .getBasicProductData(
          page: page,
          productType: 'mouse',
        )
        .asStream();
  }

  Future<bool> checkNextPageAvailibility({required int page}) {
    // ignore: unrelated_type_equality_checks
    return _scrapper.checkNextPageAvailibility(
      page: page,
    );
  }
}
