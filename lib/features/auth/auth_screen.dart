import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/gradient_button.dart';
import '../../shared/widgets/glassmorphism_card.dart';
import '../../shared/widgets/social_login_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool _isLogin = true;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  late TabController _tabController;
  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _isLogin = _tabController.index == 0;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.paddingL),
            child: Column(
              children: [
                const SizedBox(height: AppDimensions.paddingXXL),

                // Header Section
                _buildHeader(),

                const SizedBox(height: AppDimensions.paddingXXL),

                // Auth Form Card
                GlassmorphismCard(
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimensions.paddingL),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Tab Bar
                        _buildTabBar(),

                        const SizedBox(height: AppDimensions.paddingL),

                        // Form Content
                        SizedBox(
                          height: 400,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              _buildLoginForm(),
                              _buildSignupForm(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppDimensions.paddingL),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Logo
        Container(
          padding: const EdgeInsets.all(AppDimensions.paddingL),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.white.withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: const Icon(
            Icons.shopping_bag_rounded,
            size: 60,
            color: AppColors.white,
          ),
        )
            .animate()
            .scale(duration: const Duration(milliseconds: 600))
            .then()
            .shimmer(duration: const Duration(seconds: 2)),

        const SizedBox(height: AppDimensions.paddingM),

        // Welcome Text
        Text(
          _isLogin ? 'Welcome Back!' : 'Join SnapMart',
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        )
            .animate()
            .fadeIn(duration: const Duration(milliseconds: 800))
            .slideY(begin: -0.2),

        const SizedBox(height: AppDimensions.paddingS),

        Text(
          _isLogin
              ? 'Sign in to continue shopping'
              : 'Create your premium account',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.white.withOpacity(0.8),
          ),
        )
            .animate()
            .fadeIn(duration: const Duration(milliseconds: 1000))
            .slideY(begin: -0.1),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          gradient: AppColors.secondaryGradient,
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
        labelColor: AppColors.white,
        unselectedLabelColor: AppColors.white.withOpacity(0.7),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: AppStrings.login),
          Tab(text: AppStrings.signup),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return SingleChildScrollView(
      child: Form(
        key: _loginFormKey,
        child: Column(
          children: [
            const SizedBox(height: AppDimensions.paddingL),

            // Email Field
            _buildTextField(
              controller: _emailController,
              label: AppStrings.email,
              icon: Icons.email_outlined,
            ),

            const SizedBox(height: AppDimensions.paddingM),

            // Password Field
            _buildTextField(
              controller: _passwordController,
              label: AppStrings.password,
              icon: Icons.lock_outline,
              isPassword: true,
              obscureText: _obscurePassword,
              onToggleVisibility: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),

            const SizedBox(height: AppDimensions.paddingS),

            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  AppStrings.forgotPassword,
                  style: TextStyle(
                    color: AppColors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.paddingL),

            // Login Button
            GradientButton(
              text: AppStrings.login,
              onPressed: _handleLogin,
              gradient: AppColors.secondaryGradient,
            ),

            const SizedBox(height: AppDimensions.paddingL),

            // Social Login Section
            _buildSocialLoginSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSignupForm() {
    return SingleChildScrollView(
      child: Form(
        key: _signupFormKey,
        child: Column(
          children: [
            const SizedBox(height: AppDimensions.paddingL),

            // Email Field
            _buildTextField(
              controller: _emailController,
              label: AppStrings.email,
              icon: Icons.email_outlined,
            ),

            const SizedBox(height: AppDimensions.paddingM),

            // Password Field
            _buildTextField(
              controller: _passwordController,
              label: AppStrings.password,
              icon: Icons.lock_outline,
              isPassword: true,
              obscureText: _obscurePassword,
              onToggleVisibility: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),

            const SizedBox(height: AppDimensions.paddingM),

            // Confirm Password Field
            _buildTextField(
              controller: _confirmPasswordController,
              label: AppStrings.confirmPassword,
              icon: Icons.lock_outline,
              isPassword: true,
              obscureText: _obscureConfirmPassword,
              onToggleVisibility: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),

            const SizedBox(height: AppDimensions.paddingL),

            // Signup Button
            GradientButton(
              text: AppStrings.createAccount,
              onPressed: _handleSignup,
              gradient: AppColors.secondaryGradient,
            ),

            const SizedBox(height: AppDimensions.paddingL),

            // Social Login Section
            _buildSocialLoginSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    bool? obscureText,
    VoidCallback? onToggleVisibility,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          color: AppColors.primaryViolet.withOpacity(0.5),
          width: 2,
        ),
        gradient: LinearGradient(
          colors: [
            AppColors.white.withOpacity(0.15),
            AppColors.white.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryViolet.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: AppColors.white.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText ?? false,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(
            color: AppColors.black.withOpacity(0.6),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryViolet.withOpacity(0.8),
                  AppColors.primaryMagenta.withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryViolet.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: AppColors.white,
              size: 20,
            ),
          ),
          suffixIcon: isPassword && onToggleVisibility != null
              ? Container(
                  margin: const EdgeInsets.all(10),
                  child: IconButton(
                    onPressed: onToggleVisibility,
                    icon: Icon(
                      (obscureText ?? false)
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.white.withOpacity(0.8),
                    ),
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingL,
            vertical: AppDimensions.paddingL,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginSection() {
    return GlassmorphismCard(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Flexible(child: Divider(color: AppColors.white)),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingS,
                  ),
                  child: Text(
                    'Or',
                    style: TextStyle(
                      color: AppColors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ),
                const Flexible(child: Divider(color: AppColors.white)),
              ],
            ),

            const SizedBox(height: AppDimensions.paddingL),

            // Social Login Buttons
            Row(
              children: [
                Flexible(
                  child: SocialLoginButton(
                    icon: Icons.g_mobiledata,
                    label: 'Google',
                    onPressed: _handleGoogleLogin,
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingM),
                Flexible(
                  child: SocialLoginButton(
                    icon: Icons.apple,
                    label: 'Apple',
                    onPressed: _handleAppleLogin,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Action Methods
  void _handleLogin() {
    // TODO: Implement login logic
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _handleSignup() {
    // TODO: Implement signup logic
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _handleGoogleLogin() {
    // TODO: Implement Google login
  }

  void _handleAppleLogin() {
    // TODO: Implement Apple login
  }
}
