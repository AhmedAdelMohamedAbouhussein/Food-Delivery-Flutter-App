import 'package:final_proj/features/home/cart_screen.dart';

// Global Manager
class CartManager {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  List<CartItem> items = [];

  void addItems(List<CartItem> newItems) {

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