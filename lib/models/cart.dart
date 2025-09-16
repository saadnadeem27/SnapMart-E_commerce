import '../models/product.dart';

class CartItem {
  final String id;
  final Product product;
  final int quantity;
  final DateTime addedAt;
  final Map<String, dynamic> selectedVariants;

  CartItem({
    required this.id,
    required this.product,
    this.quantity = 1,
    DateTime? addedAt,
    this.selectedVariants = const {},
  }) : addedAt = addedAt ?? DateTime.now();

  double get totalPrice => product.price * quantity;
  double get totalOriginalPrice => product.originalPrice * quantity;
  double get totalSavings => totalOriginalPrice - totalPrice;

  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
    DateTime? addedAt,
    Map<String, dynamic>? selectedVariants,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt ?? this.addedAt,
      selectedVariants: selectedVariants ?? this.selectedVariants,
    );
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] ?? '',
      product: Product.fromJson(json['product'] ?? {}),
      quantity: json['quantity'] ?? 1,
      addedAt:
          DateTime.parse(json['addedAt'] ?? DateTime.now().toIso8601String()),
      selectedVariants:
          Map<String, dynamic>.from(json['selectedVariants'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'quantity': quantity,
      'addedAt': addedAt.toIso8601String(),
      'selectedVariants': selectedVariants,
    };
  }
}

class Cart {
  final List<CartItem> items;
  final DateTime lastUpdated;

  Cart({
    this.items = const [],
    DateTime? lastUpdated,
  }) : lastUpdated = lastUpdated ?? DateTime.now();

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);

  double get totalSavings =>
      items.fold(0, (sum, item) => sum + item.totalSavings);

  double get shipping => subtotal > 100 ? 0 : 10; // Free shipping above $100

  double get tax => subtotal * 0.08; // 8% tax

  double get total => subtotal + shipping + tax;

  bool get isEmpty => items.isEmpty;

  bool get isNotEmpty => items.isNotEmpty;

  CartItem? findItem(String productId) {
    try {
      return items.firstWhere((item) => item.product.id == productId);
    } catch (e) {
      return null;
    }
  }

  bool hasProduct(String productId) => findItem(productId) != null;

  Cart addItem(Product product,
      {int quantity = 1, Map<String, dynamic>? variants}) {
    final existingItem = findItem(product.id);

    if (existingItem != null) {
      // Update quantity of existing item
      final updatedItems = items.map((item) {
        if (item.product.id == product.id) {
          return item.copyWith(quantity: item.quantity + quantity);
        }
        return item;
      }).toList();

      return Cart(items: updatedItems, lastUpdated: DateTime.now());
    } else {
      // Add new item
      final newItem = CartItem(
        id: '${product.id}_${DateTime.now().millisecondsSinceEpoch}',
        product: product,
        quantity: quantity,
        selectedVariants: variants ?? {},
      );

      return Cart(
        items: [...items, newItem],
        lastUpdated: DateTime.now(),
      );
    }
  }

  Cart updateItemQuantity(String itemId, int quantity) {
    if (quantity <= 0) {
      return removeItem(itemId);
    }

    final updatedItems = items.map((item) {
      if (item.id == itemId) {
        return item.copyWith(quantity: quantity);
      }
      return item;
    }).toList();

    return Cart(items: updatedItems, lastUpdated: DateTime.now());
  }

  Cart removeItem(String itemId) {
    final updatedItems = items.where((item) => item.id != itemId).toList();
    return Cart(items: updatedItems, lastUpdated: DateTime.now());
  }

  Cart clear() {
    return Cart(items: [], lastUpdated: DateTime.now());
  }

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      items: (json['items'] as List?)
              ?.map((item) => CartItem.fromJson(item))
              .toList() ??
          [],
      lastUpdated: DateTime.parse(
        json['lastUpdated'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}
