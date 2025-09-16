class AppDimensions {
  // Padding & Margins
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 48.0;

  // Border Radius
  static const double radiusXS = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusXXL = 32.0;
  static const double radiusFull = 999.0;

  // Icon Sizes
  static const double iconXS = 16.0;
  static const double iconS = 20.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 48.0;
  static const double iconXXL = 64.0;

  // Button Heights
  static const double buttonHeightS = 36.0;
  static const double buttonHeightM = 44.0;
  static const double buttonHeightL = 52.0;
  static const double buttonHeightXL = 60.0;

  // Card Sizes
  static const double cardHeight = 200.0;
  static const double productCardHeight = 280.0;
  static const double bannerHeight = 180.0;
  static const double profileHeaderHeight = 200.0;

  // Bottom Navigation
  static const double bottomNavHeight = 70.0;
  static const double bottomNavIconSize = 24.0;

  // App Bar
  static const double appBarHeight = 56.0;
  static const double searchBarHeight = 48.0;

  // Elevation
  static const double elevationXS = 1.0;
  static const double elevationS = 2.0;
  static const double elevationM = 4.0;
  static const double elevationL = 8.0;
  static const double elevationXL = 16.0;

  // Blur Effects
  static const double blurS = 8.0;
  static const double blurM = 16.0;
  static const double blurL = 24.0;
}

class AppSizes {
  // Grid
  static const int productGridCrossAxisCount = 2;
  static const double productGridChildAspectRatio = 0.75;
  static const double gridSpacing = 16.0;

  // List
  static const double listItemHeight = 80.0;
  static const double listItemSpacing = 12.0;

  // Images
  static const double avatarSizeS = 32.0;
  static const double avatarSizeM = 48.0;
  static const double avatarSizeL = 64.0;
  static const double avatarSizeXL = 96.0;

  // Product Images
  static const double productImageSmall = 60.0;
  static const double productImageMedium = 120.0;
  static const double productImageLarge = 200.0;
  static const double productImageXL = 300.0;
}

class AppStrings {
  // App
  static const String appName = 'SnapMart';
  static const String appTagline = 'Premium Shopping Experience';

  // Authentication
  static const String login = 'Login';
  static const String signup = 'Sign Up';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String forgotPassword = 'Forgot Password?';
  static const String loginWithGoogle = 'Continue with Google';
  static const String loginWithApple = 'Continue with Apple';
  static const String createAccount = 'Create Account';
  static const String alreadyHaveAccount = 'Already have an account?';
  static const String dontHaveAccount = "Don't have an account?";

  // Navigation
  static const String home = 'Home';
  static const String search = 'Search';
  static const String cart = 'Cart';
  static const String profile = 'Profile';
  static const String categories = 'Categories';

  // Product
  static const String addToCart = 'Add to Cart';
  static const String buyNow = 'Buy Now';
  static const String quantity = 'Quantity';
  static const String price = 'Price';
  static const String description = 'Description';
  static const String reviews = 'Reviews';
  static const String rating = 'Rating';
  static const String inStock = 'In Stock';
  static const String outOfStock = 'Out of Stock';

  // Cart & Checkout
  static const String shoppingCart = 'Shopping Cart';
  static const String checkout = 'Checkout';
  static const String subtotal = 'Subtotal';
  static const String total = 'Total';
  static const String shipping = 'Shipping';
  static const String tax = 'Tax';
  static const String deliveryAddress = 'Delivery Address';
  static const String paymentMethod = 'Payment Method';
  static const String orderSummary = 'Order Summary';
  static const String placeOrder = 'Place Order';

  // Profile
  static const String myOrders = 'My Orders';
  static const String wishlist = 'Wishlist';
  static const String paymentMethods = 'Payment Methods';
  static const String settings = 'Settings';
  static const String help = 'Help & Support';
  static const String logout = 'Logout';

  // Common
  static const String loading = 'Loading...';
  static const String error = 'Error';
  static const String retry = 'Retry';
  static const String cancel = 'Cancel';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String update = 'Update';
  static const String apply = 'Apply';
  static const String clear = 'Clear';
  static const String viewAll = 'View All';
  static const String seeMore = 'See More';

  // Search
  static const String searchProducts = 'Search products...';
  static const String trendingSearches = 'Trending Searches';
  static const String recentSearches = 'Recent Searches';
  static const String filterResults = 'Filter Results';
  static const String sortBy = 'Sort By';
  static const String priceRange = 'Price Range';

  // Validation Messages
  static const String emailRequired = 'Email is required';
  static const String passwordRequired = 'Password is required';
  static const String invalidEmail = 'Please enter a valid email';
  static const String passwordTooShort =
      'Password must be at least 6 characters';
  static const String passwordsDoNotMatch = 'Passwords do not match';
}

class AppAssets {
  // Icons
  static const String iconPath = 'assets/icons/';
  static const String logoIcon = '${iconPath}logo.png';
  static const String cartIcon = '${iconPath}cart.svg';
  static const String heartIcon = '${iconPath}heart.svg';
  static const String searchIcon = '${iconPath}search.svg';
  static const String userIcon = '${iconPath}user.svg';

  // Images
  static const String imagePath = 'assets/images/';
  static const String placeholderImage = '${imagePath}placeholder.jpg';
  static const String splashLogo = '${imagePath}splash_logo.png';

  // Animations
  static const String animationPath = 'assets/animations/';
  static const String loadingAnimation = '${animationPath}loading.json';
  static const String cartAnimation = '${animationPath}cart.json';
  static const String heartAnimation = '${animationPath}heart.json';
}
