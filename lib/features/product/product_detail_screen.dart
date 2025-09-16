import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../models/product.dart';
import '../../shared/widgets/glassmorphism_card.dart';
import '../../shared/widgets/gradient_button.dart';
import '../cart/cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late ScrollController _scrollController;
  int _currentImageIndex = 0;
  int _quantity = 1;
  bool _isFavorite = false;
  bool _isAddingToCart = false;
  double _scrollOffset = 0;

  final List<String> _productImages = [
    'https://images.unsplash.com/photo-1505740420928-5e560c06d30e',
    'https://images.unsplash.com/photo-1484704849700-f032a568e944',
    'https://images.unsplash.com/photo-1583394838336-acd977736f90',
    'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1',
  ];

  final List<Map<String, dynamic>> _reviews = [
    {
      'name': 'Sarah Johnson',
      'rating': 5.0,
      'comment':
          'Amazing quality! Exceeded my expectations. The sound quality is crystal clear and the battery life is fantastic.',
      'date': '2 days ago',
      'avatar': 'S',
    },
    {
      'name': 'Mike Chen',
      'rating': 4.0,
      'comment':
          'Great product overall. Good value for money. Only minor issue is the packaging could be better.',
      'date': '1 week ago',
      'avatar': 'M',
    },
    {
      'name': 'Emma Davis',
      'rating': 5.0,
      'comment':
          'Love it! Perfect for my daily workouts. Comfortable fit and excellent noise cancellation.',
      'date': '2 weeks ago',
      'avatar': 'E',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main Content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Custom App Bar with Image Carousel
              _buildSliverAppBar(),

              // Product Details
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppDimensions.radiusXL),
                      topRight: Radius.circular(AppDimensions.radiusXL),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProductInfo(),
                      _buildQuantitySelector(),
                      _buildDescription(),
                      _buildSpecifications(),
                      _buildReviews(),
                      const SizedBox(
                          height: 100), // Space for sticky bottom bar
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Floating App Bar
          _buildFloatingAppBar(),

          // Sticky Bottom Action Bar
          _buildStickyBottomBar(),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 400,
      backgroundColor: Colors.transparent,
      elevation: 0,
      pinned: false,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            // Image Carousel
            CarouselSlider(
              options: CarouselOptions(
                height: 400,
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                onPageChanged: (index, reason) {
                  setState(() => _currentImageIndex = index);
                },
              ),
              items: _productImages.map((image) {
                return Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: AppColors.primaryGradient,
                  ),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: const BoxDecoration(
                          gradient: AppColors.secondaryGradient,
                        ),
                        child: const Icon(
                          Icons.image,
                          size: 80,
                          color: AppColors.white,
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            ),

            // Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.black.withOpacity(0.3),
                      AppColors.transparent,
                      AppColors.black.withOpacity(0.1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),

            // Image Indicators
            Positioned(
              bottom: AppDimensions.paddingL,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _productImages.asMap().entries.map((entry) {
                  return Container(
                    width: _currentImageIndex == entry.key ? 24 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      gradient: _currentImageIndex == entry.key
                          ? AppColors.secondaryGradient
                          : null,
                      color: _currentImageIndex == entry.key
                          ? null
                          : AppColors.white.withOpacity(0.5),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingAppBar() {
    final opacity = (_scrollOffset / 300).clamp(0.0, 1.0);

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).padding.top + kToolbarHeight,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient.scale(opacity),
        ),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
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

                // Title (appears when scrolled) - wrapped in Expanded to prevent overflow
                Expanded(
                  child: AnimatedOpacity(
                    opacity: opacity,
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      widget.product.name,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                // Share & Favorite Buttons
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.share_outlined,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.paddingS),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () =>
                            setState(() => _isFavorite = !_isFavorite),
                        icon: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: _isFavorite ? Colors.red : AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Name
          Text(
            widget.product.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 600))
              .slideY(begin: 0.2),

          const SizedBox(height: AppDimensions.paddingS),

          // Rating and Reviews
          Row(
            children: [
              RatingBarIndicator(
                rating: widget.product.rating,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20,
              ),
              const SizedBox(width: AppDimensions.paddingS),
              Text(
                '${widget.product.rating} (${widget.product.reviewCount} reviews)',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 800))
              .slideY(begin: 0.2),

          const SizedBox(height: AppDimensions.paddingL),

          // Price Section
          GlassmorphismCard(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              '\$${widget.product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryViolet,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (widget.product.hasDiscount) ...[
                            const SizedBox(width: AppDimensions.paddingS),
                            Flexible(
                              child: Text(
                                '\$${widget.product.originalPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 18,
                                  decoration: TextDecoration.lineThrough,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.color,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (widget.product.hasDiscount)
                        Container(
                          margin: const EdgeInsets.only(
                              top: AppDimensions.paddingS),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingS,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            gradient: AppColors.secondaryGradient,
                            borderRadius:
                                BorderRadius.circular(AppDimensions.radiusS),
                          ),
                          child: Text(
                            'Save ${widget.product.discountPercentage.round()}%',
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(AppDimensions.paddingM),
                  decoration: BoxDecoration(
                    gradient: widget.product.isInStock
                        ? AppColors.secondaryGradient
                        : null,
                    color: widget.product.isInStock
                        ? null
                        : AppColors.lightDivider,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                  ),
                  child: Text(
                    widget.product.isInStock
                        ? AppStrings.inStock
                        : AppStrings.outOfStock,
                    style: TextStyle(
                      color: widget.product.isInStock
                          ? AppColors.white
                          : AppColors.lightSecondaryText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 1000))
              .slideY(begin: 0.2),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
      child: GlassmorphismCard(
        child: Row(
          children: [
            const Text(
              AppStrings.quantity,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                _buildQuantityButton(
                  icon: Icons.remove,
                  onPressed:
                      _quantity > 1 ? () => setState(() => _quantity--) : null,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingM),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingL,
                    vertical: AppDimensions.paddingS,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightDivider),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                  ),
                  child: Text(
                    _quantity.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _buildQuantityButton(
                  icon: Icons.add,
                  onPressed: () => setState(() => _quantity++),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: onPressed != null ? AppColors.secondaryGradient : null,
        color: onPressed == null ? AppColors.lightDivider : null,
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: onPressed != null
              ? AppColors.white
              : AppColors.lightSecondaryText,
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: GlassmorphismCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.description,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingM),
            Text(
              widget.product.description,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecifications() {
    final specs = {
      'Brand': 'Premium Audio',
      'Model': 'PA-2024',
      'Connectivity': 'Bluetooth 5.0',
      'Battery Life': '30 hours',
      'Weight': '250g',
      'Warranty': '2 years',
    };

    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: GlassmorphismCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Specifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingM),
            ...specs.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        entry.key,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        entry.value,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildReviews() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: GlassmorphismCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  AppStrings.reviews,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    AppStrings.viewAll,
                    style: TextStyle(
                      color: AppColors.primaryViolet,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingM),
            ..._reviews.take(2).map((review) {
              return Container(
                margin: const EdgeInsets.only(bottom: AppDimensions.paddingM),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        gradient: AppColors.secondaryGradient,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          review['avatar'],
                          style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.paddingM),
                    // Review Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                review['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                review['date'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.color,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          RatingBarIndicator(
                            rating: review['rating'].toDouble(),
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 16,
                          ),
                          const SizedBox(height: AppDimensions.paddingS),
                          Text(
                            review['comment'],
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStickyBottomBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(
          left: AppDimensions.paddingL,
          right: AppDimensions.paddingL,
          top: AppDimensions.paddingM,
          bottom:
              MediaQuery.of(context).padding.bottom + AppDimensions.paddingM,
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
        child: Row(
          children: [
            // Add to Cart Button
            Expanded(
              flex: 2,
              child: Container(
                height: AppDimensions.buttonHeightL,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryViolet),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                    onTap: _handleAddToCart,
                    child: Center(
                      child: _isAddingToCart
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.primaryViolet,
                                ),
                              ),
                            )
                          : const Text(
                              AppStrings.addToCart,
                              style: TextStyle(
                                color: AppColors.primaryViolet,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: AppDimensions.paddingM),

            // Buy Now Button
            Expanded(
              flex: 2,
              child: GradientButton(
                text: AppStrings.buyNow,
                onPressed: _handleBuyNow,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleAddToCart() async {
    setState(() => _isAddingToCart = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isAddingToCart = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.product.name} added to cart!'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
        ),
      );
    }
  }

  void _handleBuyNow() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CartScreen(),
      ),
    );
  }
}
