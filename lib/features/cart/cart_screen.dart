import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../models/product.dart';
import '../../models/cart.dart';
import '../../shared/widgets/glassmorphism_card.dart';
import '../../shared/widgets/gradient_button.dart';
import '../checkout/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  // Sample cart data
  final List<CartItem> _cartItems = [
    CartItem(
      id: '1',
      product: Product(
        id: '1',
        name: 'Premium Wireless Headphones',
        description: 'High-quality wireless headphones with noise cancellation',
        price: 199.99,
        originalPrice: 249.99,
        imageUrl:
            'https://images.unsplash.com/photo-1505740420928-5e560c06d30e',
        category: 'Electronics',
        rating: 4.8,
        reviewCount: 124,
      ),
      quantity: 1,
    ),
    CartItem(
      id: '2',
      product: Product(
        id: '2',
        name: 'Smart Fitness Watch',
        description: 'Advanced fitness tracking with heart rate monitor',
        price: 299.99,
        originalPrice: 399.99,
        imageUrl:
            'https://images.unsplash.com/photo-1523275335684-37898b6baf30',
        category: 'Electronics',
        rating: 4.6,
        reviewCount: 89,
      ),
      quantity: 2,
    ),
    CartItem(
      id: '3',
      product: Product(
        id: '3',
        name: 'Designer Backpack',
        description: 'Stylish and functional backpack for everyday use',
        price: 89.99,
        originalPrice: 119.99,
        imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62',
        category: 'Fashion',
        rating: 4.7,
        reviewCount: 67,
      ),
      quantity: 1,
    ),
  ];

  bool _isLoading = false;
  String? _promoCode;
  double _promoDiscount = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),

              // Content
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppDimensions.radiusXL),
                      topRight: Radius.circular(AppDimensions.radiusXL),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppDimensions.radiusXL),
                      topRight: Radius.circular(AppDimensions.radiusXL),
                    ),
                    child: Column(
                      children: [
                        // Cart Items
                        Expanded(
                          child: _cartItems.isEmpty
                              ? _buildEmptyCart()
                              : _buildCartContent(),
                        ),

                        // Bottom Summary
                        if (_cartItems.isNotEmpty) _buildBottomSummary(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: Row(
        children: [
          // Back Button
          Container(
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.white,
              ),
            ),
          ),

          const SizedBox(width: AppDimensions.paddingM),

          // Title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppStrings.shoppingCart,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${_cartItems.length} items',
                  style: TextStyle(
                    color: AppColors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Clear Cart Button
          if (_cartItems.isNotEmpty)
            TextButton(
              onPressed: _showClearCartDialog,
              child: Text(
                AppStrings.clear,
                style: TextStyle(
                  color: AppColors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: const Duration(milliseconds: 600))
        .slideY(begin: -0.2);
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty Cart Icon
            Container(
              padding: const EdgeInsets.all(AppDimensions.paddingXL),
              decoration: BoxDecoration(
                gradient: AppColors.secondaryGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 80,
                color: AppColors.white,
              ),
            )
                .animate()
                .scale(duration: const Duration(milliseconds: 600))
                .fadeIn(),

            const SizedBox(height: AppDimensions.paddingXL),

            // Empty Message
            const Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            )
                .animate()
                .fadeIn(delay: const Duration(milliseconds: 200))
                .slideY(begin: 0.2),

            const SizedBox(height: AppDimensions.paddingM),

            Text(
              'Add some products to get started',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            )
                .animate()
                .fadeIn(delay: const Duration(milliseconds: 400))
                .slideY(begin: 0.2),

            const SizedBox(height: AppDimensions.paddingXL),

            // Continue Shopping Button
            GradientButton(
              text: 'Continue Shopping',
              onPressed: () => Navigator.pop(context),
            )
                .animate()
                .fadeIn(delay: const Duration(milliseconds: 600))
                .slideY(begin: 0.2),
          ],
        ),
      ),
    );
  }

  Widget _buildCartContent() {
    return Column(
      children: [
        // Cart Items List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(AppDimensions.paddingL),
            itemCount: _cartItems.length,
            itemBuilder: (context, index) {
              return _buildCartItem(_cartItems[index], index);
            },
          ),
        ),

        // Promo Code Section
        _buildPromoCodeSection(),
      ],
    );
  }

  Widget _buildCartItem(CartItem item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingM),
      child: Slidable(
        key: ValueKey(item.id),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            // Save for Later
            SlidableAction(
              onPressed: (context) => _saveForLater(item),
              backgroundColor: AppColors.info,
              foregroundColor: AppColors.white,
              icon: Icons.bookmark_add,
              label: 'Save',
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppDimensions.radiusM),
                bottomLeft: Radius.circular(AppDimensions.radiusM),
              ),
            ),
            // Delete
            SlidableAction(
              onPressed: (context) => _removeItem(item),
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.white,
              icon: Icons.delete,
              label: AppStrings.delete,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(AppDimensions.radiusM),
                bottomRight: Radius.circular(AppDimensions.radiusM),
              ),
            ),
          ],
        ),
        child: GlassmorphismCard(
          child: Row(
            children: [
              // Product Image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  color: AppColors.lightDivider,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  child: Image.network(
                    item.product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: const BoxDecoration(
                          gradient: AppColors.secondaryGradient,
                        ),
                        child: const Icon(
                          Icons.image,
                          color: AppColors.white,
                          size: 32,
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(width: AppDimensions.paddingM),

              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 4),

                    // Price
                    Row(
                      children: [
                        Text(
                          '\$${item.product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryViolet,
                          ),
                        ),
                        if (item.product.hasDiscount) ...[
                          const SizedBox(width: 8),
                          Text(
                            '\$${item.product.originalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough,
                              color:
                                  Theme.of(context).textTheme.bodySmall?.color,
                            ),
                          ),
                        ],
                      ],
                    ),

                    const SizedBox(height: AppDimensions.paddingS),

                    // Quantity Controls
                    Row(
                      children: [
                        _buildQuantityButton(
                          icon: Icons.remove,
                          onPressed: item.quantity > 1
                              ? () => _updateQuantity(item, item.quantity - 1)
                              : null,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingS,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingM,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.lightDivider),
                            borderRadius:
                                BorderRadius.circular(AppDimensions.radiusS),
                          ),
                          child: Text(
                            item.quantity.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        _buildQuantityButton(
                          icon: Icons.add,
                          onPressed: () =>
                              _updateQuantity(item, item.quantity + 1),
                        ),

                        const Spacer(),

                        // Total Price
                        Text(
                          '\$${item.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryViolet,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .slideX(
          begin: 0.2,
          delay: Duration(milliseconds: index * 100),
          duration: const Duration(milliseconds: 400),
        )
        .fadeIn();
  }

  Widget _buildQuantityButton({
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        gradient: onPressed != null ? AppColors.secondaryGradient : null,
        color: onPressed == null ? AppColors.lightDivider : null,
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 16,
          color: onPressed != null
              ? AppColors.white
              : AppColors.lightSecondaryText,
        ),
      ),
    );
  }

  Widget _buildPromoCodeSection() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: GlassmorphismCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Promo Code',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingM),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter promo code',
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusM),
                        borderSide: BorderSide(color: AppColors.lightDivider),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusM),
                        borderSide: BorderSide(color: AppColors.lightDivider),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusM),
                        borderSide: BorderSide(
                            color: AppColors.primaryViolet, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingM,
                        vertical: AppDimensions.paddingS,
                      ),
                    ),
                    onChanged: (value) => _promoCode = value,
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingM),
                GradientButton(
                  text: AppStrings.apply,
                  width: 80,
                  height: 40,
                  onPressed: _applyPromoCode,
                ),
              ],
            ),
            if (_promoDiscount > 0) ...[
              const SizedBox(height: AppDimensions.paddingM),
              Container(
                padding: const EdgeInsets.all(AppDimensions.paddingS),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.success,
                      size: 20,
                    ),
                    const SizedBox(width: AppDimensions.paddingS),
                    Text(
                      'Promo applied! Save \$${_promoDiscount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppColors.success,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSummary() {
    final subtotal = _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
    final shipping = subtotal > 100 ? 0.0 : 10.0;
    final tax = subtotal * 0.08;
    final total = subtotal + shipping + tax - _promoDiscount;

    return Container(
      padding: EdgeInsets.only(
        left: AppDimensions.paddingL,
        right: AppDimensions.paddingL,
        top: AppDimensions.paddingL,
        bottom: MediaQuery.of(context).padding.bottom + AppDimensions.paddingL,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Order Summary
          GlassmorphismCard(
            child: Column(
              children: [
                _buildSummaryRow(
                    'Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
                _buildSummaryRow(
                    'Shipping',
                    shipping == 0
                        ? 'Free'
                        : '\$${shipping.toStringAsFixed(2)}'),
                _buildSummaryRow('Tax', '\$${tax.toStringAsFixed(2)}'),
                if (_promoDiscount > 0)
                  _buildSummaryRow('Promo Discount',
                      '-\$${_promoDiscount.toStringAsFixed(2)}',
                      color: AppColors.success),
                const Divider(),
                _buildSummaryRow(
                  'Total',
                  '\$${total.toStringAsFixed(2)}',
                  isTotal: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.paddingL),

          // Checkout Button
          GradientButton(
            text: '${AppStrings.checkout} - \$${total.toStringAsFixed(2)}',
            onPressed: _proceedToCheckout,
            isLoading: _isLoading,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value,
      {bool isTotal = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: color,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: FontWeight.bold,
              color: color ?? (isTotal ? AppColors.primaryViolet : null),
            ),
          ),
        ],
      ),
    );
  }

  void _updateQuantity(CartItem item, int newQuantity) {
    setState(() {
      final index = _cartItems.indexWhere((cartItem) => cartItem.id == item.id);
      if (index != -1) {
        _cartItems[index] = item.copyWith(quantity: newQuantity);
      }
    });
  }

  void _removeItem(CartItem item) {
    setState(() {
      _cartItems.removeWhere((cartItem) => cartItem.id == item.id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.product.name} removed from cart'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _cartItems.add(item);
            });
          },
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
      ),
    );
  }

  void _saveForLater(CartItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.product.name} saved for later'),
        backgroundColor: AppColors.info,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
      ),
    );
  }

  void _applyPromoCode() {
    if (_promoCode?.toUpperCase() == 'SAVE20') {
      setState(() {
        _promoDiscount = 20.0;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Invalid promo code'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
        ),
      );
    }
  }

  void _showClearCartDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text(
            'Are you sure you want to remove all items from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _cartItems.clear();
              });
            },
            child: const Text(
              AppStrings.clear,
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
      ),
    );
  }

  void _proceedToCheckout() async {
    setState(() => _isLoading = true);

    // Simulate processing
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isLoading = false);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CheckoutScreen(),
      ),
    );
  }
}
