import 'package:get/get.dart';
import 'package:scrapper_test/product_model.dart';
import 'package:scrapper_test/scrapping_repository.dart';

class ScrappingController extends GetxController {
  final ScrappingRepository _repository = Get.find<ScrappingRepository>();
  static RxInt _page = 1.obs;
  static RxString _category = 'casing'.obs;

  Stream<List<BasicProductModel>> getData() {
    return _repository.getData(
      page: _page.value,
      category: _category.value.toString(),
    );
  }

  Future<bool> checkNextPageAvailibility() {
    return _repository.checkNextPageAvailibility(
      page: _page.value + 1,
      category: _category.value.toString(),
    );
  }

  int getPageNum() {
    return _page.value;
  }

  String getCategory() {
    return _category.value.toString();
  }

  changeCategory(String cat) {
    _category.value = cat;
  }

  _setPageNum(page) {
    _page.value = page;
    print('Page Changed to ${_page.value}');
  }

  goToNextPage() {
    _setPageNum(_page.value + 1);
    print('To Page ${_page.value}');
  }

  goToPrevPage() {
    if (_page.value > 1) {
      _setPageNum(_page.value - 1);
      print('To Page ${_page.value}');
    }
  }
}
