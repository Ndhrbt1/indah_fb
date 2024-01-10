import 'dart:convert';

class Product {
  final String id;
  final String name;
  final int price;
  final String description;
  final String imageUrl;
  final String createdAt;
  Product({
    this.id = '',
    this.name = '',
    this.price = 0,
    this.description = '',
    this.imageUrl = '',
    this.createdAt = '',
  });

  Product copyWith({
    String? id,
    String? name,
    int? price,
    String? description,
    String? imageUrl,
    String? createdAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'price': price});
    result.addAll({'description': description});
    result.addAll({'image_url': imageUrl});
    result.addAll({'created_at': createdAt});

    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: map['price']?.toInt() ?? 0,
      description: map['description'] ?? '',
      imageUrl: map['image_url'] ?? '',
      createdAt: map['created_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, description: $description, imageUrl: $imageUrl, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.price == price &&
        other.description == description &&
        other.imageUrl == imageUrl &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ price.hashCode ^ description.hashCode ^ imageUrl.hashCode ^ createdAt.hashCode;
  }
}
