import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/providers/theme_provider.dart';
import '../../shared/widgets/glassmorphism_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'English';

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
              // Header with Profile Info
              _buildProfileHeader(),

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
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(AppDimensions.paddingL),
                      child: Column(
                        children: [
                          // Quick Stats
                          _buildQuickStats(),

                          const SizedBox(height: AppDimensions.paddingL),

                          // Account Section
                          _buildAccountSection(),

                          const SizedBox(height: AppDimensions.paddingL),

                          // Orders Section
                          _buildOrdersSection(),

                          const SizedBox(height: AppDimensions.paddingL),

                          // Settings Section
                          _buildSettingsSection(),

                          const SizedBox(height: AppDimensions.paddingL),

                          // Support Section
                          _buildSupportSection(),

                          const SizedBox(height: AppDimensions.paddingL),

                          // Sign Out Button
                          _buildSignOutButton(),

                          const SizedBox(height: AppDimensions.paddingXL),
                        ],
                      ),
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

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        children: [
          // App Bar
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.white,
                ),
              ),
              const Expanded(
                child: Text(
                  'Profile',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Edit profile
                },
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.white,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.paddingL),

          // Profile Picture and Info
          Column(
            children: [
              // Profile Picture
              Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.white.withOpacity(0.3),
                        width: 3,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        'https://images.unsplash.com/photo-1494790108755-2616b612b120',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              gradient: AppColors.secondaryGradient,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              color: AppColors.white,
                              size: 40,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Online Status
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              )
                  .animate()
                  .scale(duration: const Duration(milliseconds: 600))
                  .fadeIn(),

              const SizedBox(height: AppDimensions.paddingM),

              // User Info
              Column(
                children: [
                  const Text(
                    'Sarah Johnson',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 200))
                      .slideY(begin: 0.2),
                  const SizedBox(height: 4),
                  Text(
                    'sarah.johnson@email.com',
                    style: TextStyle(
                      color: AppColors.white.withOpacity(0.8),
                      fontSize: 16,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 400))
                      .slideY(begin: 0.2),
                  const SizedBox(height: AppDimensions.paddingS),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingM,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.2),
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusM),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.warning,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Premium Member',
                          style: TextStyle(
                            color: AppColors.white.withOpacity(0.9),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 600))
                      .slideY(begin: 0.2),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return GlassmorphismCard(
      child: Row(
        children: [
          _buildStatItem('12', 'Orders', Icons.shopping_bag),
          _buildDivider(),
          _buildStatItem('5', 'Wishlist', Icons.favorite),
          _buildDivider(),
          _buildStatItem('★ 4.8', 'Rating', Icons.star),
        ],
      ),
    )
        .animate()
        .slideY(begin: 0.2, duration: const Duration(milliseconds: 600))
        .fadeIn();
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: AppColors.secondaryGradient,
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            child: Icon(
              icon,
              color: AppColors.white,
              size: 20,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingS),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 40,
      color: AppColors.lightDivider,
    );
  }

  Widget _buildAccountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Account',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingM),
        GlassmorphismCard(
          child: Column(
            children: [
              _buildMenuItem(
                icon: Icons.person_outline,
                title: 'Edit Profile',
                subtitle: 'Update your personal information',
                onTap: () {},
              ),
              _buildMenuDivider(),
              _buildMenuItem(
                icon: Icons.location_on_outlined,
                title: 'Addresses',
                subtitle: 'Manage delivery addresses',
                onTap: () {},
              ),
              _buildMenuDivider(),
              _buildMenuItem(
                icon: Icons.payment_outlined,
                title: 'Payment Methods',
                subtitle: 'Manage cards and payment options',
                onTap: () {},
              ),
              _buildMenuDivider(),
              _buildMenuItem(
                icon: Icons.security_outlined,
                title: 'Security',
                subtitle: 'Password and security settings',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    )
        .animate()
        .slideY(
          begin: 0.2,
          delay: const Duration(milliseconds: 100),
          duration: const Duration(milliseconds: 600),
        )
        .fadeIn();
  }

  Widget _buildOrdersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Orders',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingM),
        GlassmorphismCard(
          child: Column(
            children: [
              _buildMenuItem(
                icon: Icons.history,
                title: 'Order History',
                subtitle: 'View all your past orders',
                onTap: () {},
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryViolet,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '12',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              _buildMenuDivider(),
              _buildMenuItem(
                icon: Icons.local_shipping_outlined,
                title: 'Track Orders',
                subtitle: 'Track your active deliveries',
                onTap: () {},
              ),
              _buildMenuDivider(),
              _buildMenuItem(
                icon: Icons.assignment_return_outlined,
                title: 'Returns & Exchanges',
                subtitle: 'Manage returns and refunds',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    )
        .animate()
        .slideY(
          begin: 0.2,
          delay: const Duration(milliseconds: 200),
          duration: const Duration(milliseconds: 600),
        )
        .fadeIn();
  }

  Widget _buildSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingM),
        GlassmorphismCard(
          child: Column(
            children: [
              _buildSwitchMenuItem(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                subtitle: 'Push notifications and alerts',
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
              _buildMenuDivider(),
              _buildSwitchMenuItem(
                icon: Icons.dark_mode_outlined,
                title: 'Dark Mode',
                subtitle: 'Switch to dark theme',
                value: context.watch<ThemeProvider>().isDarkMode,
                onChanged: (value) {
                  context.read<ThemeProvider>().toggleTheme();
                },
              ),
              _buildMenuDivider(),
              _buildMenuItem(
                icon: Icons.language_outlined,
                title: 'Language',
                subtitle: _selectedLanguage,
                onTap: () => _showLanguageSelector(),
              ),
              _buildMenuDivider(),
              _buildMenuItem(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                subtitle: 'Read our privacy terms',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    )
        .animate()
        .slideY(
          begin: 0.2,
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 600),
        )
        .fadeIn();
  }

  Widget _buildSupportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Support',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingM),
        GlassmorphismCard(
          child: Column(
            children: [
              _buildMenuItem(
                icon: Icons.help_outline,
                title: 'Help Center',
                subtitle: 'FAQs and support articles',
                onTap: () {},
              ),
              _buildMenuDivider(),
              _buildMenuItem(
                icon: Icons.chat_bubble_outline,
                title: 'Contact Support',
                subtitle: 'Get help from our team',
                onTap: () {},
              ),
              _buildMenuDivider(),
              _buildMenuItem(
                icon: Icons.star_rate_outlined,
                title: 'Rate App',
                subtitle: 'Share your feedback',
                onTap: () {},
              ),
              _buildMenuDivider(),
              _buildMenuItem(
                icon: Icons.info_outline,
                title: 'About',
                subtitle: 'App version and info',
                onTap: () {},
                trailing: Text(
                  'v1.0.0',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    )
        .animate()
        .slideY(
          begin: 0.2,
          delay: const Duration(milliseconds: 400),
          duration: const Duration(milliseconds: 600),
        )
        .fadeIn();
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: AppColors.secondaryGradient,
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        ),
        child: Icon(
          icon,
          color: AppColors.white,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).textTheme.bodySmall?.color,
        ),
      ),
      trailing: trailing ??
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.lightSecondaryText,
          ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: 4,
      ),
    );
  }

  Widget _buildSwitchMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: AppColors.secondaryGradient,
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        ),
        child: Icon(
          icon,
          color: AppColors.white,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).textTheme.bodySmall?.color,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primaryViolet,
        activeTrackColor: AppColors.primaryViolet.withOpacity(0.3),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: 4,
      ),
    );
  }

  Widget _buildMenuDivider() {
    return const Divider(
      height: 1,
      indent: 56,
      color: AppColors.lightDivider,
    );
  }

  Widget _buildSignOutButton() {
    return GlassmorphismCard(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.error.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          ),
          child: const Icon(
            Icons.logout,
            color: AppColors.error,
            size: 20,
          ),
        ),
        title: const Text(
          'Sign Out',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.error,
          ),
        ),
        subtitle: const Text(
          'Sign out of your account',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.error,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.error,
        ),
        onTap: _showSignOutDialog,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingM,
          vertical: 4,
        ),
      ),
    )
        .animate()
        .slideY(
          begin: 0.2,
          delay: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 600),
        )
        .fadeIn();
  }

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusL),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Language',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingL),
            ...[
              'English',
              'Spanish',
              'French',
              'German',
              'Italian',
            ].map((language) => ListTile(
                  title: Text(language),
                  trailing: _selectedLanguage == language
                      ? const Icon(
                          Icons.check,
                          color: AppColors.primaryViolet,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedLanguage = language;
                    });
                    Navigator.pop(context);
                  },
                )),
          ],
        ),
      ),
    );
  }

  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content:
            const Text('Are you sure you want to sign out of your account?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle sign out
            },
            child: const Text(
              'Sign Out',
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
}
