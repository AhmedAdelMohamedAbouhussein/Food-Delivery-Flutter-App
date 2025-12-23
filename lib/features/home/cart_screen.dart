import 'package:final_proj/features/home/cart_manager.dart';
import 'package:flutter/material.dart';

import 'checkout_screen.dart';

class CartItem {
  final String name;
  final String image;
  final double price;
  int quantity;

  CartItem({required this.name, required this.image, required this.price, this.quantity = 1});
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key}); // No longer needs initialItems in constructor

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isDelivery = true;

  // Access the global list instead of a local one
  List<CartItem> get cartItems => CartManager().items;

  double get subtotal => cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1216),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _topBar(),
              const SizedBox(height: 20),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Order", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white))
              ),
              const SizedBox(height: 10),

              // Conditional UI: Show empty message if cart is empty
              Expanded(
                child: cartItems.isEmpty
                    ? const Center(
                    child: Text("Your cart is empty",
                        style: TextStyle(color: Colors.white60, fontSize: 16)))
                    : ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) => _cartItemWidget(cartItems[index], index),
                ),
              ),

              if (cartItems.isNotEmpty) ...[
                _summarySection(),
                const SizedBox(height: 16),
                _continueButton(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBar() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          child: const Icon(Icons.arrow_back_ios, color: Colors.green, size: 24),
        ),
        const Spacer(),
        Container(
          height: 40,
          width: 200,
          decoration: BoxDecoration(
            color: const Color(0xFF1C1F26),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              _toggleBtn("Delivery", isDelivery, () => setState(() => isDelivery = true)),
              _toggleBtn("Pickup", !isDelivery, () => setState(() => isDelivery = false)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _cartItemWidget(CartItem item, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 60,
                height: 60,
                color: Colors.grey[800],
                child: const Icon(Icons.fastfood, color: Colors.white24),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                Text("\$${item.price.toStringAsFixed(2)}", style: const TextStyle(color: Colors.green)),
              ],
            ),
          ),
          _quantityToggle(item, index),
        ],
      ),
    );
  }

  Widget _quantityToggle(CartItem item, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.green)),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => setState(() {
              if (item.quantity > 1) {
                item.quantity--;
              } else {
                cartItems.removeAt(index);
              }
            }),
            child: Icon(item.quantity > 1 ? Icons.remove : Icons.delete, color: item.quantity > 1 ? Colors.green : Colors.red, size: 18),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text("${item.quantity}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          GestureDetector(
            onTap: () => setState(() => item.quantity++),
            child: const Icon(Icons.add, color: Colors.green, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _summarySection() {
    const deliveryFee = 3.99;
    const fees = 2.45;
    const discount = -4.56;
    double total = subtotal + deliveryFee + fees + discount;

    return Column(
      children: [
        _summaryRow("Order", subtotal),
        _summaryRow("Delivery fee", deliveryFee),
        _summaryRow("Fees & Taxes", fees),
        _summaryRow("Discount", discount, isGreen: true),
        const Divider(color: Colors.grey),
        _summaryRow("Total", total, bold: true),
      ],
    );
  }

  Widget _summaryRow(String label, double value, {bool bold = false, bool isGreen = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal, color: isGreen ? Colors.green : Colors.white)),
          const Spacer(),
          Text("\$${value.toStringAsFixed(2)}", style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal, color: isGreen ? Colors.green : Colors.white)),
        ],
      ),
    );
  }

  Widget _toggleBtn(String text, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? Colors.green : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: active ? Colors.black : Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  // Inside CartScreen
  Widget _continueButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: () {
          // Navigate to the Checkout Screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CheckoutScreen()),
          );
        },
        child: const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}