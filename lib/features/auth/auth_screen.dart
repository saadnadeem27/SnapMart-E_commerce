import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/gradient_button.dart';

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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Fixed header section
              Container(
                height: screenHeight * 0.22, // Reduced from 0.32 to 0.22
                width: screenWidth,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingL,
                  vertical: AppDimensions.paddingM, // Reduced padding
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildProfessionalLogo(),
                    const SizedBox(
                        height: AppDimensions.paddingS), // Reduced spacing
                    _buildWelcomeText(),
                  ],
                ),
              ),

              // Auth form section - takes remaining space
              Expanded(
                child: Container(
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppDimensions.paddingXXL),
                      topRight: Radius.circular(AppDimensions.paddingXXL),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppDimensions.paddingXXL),
                      topRight: Radius.circular(AppDimensions.paddingXXL),
                    ),
                    child: Column(
                      children: [
                        // Tab bar section
                        Container(
                          width: screenWidth,
                          padding: const EdgeInsets.fromLTRB(
                            AppDimensions.paddingL,
                            AppDimensions.paddingM, // Reduced top padding
                            AppDimensions.paddingL,
                            AppDimensions.paddingS, // Reduced bottom padding
                          ),
                          child: _buildModernTabBar(),
                        ),

                        // Form content - takes remaining space
                        Expanded(
                          child: Container(
                            width: screenWidth,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppDimensions.paddingL,
                            ),
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                _buildModernLoginForm(),
                                _buildModernSignupForm(),
                              ],
                            ),
                          ),
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

  Widget _buildProfessionalLogo() {
    return Container(
      width: 70, // Reduced from 80
      height: 70, // Reduced from 80
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.white,
            AppColors.electricBlue,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.white.withOpacity(0.3),
            blurRadius: 15, // Reduced shadow
            spreadRadius: 1, // Reduced spread
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(5), // Reduced margin
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.shopping_bag_rounded,
          size: 35, // Reduced from 40
          color: AppColors.white,
        ),
      ),
    )
        .animate()
        .scale(duration: const Duration(milliseconds: 600))
        .then()
        .shimmer(duration: const Duration(seconds: 2));
  }

  Widget _buildWelcomeText() {
    return Column(
      children: [
        Text(
          _isLogin ? 'Welcome Back!' : 'Join SnapMart',
          style: const TextStyle(
            fontSize: 24, // Reduced from 28
            fontWeight: FontWeight.w900,
            color: AppColors.white,
            letterSpacing: 1,
          ),
          textAlign: TextAlign.center,
        )
            .animate()
            .fadeIn(duration: const Duration(milliseconds: 800))
            .slideY(begin: -0.2),
        const SizedBox(height: AppDimensions.paddingXS), // Reduced spacing
        Text(
          _isLogin
              ? 'Sign in to continue shopping'
              : 'Create your account today',
          style: TextStyle(
            fontSize: 12, // Reduced from 14
            color: AppColors.white.withOpacity(0.9),
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        )
            .animate()
            .fadeIn(duration: const Duration(milliseconds: 1000))
            .slideY(begin: -0.1),
      ],
    );
  }

  Widget _buildModernTabBar() {
    return Container(
      height: 50, // Reduced from 60
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryViolet.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        labelColor: AppColors.white,
        unselectedLabelColor: Colors.grey[600],
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15, // Reduced from 16
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15, // Reduced from 16
        ),
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: const [
          Tab(text: AppStrings.login),
          Tab(text: AppStrings.signup),
        ],
      ),
    );
  }

  Widget _buildModernLoginForm() {
    return SingleChildScrollView(
      child: Form(
        key: _loginFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
                height: AppDimensions.paddingM), // Reduced from paddingL

            // Email Field
            _buildModernTextField(
              controller: _emailController,
              label: AppStrings.email,
              icon: Icons.email_outlined,
              hint: 'Enter your email address',
            ),

            const SizedBox(
                height: AppDimensions.paddingM), // Reduced from paddingL

            // Password Field
            _buildModernTextField(
              controller: _passwordController,
              label: AppStrings.password,
              icon: Icons.lock_outline,
              hint: 'Enter your password',
              isPassword: true,
              obscureText: _obscurePassword,
              onToggleVisibility: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),

            const SizedBox(height: AppDimensions.paddingS), // Reduced spacing

            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  AppStrings.forgotPassword,
                  style: TextStyle(
                    color: AppColors.primaryViolet,
                    fontSize: 13, // Reduced from 14
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(
                height: AppDimensions.paddingL), // Reduced from paddingXL

            // Login Button
            GradientButton(
              text: AppStrings.login,
              onPressed: _handleLogin,
              gradient: AppColors.primaryGradient,
            ),

            const SizedBox(
                height: AppDimensions.paddingL), // Reduced from paddingXL

            // Divider
            Row(
              children: [
                const Expanded(child: Divider(color: Colors.grey)),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingM,
                  ),
                  child: Text(
                    'or continue with',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13, // Reduced from 14
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Expanded(child: Divider(color: Colors.grey)),
              ],
            ),

            const SizedBox(
                height: AppDimensions.paddingL), // Reduced from paddingXL

            // Social Login Buttons
            Row(
              children: [
                Expanded(
                  child: _buildSocialButton(
                    'Google',
                    Icons.g_mobiledata,
                    _handleGoogleLogin,
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingM),
                Expanded(
                  child: _buildSocialButton(
                    'Apple',
                    Icons.apple,
                    _handleAppleLogin,
                  ),
                ),
              ],
            ),

            const SizedBox(
                height: AppDimensions.paddingL), // Reduced from paddingXL
          ],
        ),
      ),
    );
  }

  Widget _buildModernSignupForm() {
    return SingleChildScrollView(
      child: Form(
        key: _signupFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppDimensions.paddingL),

            // Email Field
            _buildModernTextField(
              controller: _emailController,
              label: AppStrings.email,
              icon: Icons.email_outlined,
              hint: 'Enter your email address',
            ),

            const SizedBox(height: AppDimensions.paddingL),

            // Password Field
            _buildModernTextField(
              controller: _passwordController,
              label: AppStrings.password,
              icon: Icons.lock_outline,
              hint: 'Create a strong password',
              isPassword: true,
              obscureText: _obscurePassword,
              onToggleVisibility: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),

            const SizedBox(height: AppDimensions.paddingL),

            // Confirm Password Field
            _buildModernTextField(
              controller: _confirmPasswordController,
              label: AppStrings.confirmPassword,
              icon: Icons.lock_outline,
              hint: 'Confirm your password',
              isPassword: true,
              obscureText: _obscureConfirmPassword,
              onToggleVisibility: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),

            const SizedBox(height: AppDimensions.paddingXL),

            // Terms and Conditions
            Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    Icons.check,
                    size: 16,
                    color: AppColors.primaryViolet,
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingS),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: 'I agree to the ',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                      children: [
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: TextStyle(
                            color: AppColors.primaryViolet,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: AppColors.primaryViolet,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.paddingXL),

            // Signup Button
            GradientButton(
              text: AppStrings.createAccount,
              onPressed: _handleSignup,
              gradient: AppColors.primaryGradient,
            ),

            const SizedBox(height: AppDimensions.paddingXL),

            // Divider
            Row(
              children: [
                const Expanded(child: Divider(color: Colors.grey)),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingM,
                  ),
                  child: Text(
                    'or continue with',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Expanded(child: Divider(color: Colors.grey)),
              ],
            ),

            const SizedBox(height: AppDimensions.paddingXL),

            // Social Login Buttons
            Row(
              children: [
                Expanded(
                  child: _buildSocialButton(
                    'Google',
                    Icons.g_mobiledata,
                    _handleGoogleLogin,
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingM),
                Expanded(
                  child: _buildSocialButton(
                    'Apple',
                    Icons.apple,
                    _handleAppleLogin,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.paddingXL),
          ],
        ),
      ),
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    bool isPassword = false,
    bool? obscureText,
    VoidCallback? onToggleVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13, // Reduced from 14
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: AppDimensions.paddingXS), // Reduced spacing
        Container(
          height: 52, // Fixed height to make it more compact
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            border: Border.all(
              color: Colors.grey[300]!,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText ?? false,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 15, // Reduced from 16
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 15, // Reduced from 16
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: Container(
                margin: const EdgeInsets.all(10), // Reduced margin
                padding: const EdgeInsets.all(6), // Reduced padding
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: AppColors.white,
                  size: 16, // Reduced from 18
                ),
              ),
              suffixIcon: isPassword && onToggleVisibility != null
                  ? IconButton(
                      onPressed: onToggleVisibility,
                      icon: Icon(
                        (obscureText ?? false)
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.grey[600],
                        size: 20, // Reduced icon size
                      ),
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingM, // Reduced padding
                vertical: AppDimensions.paddingM,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(
      String text, IconData icon, VoidCallback onPressed) {
    return Container(
      height: 44, // Reduced from 50
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18, // Reduced from 20
                color: Colors.grey[700],
              ),
              const SizedBox(width: AppDimensions.paddingXS), // Reduced spacing
              Text(
                text,
                style: TextStyle(
                  fontSize: 13, // Reduced from 14
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
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
