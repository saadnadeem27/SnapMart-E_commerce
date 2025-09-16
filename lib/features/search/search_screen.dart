import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../models/product.dart';
import '../../shared/widgets/glassmorphism_card.dart';
import '../product/product_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  String _selectedCategory = 'All';
  String _selectedSortBy = 'Popular';
  final List<String> _searchHistory = [
    'iPhone',
    'Headphones',
    'Laptop',
    'Watch'
  ];
  final List<String> _trendingSearches = [
    'Gaming Setup',
    'Wireless Earbuds',
    'Smart Home',
    'Fitness Gear'
  ];

  final List<String> _categories = [
    'All',
    'Electronics',
    'Fashion',
    'Home',
    'Beauty',
    'Sports',
    'Books'
  ];

  final List<String> _sortOptions = [
    'Popular',
    'Price: Low to High',
    'Price: High to Low',
    'Rating',
    'Newest'
  ];

  final List<Product> _searchResults = [
    Product(
      id: '1',
      name: 'Premium Wireless Headphones',
      description: 'High-quality wireless headphones with noise cancellation',
      price: 199.99,
      originalPrice: 249.99,
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e',
      category: 'Electronics',
      rating: 4.8,
      reviewCount: 124,
    ),
    Product(
      id: '2',
      name: 'Smart Fitness Watch',
      description: 'Advanced fitness tracking with heart rate monitor',
      price: 299.99,
      originalPrice: 399.99,
      imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30',
      category: 'Electronics',
      rating: 4.6,
      reviewCount: 89,
    ),
    Product(
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
    Product(
      id: '4',
      name: 'Organic Skincare Set',
      description: 'Complete skincare routine with natural ingredients',
      price: 149.99,
      originalPrice: 199.99,
      imageUrl: 'https://images.unsplash.com/photo-1556228720-195a672e8a03',
      category: 'Beauty',
      rating: 4.9,
      reviewCount: 156,
    ),
    Product(
      id: '5',
      name: 'Gaming Mechanical Keyboard',
      description: 'RGB backlit mechanical keyboard for gaming',
      price: 129.99,
      originalPrice: 159.99,
      imageUrl: 'https://images.unsplash.com/photo-1529336953128-a85760f58db5',
      category: 'Electronics',
      rating: 4.5,
      reviewCount: 78,
    ),
    Product(
      id: '6',
      name: 'Premium Coffee Maker',
      description: 'Automatic coffee maker with programmable settings',
      price: 249.99,
      originalPrice: 299.99,
      imageUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085',
      category: 'Home',
      rating: 4.7,
      reviewCount: 92,
    ),
  ];

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
    _searchController.dispose();
    _searchFocusNode.dispose();
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
              // Search Header
              _buildSearchHeader(),

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
                        // Filter Section
                        _buildFilterSection(),

                        // Search Results
                        Expanded(
                          child: _searchController.text.isEmpty
                              ? _buildSearchSuggestions()
                              : _buildSearchResults(),
                        ),
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

  Widget _buildSearchHeader() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'Search Products',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 600))
              .slideY(begin: -0.2),

          const SizedBox(height: AppDimensions.paddingM),

          // Search Bar
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.radiusL),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radiusL),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(
                    color: AppColors.primaryViolet.withOpacity(0.3),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                ),
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  onChanged: (value) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: AppStrings.searchProducts,
                    hintStyle: TextStyle(
                      color: AppColors.lightSecondaryText.withOpacity(0.6),
                    ),
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(AppDimensions.paddingS),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: AppColors.secondaryGradient,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(AppDimensions.paddingS),
                        child: const Icon(
                          Icons.search,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              _searchController.clear();
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.clear,
                              color: AppColors.lightSecondaryText,
                            ),
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingL,
                      vertical: AppDimensions.paddingM,
                    ),
                  ),
                ),
              ),
            ),
          )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 800))
              .slideY(begin: 0.2),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: AppDimensions.paddingM),

          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;

                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = category),
                  child: Container(
                    margin:
                        const EdgeInsets.only(right: AppDimensions.paddingS),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingL,
                      vertical: AppDimensions.paddingS,
                    ),
                    decoration: BoxDecoration(
                      gradient: isSelected ? AppColors.secondaryGradient : null,
                      color: isSelected ? null : AppColors.lightSurface,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusFull),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.transparent
                            : AppColors.lightDivider,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.primaryViolet.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color:
                            isSelected ? AppColors.white : AppColors.lightText,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ),
                )
                    .animate()
                    .slideX(
                      begin: 0.2,
                      delay: Duration(milliseconds: index * 50),
                      duration: const Duration(milliseconds: 300),
                    )
                    .fadeIn();
              },
            ),
          ),

          const SizedBox(height: AppDimensions.paddingL),

          // Sort Options
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sort By',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: _showSortOptions,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingM,
                    vertical: AppDimensions.paddingS,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightDivider),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedSortBy,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.paddingS),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSuggestions() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trending Searches
          _buildSuggestionSection(
            title: AppStrings.trendingSearches,
            items: _trendingSearches,
            icon: Icons.trending_up,
            iconColor: AppColors.primaryViolet,
          ),

          const SizedBox(height: AppDimensions.paddingXL),

          // Recent Searches
          _buildSuggestionSection(
            title: AppStrings.recentSearches,
            items: _searchHistory,
            icon: Icons.history,
            iconColor: AppColors.lightSecondaryText,
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionSection({
    required String title,
    required List<String> items,
    required IconData icon,
    required Color iconColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
            const SizedBox(width: AppDimensions.paddingS),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.paddingM),
        Wrap(
          spacing: AppDimensions.paddingS,
          runSpacing: AppDimensions.paddingS,
          children: items.map((item) {
            return GestureDetector(
              onTap: () {
                _searchController.text = item;
                setState(() {});
              },
              child: GlassmorphismCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingM,
                  vertical: AppDimensions.paddingS,
                ),
                child: Text(
                  item,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    return Column(
      children: [
        // Results Count
        Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingL),
          child: Row(
            children: [
              Text(
                '${_searchResults.length} results found',
                style: TextStyle(
                  color: AppColors.lightSecondaryText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        // Results Grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingL,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: AppSizes.productGridCrossAxisCount,
              childAspectRatio: AppSizes.productGridChildAspectRatio,
              crossAxisSpacing: AppSizes.gridSpacing,
              mainAxisSpacing: AppSizes.gridSpacing,
            ),
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              return _buildProductCard(_searchResults[index], index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(Product product, int index) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailScreen(product: product),
        ),
      ),
      child: GlassmorphismCard(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusM),
                      color: AppColors.lightDivider,
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusM),
                      child: Image.network(
                        product.imageUrl,
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

                  // Favorite Button
                  Positioned(
                    top: AppDimensions.paddingS,
                    right: AppDimensions.paddingS,
                    child: Container(
                      padding: const EdgeInsets.all(AppDimensions.paddingS),
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        size: 16,
                        color: AppColors.primaryViolet,
                      ),
                    ),
                  ),

                  // Discount Badge
                  if (product.hasDiscount)
                    Positioned(
                      top: AppDimensions.paddingS,
                      left: AppDimensions.paddingS,
                      child: Container(
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
                          '${product.discountPercentage.round()}% OFF',
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.paddingS),

            // Product Info
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  // Rating
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        product.rating.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        ' (${product.reviewCount})',
                        style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Price
                  Row(
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryViolet,
                        ),
                      ),
                      if (product.hasDiscount) ...[
                        const SizedBox(width: 4),
                        Text(
                          '\$${product.originalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .slideY(
          begin: 0.2,
          delay: Duration(milliseconds: index * 100),
          duration: const Duration(milliseconds: 400),
        )
        .fadeIn();
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.radiusL),
            topRight: Radius.circular(AppDimensions.radiusL),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.lightDivider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Title
            const Padding(
              padding: EdgeInsets.all(AppDimensions.paddingL),
              child: Text(
                'Sort By',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Options
            ..._sortOptions.map((option) {
              final isSelected = _selectedSortBy == option;
              return ListTile(
                title: Text(
                  option,
                  style: TextStyle(
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? AppColors.primaryViolet : null,
                  ),
                ),
                trailing: isSelected
                    ? const Icon(
                        Icons.check,
                        color: AppColors.primaryViolet,
                      )
                    : null,
                onTap: () {
                  setState(() => _selectedSortBy = option);
                  Navigator.pop(context);
                },
              );
            }),

            const SizedBox(height: AppDimensions.paddingL),
          ],
        ),
      ),
    );
  }
}
