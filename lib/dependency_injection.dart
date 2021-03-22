import 'package:get/get.dart';
import 'package:scrapper_test/scrapping_controller.dart';
import 'package:scrapper_test/scrapping_provider.dart';
import 'package:scrapper_test/scrapping_repository.dart';

class DependencyInjection {
  static void init() {
    Get.lazyPut<RyansScrapper>(
      () => RyansScrapper(),
    );
    Get.lazyPut<StartechScrapper>(
      () => StartechScrapper(),
    );
    Get.lazyPut<ScrappingRepository>(
      () => ScrappingRepository(),
    );
    Get.lazyPut<ScrappingController>(
      () => ScrappingController(),
    );
  }
}
