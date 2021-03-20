import 'dart:convert';

class ProductModel {
  String title;
  String url;
  String imgUrl;
  String price;
  ProductModel({
    required this.title,
    required this.url,
    required this.imgUrl,
    required this.price,
  });

  ProductModel copyWith({
    String? title,
    String? url,
    String? imgUrl,
    String? price,
  }) {
    return ProductModel(
      title: title ?? this.title,
      url: url ?? this.url,
      imgUrl: imgUrl ?? this.imgUrl,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
      'imgUrl': imgUrl,
      'price': price,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      title: map['title'],
      url: map['url'],
      imgUrl: map['imgUrl'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(title: $title, url: $url, imgUrl: $imgUrl, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.title == title &&
        other.url == url &&
        other.imgUrl == imgUrl &&
        other.price == price;
  }

  @override
  int get hashCode {
    return title.hashCode ^ url.hashCode ^ imgUrl.hashCode ^ price.hashCode;
  }
}
