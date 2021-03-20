import 'package:get/get.dart';
import 'package:scrapper_test/product_model.dart';
import 'package:scrapper_test/scrapping_provider.dart';

class ScrappingRepository {
  final Scrapper _scrapper = Get.find<Scrapper>();

  Future<List<ProductModel>> getData({required int page}) {
    return _scrapper.getData(
      page: page,
    );
  }
}
