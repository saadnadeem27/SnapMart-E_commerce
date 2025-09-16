# 🛍️ SnapMart E-Commerce App

[![Flutter](https://img.shields.io/badge/Flutter-3.6.0-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.0+-brightgreen.svg)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A premium, modern e-commerce mobile application built with Flutter, featuring stunning glassmorphism UI, smooth animations, and a comprehensive shopping experience.

## 📱 Features

### 🎨 **Modern UI/UX Design**
- **Glassmorphism Design**: Beautiful glass-like effects with backdrop blur
- **Gradient Themes**: Eye-catching purple-to-blue gradients throughout the app
- **Dark/Light Mode**: Complete theme switching support
- **Smooth Animations**: 60fps animations using `flutter_animate` and custom controllers
- **Professional Splash Screen**: Enhanced with pulsating radial glow effects

### 🔐 **Authentication System**
- **Email/Password Authentication**: Secure login and registration
- **Social Authentication**: Google Sign-In integration
- **Form Validation**: Real-time input validation with custom error handling
- **Animated UI**: Smooth transitions between login and signup forms

### 🏠 **Home & Discovery**
- **Carousel Banners**: Promotional content with automatic sliding
- **Category Grid**: Easy navigation through product categories
- **Featured Products**: Curated product recommendations
- **Search Functionality**: Advanced search with filters
- **Product Grid**: Responsive grid layout with lazy loading

### 🛒 **Shopping Experience**
- **Product Details**: High-quality images, specifications, and reviews
- **Shopping Cart**: Add/remove items with quantity management
- **Wishlist**: Save favorite products for later
- **Product Reviews**: Rating system with detailed feedback
- **Price Comparison**: Original vs. discounted prices with percentage savings

### 💳 **Checkout & Payments**
- **Multi-step Checkout**: Address, payment method, and order review
- **Payment Integration**: Credit card, digital wallet support
- **Address Management**: Save multiple shipping addresses
- **Order Summary**: Detailed breakdown of costs and taxes
- **Promo Codes**: Discount code application system

### 👤 **User Profile**
- **Profile Management**: Edit personal information and preferences
- **Order History**: Track past purchases and order status
- **Settings**: Notifications, language, and privacy controls
- **Theme Toggle**: Switch between dark and light modes

### 🔍 **Advanced Features**
- **Real-time Search**: Instant search results with auto-suggestions
- **Product Filtering**: Filter by price, rating, category, and availability
- **Responsive Design**: Optimized for various screen sizes
- **Offline Support**: Basic functionality without internet connection
- **State Management**: Efficient app state handling with Provider pattern

## 🛠️ Tech Stack

### **Frontend Framework**
- **Flutter 3.6.0+** - Cross-platform mobile development
- **Dart 3.0+** - Programming language

### **State Management**
- **Provider** - Simple and efficient state management
- **Flutter Riverpod** - Advanced state management for complex scenarios

### **UI & Animation Libraries**
```yaml
flutter_animate: ^4.5.0          # Smooth animations
shimmer: ^3.0.0                  # Loading skeleton effects
flutter_staggered_animations: ^1.1.1  # Staggered list animations
lottie: ^3.1.2                   # Vector animations
flutter_slidable: ^3.0.1        # Swipe actions
carousel_slider: ^5.0.0          # Image carousels
flutter_rating_bar: ^4.0.1      # Rating components
badges: ^3.1.2                   # Notification badges
```

### **Navigation & Routing**
- **GoRouter 14.2.7** - Declarative routing with type safety

### **Backend & Authentication**
```yaml
firebase_core: ^3.6.0           # Firebase SDK
firebase_auth: ^5.3.1           # Authentication services
google_sign_in: ^6.2.1          # Google OAuth integration
```

### **Networking & Storage**
```yaml
http: ^1.2.2                    # HTTP client for API calls
shared_preferences: ^2.3.2      # Local data persistence
cached_network_image: ^3.4.1    # Optimized image loading
```

### **Media & File Handling**
```yaml
image_picker: ^1.1.2            # Camera and gallery access
```

## 🚀 Getting Started

### **Prerequisites**
- Flutter 3.6.0 or higher
- Dart 3.0 or higher
- Android Studio / Xcode (for device testing)
- Firebase account (for authentication features)

### **Installation**

1. **Clone the repository**
```bash
git clone https://github.com/saadnadeem27/SnapMart-E_commerce.git
cd SnapMart-E_commerce
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
flutter run
```

### **Firebase Setup** (Optional)
1. Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Add your Android/iOS app to the project
3. Download and add the configuration files:
   - `google-services.json` for Android (place in `android/app/`)
   - `GoogleService-Info.plist` for iOS (place in `ios/Runner/`)
4. Enable Authentication services in Firebase Console

## 📂 Project Structure

```
lib/
├── 🎯 main.dart                 # App entry point
├── 📁 core/                     # Core functionality
│   ├── constants/              # App constants and themes
│   ├── providers/              # Global state providers
│   └── theme/                  # Theme configurations
├── 📁 features/                # Feature-based modules
│   ├── auth/                   # Authentication screens
│   ├── cart/                   # Shopping cart functionality
│   ├── checkout/               # Checkout process
│   ├── home/                   # Home screen and navigation
│   ├── product/                # Product details and catalog
│   ├── profile/                # User profile management
│   ├── search/                 # Search and filtering
│   └── splash/                 # Splash screen with animations
├── 📁 models/                  # Data models
│   ├── product.dart           # Product model
│   └── cart.dart              # Cart item model
├── 📁 services/               # External services
└── 📁 shared/                 # Reusable components
    └── widgets/               # Custom widgets
        ├── glassmorphism_card.dart
        ├── gradient_button.dart
        └── social_login_button.dart
```

## 🎨 Design Highlights

### **Color Palette**
- **Primary Gradient**: Purple (`#8B5CF6`) → Magenta (`#E879F9`) → Blue (`#06B6D4`)
- **Glassmorphism Effects**: Semi-transparent cards with backdrop blur
- **Dynamic Theming**: Seamless dark/light mode transitions

### **Custom Components**
- **GlassmorphismCard**: Reusable glass-effect container
- **GradientButton**: Customizable gradient-based buttons
- **SocialLoginButton**: Social authentication components
- **Enhanced Splash**: Professional loading screen with animated effects

### **Animation Features**
- **Micro-interactions**: Button press feedback and hover effects
- **Page Transitions**: Smooth navigation between screens
- **Loading States**: Skeleton screens and progress indicators
- **Gesture-based**: Swipe actions and pull-to-refresh

## 📱 Screenshots

> **Note**: Add your app screenshots here once available

```
[Splash Screen] [Home Screen] [Product Details]
[Shopping Cart] [Checkout]    [User Profile]
```

## 🔧 Development

### **Code Quality**
- **Flutter Lints**: Enforced coding standards
- **Clean Architecture**: Feature-based folder structure
- **Responsive Design**: Adaptive layouts for different screen sizes
- **Type Safety**: Strong typing throughout the codebase

### **Performance Optimizations**
- **Lazy Loading**: Products loaded on demand
- **Image Caching**: Optimized network image handling
- **Memory Management**: Proper disposal of controllers and resources
- **State Efficiency**: Minimal rebuilds with targeted state management

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Developer

**Saad Nadeem**
- GitHub: [@saadnadeem27](https://github.com/saadnadeem27)
- Portfolio: [Your Portfolio Website]
- LinkedIn: https://www.linkedin.com/in/saad-nadeem-07-an-expert-flutter-developer/

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Unsplash for high-quality product images
- The Flutter community for inspiration and support

---

⭐ **Star this repository if you found it helpful!**

*Built with ❤️ using Flutter*
