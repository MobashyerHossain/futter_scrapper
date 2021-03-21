import 'dart:convert';

class ProductModel {
  String id;
  String title;
  String url;
  String thumb;
  String price;
  ProductModel({
    required this.id,
    required this.title,
    required this.url,
    required this.thumb,
    required this.price,
  });

  ProductModel copyWith({
    String? id,
    String? title,
    String? url,
    String? thumb,
    String? price,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      thumb: thumb ?? this.thumb,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'thumb': thumb,
      'price': price,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
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
    return 'ProductModel(id: $id, title: $title, url: $url, thumb: $thumb, price: $price)';
  }

  static ProductModel sampleModel() {
    return ProductModel(
      id: 'id',
      title: 'title',
      url: 'url.com',
      thumb: 'thum.com',
      price: 'price',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.id == id &&
        other.title == title &&
        other.url == url &&
        other.thumb == thumb &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        url.hashCode ^
        thumb.hashCode ^
        price.hashCode;
  }
}
