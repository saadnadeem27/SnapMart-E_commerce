import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/glassmorphism_card.dart';
import '../../shared/widgets/gradient_button.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _currentStep = 0;
  bool _isLoading = false;

  // Form controllers
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();
  final _phoneController = TextEditingController();

  // Payment
  String _selectedPaymentMethod = 'card';
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardHolderController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    _phoneController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _cardHolderController.dispose();
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
                        // Progress Indicator
                        _buildProgressIndicator(),

                        // Step Content
                        Expanded(
                          child: _buildStepContent(),
                        ),

                        // Bottom Actions
                        _buildBottomActions(),
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
          const Expanded(
            child: Text(
              AppStrings.checkout,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
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

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: Row(
        children: [
          _buildProgressStep(0, 'Address', Icons.location_on),
          _buildProgressLine(0),
          _buildProgressStep(1, 'Payment', Icons.payment),
          _buildProgressLine(1),
          _buildProgressStep(2, 'Review', Icons.check_circle),
        ],
      ),
    );
  }

  Widget _buildProgressStep(int step, String title, IconData icon) {
    final isActive = step == _currentStep;
    final isCompleted = step < _currentStep;

    return Expanded(
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient:
                  isActive || isCompleted ? AppColors.primaryGradient : null,
              color: !isActive && !isCompleted ? AppColors.lightDivider : null,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCompleted ? Icons.check : icon,
              color: isActive || isCompleted
                  ? AppColors.white
                  : AppColors.lightSecondaryText,
              size: 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              color: isActive
                  ? AppColors.primaryViolet
                  : Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressLine(int step) {
    final isCompleted = step < _currentStep;

    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          gradient: isCompleted ? AppColors.primaryGradient : null,
          color: !isCompleted ? AppColors.lightDivider : null,
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildAddressStep();
      case 1:
        return _buildPaymentStep();
      case 2:
        return _buildReviewStep();
      default:
        return const SizedBox();
    }
  }

  Widget _buildAddressStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Delivery Address',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: AppDimensions.paddingL),

          GlassmorphismCard(
            child: Column(
              children: [
                _buildTextField(
                  controller: _addressController,
                  label: 'Street Address',
                  icon: Icons.location_on,
                ),
                const SizedBox(height: AppDimensions.paddingM),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _cityController,
                        label: 'City',
                        icon: Icons.location_city,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.paddingM),
                    Expanded(
                      child: _buildTextField(
                        controller: _stateController,
                        label: 'State',
                        icon: Icons.map,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.paddingM),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _zipController,
                        label: 'ZIP Code',
                        icon: Icons.markunread_mailbox,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.paddingM),
                    Expanded(
                      child: _buildTextField(
                        controller: _phoneController,
                        label: 'Phone Number',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.paddingL),

          // Saved Addresses
          const Text(
            'Saved Addresses',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: AppDimensions.paddingM),

          _buildSavedAddress(
            'Home',
            '123 Main Street, Apt 4B\nNew York, NY 10001',
            Icons.home,
          ),

          const SizedBox(height: AppDimensions.paddingS),

          _buildSavedAddress(
            'Work',
            '456 Business Ave, Suite 100\nNew York, NY 10002',
            Icons.business,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: AppColors.primaryViolet,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(color: AppColors.lightDivider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide(color: AppColors.primaryViolet, width: 2),
        ),
      ),
    );
  }

  Widget _buildSavedAddress(String title, String address, IconData icon) {
    return GlassmorphismCard(
      child: ListTile(
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
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(address),
        trailing: const Icon(Icons.radio_button_unchecked),
        onTap: () {
          // Select saved address
        },
      ),
    );
  }

  Widget _buildPaymentStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: AppDimensions.paddingL),

          // Payment Methods
          _buildPaymentOption(
            'card',
            'Credit/Debit Card',
            Icons.credit_card,
          ),

          const SizedBox(height: AppDimensions.paddingS),

          _buildPaymentOption(
            'paypal',
            'PayPal',
            Icons.account_balance_wallet,
          ),

          const SizedBox(height: AppDimensions.paddingS),

          _buildPaymentOption(
            'apple',
            'Apple Pay',
            Icons.phone_iphone,
          ),

          const SizedBox(height: AppDimensions.paddingL),

          // Card Details (if card is selected)
          if (_selectedPaymentMethod == 'card') ...[
            GlassmorphismCard(
              child: Column(
                children: [
                  _buildTextField(
                    controller: _cardHolderController,
                    label: 'Cardholder Name',
                    icon: Icons.person,
                  ),
                  const SizedBox(height: AppDimensions.paddingM),
                  _buildTextField(
                    controller: _cardNumberController,
                    label: 'Card Number',
                    icon: Icons.credit_card,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: AppDimensions.paddingM),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _expiryController,
                          label: 'MM/YY',
                          icon: Icons.calendar_today,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.paddingM),
                      Expanded(
                        child: _buildTextField(
                          controller: _cvvController,
                          label: 'CVV',
                          icon: Icons.lock,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String value, String title, IconData icon) {
    final isSelected = _selectedPaymentMethod == value;

    return GlassmorphismCard(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: isSelected
                ? AppColors.primaryGradient
                : AppColors.secondaryGradient,
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
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        trailing: Icon(
          isSelected
              ? Icons.radio_button_checked
              : Icons.radio_button_unchecked,
          color: isSelected
              ? AppColors.primaryViolet
              : AppColors.lightSecondaryText,
        ),
        onTap: () {
          setState(() {
            _selectedPaymentMethod = value;
          });
        },
      ),
    );
  }

  Widget _buildReviewStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Review',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: AppDimensions.paddingL),

          // Order Items
          GlassmorphismCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Items (3)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: AppDimensions.paddingM),

                // Sample items
                _buildOrderItem('Premium Wireless Headphones', 1, 199.99),
                const SizedBox(height: AppDimensions.paddingS),
                _buildOrderItem('Smart Fitness Watch', 2, 299.99),
                const SizedBox(height: AppDimensions.paddingS),
                _buildOrderItem('Designer Backpack', 1, 89.99),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.paddingM),

          // Delivery Address
          GlassmorphismCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppColors.primaryViolet,
                      size: 20,
                    ),
                    const SizedBox(width: AppDimensions.paddingS),
                    const Text(
                      'Delivery Address',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.paddingS),
                const Text(
                  '123 Main Street, Apt 4B\nNew York, NY 10001\n+1 (555) 123-4567',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.paddingM),

          // Payment Method
          GlassmorphismCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.payment,
                      color: AppColors.primaryViolet,
                      size: 20,
                    ),
                    const SizedBox(width: AppDimensions.paddingS),
                    const Text(
                      'Payment Method',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.paddingS),
                Text(
                  _getPaymentMethodTitle(),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.paddingM),

          // Order Summary
          GlassmorphismCard(
            child: Column(
              children: [
                _buildSummaryRow('Subtotal', '\$889.97'),
                _buildSummaryRow('Shipping', 'Free'),
                _buildSummaryRow('Tax', '\$71.20'),
                const Divider(),
                _buildSummaryRow('Total', '\$961.17', isTotal: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(String name, int quantity, double price) {
    return Row(
      children: [
        Expanded(
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          'x$quantity',
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
        const SizedBox(width: AppDimensions.paddingS),
        Text(
          '\$${(price * quantity).toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
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
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: FontWeight.bold,
              color: isTotal ? AppColors.primaryViolet : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
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
      child: Row(
        children: [
          if (_currentStep > 0) ...[
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    _currentStep--;
                  });
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: AppColors.primaryViolet),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(
                    color: AppColors.primaryViolet,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.paddingM),
          ],
          Expanded(
            flex: 2,
            child: GradientButton(
              text: _currentStep == 2 ? 'Place Order' : 'Continue',
              onPressed: _handleContinue,
              isLoading: _isLoading,
            ),
          ),
        ],
      ),
    );
  }

  String _getPaymentMethodTitle() {
    switch (_selectedPaymentMethod) {
      case 'card':
        return 'Credit/Debit Card';
      case 'paypal':
        return 'PayPal';
      case 'apple':
        return 'Apple Pay';
      default:
        return 'Credit/Debit Card';
    }
  }

  void _handleContinue() async {
    if (_currentStep == 2) {
      // Place order
      setState(() => _isLoading = true);

      // Simulate order processing
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isLoading = false);

      // Show success dialog
      _showOrderSuccessDialog();
    } else {
      // Go to next step
      setState(() {
        _currentStep++;
      });
    }
  }

  void _showOrderSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimensions.paddingL),
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: AppColors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingL),
            const Text(
              'Order Placed Successfully!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.paddingM),
            const Text(
              'Your order #12345 has been placed and will be delivered in 2-3 business days.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.paddingL),
            GradientButton(
              text: 'Continue Shopping',
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
      ),
    );
  }
}
