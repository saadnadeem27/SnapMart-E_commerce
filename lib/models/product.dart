class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double originalPrice;
  final String imageUrl;
  final List<String> images;
  final String category;
  final double rating;
  final int reviewCount;
  final int stockQuantity;
  final bool isInStock;
  final bool isFavorite;
  final List<String> tags;
  final Map<String, dynamic> specifications;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
    this.images = const [],
    required this.category,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.stockQuantity = 0,
    this.isInStock = true,
    this.isFavorite = false,
    this.tags = const [],
    this.specifications = const {},
  });

  double get discountPercentage {
    if (originalPrice <= 0) return 0;
    return ((originalPrice - price) / originalPrice) * 100;
  }

  bool get hasDiscount => originalPrice > price;

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? originalPrice,
    String? imageUrl,
    List<String>? images,
    String? category,
    double? rating,
    int? reviewCount,
    int? stockQuantity,
    bool? isInStock,
    bool? isFavorite,
    List<String>? tags,
    Map<String, dynamic>? specifications,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      imageUrl: imageUrl ?? this.imageUrl,
      images: images ?? this.images,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      isInStock: isInStock ?? this.isInStock,
      isFavorite: isFavorite ?? this.isFavorite,
      tags: tags ?? this.tags,
      specifications: specifications ?? this.specifications,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      originalPrice: (json['originalPrice'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      category: json['category'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      stockQuantity: json['stockQuantity'] ?? 0,
      isInStock: json['isInStock'] ?? true,
      isFavorite: json['isFavorite'] ?? false,
      tags: List<String>.from(json['tags'] ?? []),
      specifications: Map<String, dynamic>.from(json['specifications'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'originalPrice': originalPrice,
      'imageUrl': imageUrl,
      'images': images,
      'category': category,
      'rating': rating,
      'reviewCount': reviewCount,
      'stockQuantity': stockQuantity,
      'isInStock': isInStock,
      'isFavorite': isFavorite,
      'tags': tags,
      'specifications': specifications,
    };
  }
}

class ProductCategory {
  final String id;
  final String name;
  final String icon;
  final String imageUrl;
  final int productCount;
  final bool isPopular;

  ProductCategory({
    required this.id,
    required this.name,
    required this.icon,
    this.imageUrl = '',
    this.productCount = 0,
    this.isPopular = false,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      productCount: json['productCount'] ?? 0,
      isPopular: json['isPopular'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'imageUrl': imageUrl,
      'productCount': productCount,
      'isPopular': isPopular,
    };
  }
}
