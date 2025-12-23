import 'package:final_proj/features/home/paymentLogic/payment_cubit.dart';
import 'package:final_proj/features/home/paymentLogic/payment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_card.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int selectedDeliveryOption = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1216),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Checkout", style: TextStyle(color: Colors.white, fontSize: 18)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMapSection(),
            const SizedBox(height: 24),
            _buildSectionTitle("Delivery Time", trailing: "20-25 min"),
            const SizedBox(height: 16),
            _buildDeliveryOptions(),
            const SizedBox(height: 32),
            _infoTile(Icons.location_on_outlined, "Delivery Address", "123 Maple Street, NY"),
            _infoTile(Icons.sticky_note_2_outlined, "Drop-off Instructions", "Leave at front desk"),
            const SizedBox(height: 24),

            const Text("Payment Method",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            // COMPATIBILITY LAYER: BlocBuilder listens to PaymentCubit
            BlocBuilder<PaymentCubit, PaymentState>(
              builder: (context, state) {
                bool isCash = true;
                String cardTitle = "Credit / Debit Card";

                if (state is PaymentInitial) {
                  isCash = state.isCash;
                  // Update card title if card data exists in state
                  if (state.cardLastFour != null) {
                    cardTitle = "Card ending in **** ${state.cardLastFour}";
                  }
                }

                return Column(
                  children: [
                    _paymentTile(
                      icon: Icons.payments_outlined,
                      title: "Cash on Delivery",
                      isSelected: isCash,
                      onTap: () => context.read<PaymentCubit>().selectCash(),
                    ),
                    const SizedBox(height: 12),
                    _paymentTile(
                      icon: Icons.credit_card_outlined,
                      title: cardTitle,
                      isSelected: !isCash,
                      onTap: () {
                        // We still move to AddCard, but the Cubit will handle the data return
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AddCard()),
                        );
                      },
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 40),
            _buildPlaceOrderButton(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- UI Helpers (Keep your existing UI code) ---

  Widget _paymentTile({required IconData icon, required String title, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1F26),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: isSelected ? Colors.green : Colors.transparent, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.green : Colors.grey),
            const SizedBox(width: 16),
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
            const Spacer(),
            Icon(isSelected ? Icons.check_circle : Icons.circle_outlined, color: isSelected ? Colors.green : Colors.white24),
          ],
        ),
      ),
    );
  }

  Widget _buildMapSection() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 180,
        width: double.infinity,
        color: const Color(0xFF1C1F26),
        child: const Icon(Icons.map_outlined, color: Colors.white24, size: 40),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {String? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        if (trailing != null) Text(trailing, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildDeliveryOptions() {
    return Row(
      children: [
        Expanded(child: _deliveryOptionCard("Standard", "20-25 min", "Free", 1)),
      ],
    );
  }

  Widget _deliveryOptionCard(String title, String time, String price, int index) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green, width: 2),
        color: const Color(0xFF1C1F26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text(price, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey, size: 24),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceOrderButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00D278), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
        onPressed: () => _showSuccessDialog(context),
        child: const Text("Place order", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1C1F26),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            const Text("Order Successful", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
              child: const Text("Back to Home"),
            )
          ],
        ),
      ),
    );
  }
}