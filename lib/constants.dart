class Constants {
  static const WEBSITE_LIST = {
    'stars': 'Star Tech',
    'ryans': 'Ryans Computers',
  };

  static const WEBSITE_STARS = 'stars';
  static const WEBSITE_RYANS = 'ryans';

  static const STARTECH_BASE_URL = 'https://www.startech.com.bd';
  static const STARTECH_PRODUCT_INDEX_URL = '/[1]?limit=20&page=[2]';
  static const STARTECH_CATEGORY_LIST = {
    'casing': 'component/casing',
    'casing_cooler': 'component/casing-cooler',
    'power_supply': 'component/power-supply',
    'cpu': 'component/processor',
    'cpu_cooler': 'component/CPU-Cooler',
    'motherboard': 'component/motherboard',
    'graphics_card': 'component/graphics-card',
    'hdd': 'component/hard-disk-drive',
    'ssd': 'component/SSD-Hard-Disk',
    'ram': 'component/ram',
    'keyboards': 'accessories/keyboards',
    'mouse': 'accessories/mouse',
    'headphone': 'accessories/headphone',
    'speaker': 'accessories/speaker-and-home-theater',
    'ups': 'ups-ips',
  };

  static const RYANS_BASE_URL = 'https://www.ryanscomputers.com/';
  static const RYANS_PRODUCT_INDEX_URL = '/category/[1]?limit=20&page=[2]';
  static const RYANS_CATEGORY_LIST = {
    'casing': 'desktop-component-casing',
    'casing_cooler': 'desktop-component-casing-fan',
    'power_supply': 'desktop-component-power-supply',
    'cpu': 'desktop-component-processor',
    'cpu_cooler': 'desktop-component-cpu-cooler',
    'motherboard': 'desktop-component-mainboard',
    'graphics_card': 'desktop-component-graphics-card',
    'hdd': 'internal-hdd',
    'ssd': 'internal-ssd',
    'ram': 'desktop-component-desktop-ram',
    'keyboards': 'desktop-component-keyboard',
    'mouse': 'desktop-component-mouse',
    'headphone': 'sound-system-headphone',
    'speaker': 'sound-system-speaker',
    'ups': 'desktop-component-ups',
  };

  static const CATEGORY_LIST = {
    'stars': Constants.STARTECH_CATEGORY_LIST,
    'ryans': Constants.RYANS_CATEGORY_LIST,
  };
}
