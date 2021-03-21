import 'package:get/get.dart';
import 'package:scrapper_test/product_model.dart';
import 'package:scrapper_test/scrapping_page.dart';
import 'package:scrapper_test/scrapping_repository.dart';

class ScrappingController extends GetxController {
  final ScrappingRepository _repository = Get.find<ScrappingRepository>();
  static RxInt _page = 1.obs;

  Stream<List<ProductModel>> getData() {
    return _repository
        .getData(
          page: _page.value,
        )
        .asStream();
  }

  int getPageNum() {
    return _page.value;
  }

  goToNextPage() {
    _page.value += 1;
    print('To Page ${_page.value}');
    Get.offAll(
      () => ScrappingPage(),
      transition: Transition.fadeIn,
    );
  }

  goToPrevPage() {
    if (_page.value > 1) {
      _page.value -= 1;
      print('To Page ${_page.value}');
      Get.offAll(
        () => ScrappingPage(),
        transition: Transition.fadeIn,
      );
    }
  }
}
