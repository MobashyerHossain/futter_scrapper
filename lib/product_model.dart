import 'dart:convert';

class ProductModel {
  String title;
  String url;
  String thumb;
  String price;
  ProductModel({
    required this.title,
    required this.url,
    required this.thumb,
    required this.price,
  });

  ProductModel copyWith({
    String? title,
    String? url,
    String? thumb,
    String? price,
  }) {
    return ProductModel(
      title: title ?? this.title,
      url: url ?? this.url,
      thumb: thumb ?? this.thumb,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
      'thumb': thumb,
      'price': price,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      title: map['title'],
      url: map['url'],
      thumb: map['thumb'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(title: $title, url: $url, thumb: $thumb, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.title == title &&
        other.url == url &&
        other.thumb == thumb &&
        other.price == price;
  }

  @override
  int get hashCode {
    return title.hashCode ^ url.hashCode ^ thumb.hashCode ^ price.hashCode;
  }
}
