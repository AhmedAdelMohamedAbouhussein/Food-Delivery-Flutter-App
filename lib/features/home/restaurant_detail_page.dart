// Make sure to import your routes and the CartItem model
import 'package:final_proj/core/resources/app_router.dart';
import 'package:final_proj/features/home/cart_manager.dart';
import 'package:flutter/material.dart';
import '../../core/resources/app_colors.dart';

import 'cart_screen.dart';

class RestaurantDetailPage extends StatefulWidget {
  final String restaurantName;
  final String restaurantImage;

  const RestaurantDetailPage({
    super.key,
    required this.restaurantName,
    required this.restaurantImage,
  });

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  final List<Map<String, dynamic>> menuItems = [
    {
      "name": "Signature Tacos",
      "price": 14.99,
      "image": "https://images.unsplash.com/photo-1552332386-f8dd00dc2f85",
      "quantity": 0
    },
    {
      "name": "Cheese Quesadillas",
      "price": 10.99,
      "image": "https://images.unsplash.com/photo-1593560708920-61dd98c46a4e",
      "quantity": 0
    },
    {
      "name": "Classic Churros",
      "price": 6.99,
      "image": "https://images.unsplash.com/photo-1578314675249-a6910f80cc4e",
      "quantity": 0
    },
  ];

  @override
  Widget build(BuildContext context) {
    int totalItems = menuItems.fold(0, (sum, item) => sum + (item['quantity'] as int));

    return Scaffold(
      backgroundColor: AppColors.globalDarkMode,
      body: Stack(
        children: [
          // 1. The Main Content
          Column(
            children: [
              _buildHeader(context),
              const SizedBox(height: 12),
              _buildInfoSection(),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 120),
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    return _menuItemRow(menuItems[index], index);
                  },
                ),
              ),
            ],
          ),

          // 2. The Floating Button (Covers bottom nav area)
          if (totalItems > 0)
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildBottomCartButton(totalItems),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomCartButton(int count) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.globalDarkMode,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 0,
          ),
          // Inside RestaurantDetailPage onPressed:
          onPressed: () {
            List<CartItem> selectedItems = menuItems
                .where((item) => item['quantity'] > 0)
                .map((item) => CartItem(
              name: item['name'],
              image: item['image'],
              price: item['price'],
              quantity: item['quantity'],
            ))
                .toList();

            // Save to Global Manager
            CartManager().addItems(selectedItems);

            // Optional: Show a message to the user
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Added to Order!"), backgroundColor: Colors.green),
            );

            // Optional: Reset the quantities on this page back to 0 after adding
            setState(() {
              for (var item in menuItems) { item['quantity'] = 0; }
            });
          },
          child: Text(
            "Add $count items to cart",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuItemRow(Map<String, dynamic> item, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item['image'],
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 70,
                height: 70,
                color: Colors.grey[800],
                child: const Icon(Icons.fastfood, color: Colors.white24),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "\$${item['price']}",
                  style: const TextStyle(color: Colors.greenAccent),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _quantityController(index),
        ],
      ),
    );
  }

  Widget _quantityController(int index) {
    int qty = menuItems[index]['quantity'];
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1F26),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.green.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (qty > 0) ...[
            IconButton(
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.remove, color: Colors.green, size: 18),
              onPressed: () => setState(() => menuItems[index]['quantity']--),
            ),
            Text(
              "$qty",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.add, color: Colors.green, size: 18),
            onPressed: () => setState(() => menuItems[index]['quantity']++),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          widget.restaurantImage,
          height: 240,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              Container(height: 240, color: Colors.grey[900]),
        ),
        Positioned(
          top: 44,
          left: 16,
          child: CircleAvatar(
            backgroundColor: Colors.black54,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.restaurantName,
            style: const TextStyle(
                fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 4),
          const Text(
            "4.9 (103 Reviews) • 2.3km • 25 min",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}