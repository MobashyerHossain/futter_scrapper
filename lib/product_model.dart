import 'dart:convert';

class BasicProductModel {
  String id;
  String title;
  String url;
  String thumb;
  int price;
  BasicProductModel({
    required this.id,
    required this.title,
    required this.url,
    required this.thumb,
    required this.price,
  });

  BasicProductModel copyWith({
    String? id,
    String? title,
    String? url,
    String? thumb,
    int? price,
  }) {
    return BasicProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      thumb: thumb ?? this.thumb,
      price: price ?? this.price,
    );
  }

  static BasicProductModel sampleModel() {
    return BasicProductModel(
      id: 'id',
      title: 'title',
      url: 'url.com',
      thumb: 'thum.com',
      price: 0,
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

  factory BasicProductModel.fromMap(Map<String, dynamic> map) {
    return BasicProductModel(
      id: map['id'],
      title: map['title'],
      url: map['url'],
      thumb: map['thumb'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BasicProductModel.fromJson(String source) =>
      BasicProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BasicProductModel(id: $id, title: $title, url: $url, thumb: $thumb, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BasicProductModel &&
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
