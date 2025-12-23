import 'package:final_proj/features/home/cart_screen.dart';

// Global Manager to hold cart items across the entire app
class CartManager {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  List<CartItem> items = [];

  void addItems(List<CartItem> newItems) {
    // This logic appends items if they don't exist, or updates quantity
    for (var newItem in newItems) {
      int index = items.indexWhere((i) => i.name == newItem.name);
      if (index != -1) {
        items[index].quantity += newItem.quantity;
      } else {
        items.add(newItem);
      }
    }
  }
}