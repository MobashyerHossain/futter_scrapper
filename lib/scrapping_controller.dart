import 'package:get/get.dart';
import 'package:scrapper_test/constants.dart';
import 'package:scrapper_test/product_model.dart';
import 'package:scrapper_test/scrapping_repository.dart';

class ScrappingController extends GetxController {
  final ScrappingRepository _repository = Get.find<ScrappingRepository>();
  static RxInt _page = 1.obs;
  static RxString _site = Constants.WEBSITE_RYANS.toString().obs;
  static RxString _category = Constants
      .CATEGORY_LIST[_site.value.toString()]!.entries.first.key
      .toString()
      .obs;

  Stream<List<BasicProductModel>> getData() {
    return _repository.getData(
      page: _page.value,
      category: _category.value.toString(),
      site: _site.value.toString(),
    );
  }

  Future<bool> checkNextPageAvailibility() {
    return _repository.checkNextPageAvailibility(
      page: _page.value + 1,
      category: _category.value.toString(),
      site: _site.value.toString(),
    );
  }

  int getPageNum() {
    return _page.value;
  }

  String getCategory() {
    return _category.toString();
  }

  String getCategoryHR([String? cat]) {
    if (cat != null) {
      return cat.toString().replaceAll('_', ' ').capitalize.toString();
    }
    return _category.toString().replaceAll('_', ' ').capitalize.toString();
  }

  String getWebSite() {
    return _site.value.toString();
  }

  setCategory(String cat) {
    _page.value = 1;
    _category.value = cat;
  }

  setWebSite(String site) {
    print('go to $site');
    _site.value = site;
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
