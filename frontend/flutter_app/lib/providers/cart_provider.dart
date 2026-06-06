import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};
  static const String _storageKey = 'gacha_merch_cart';
  static const String _ordersKey = 'gacha_merch_orders';

  CartProvider() {
    _loadFromPrefs();
  }

  Map<String, CartItem> get items => Map.unmodifiable(_items);
  final List<Map<String, dynamic>> _orders = [];
  List<Map<String, dynamic>> get orders => List.unmodifiable(_orders);

  int get totalCount => _items.values.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice => _items.values.fold(0, (sum, item) => sum + (item.product.price * item.quantity));

  void addItem(Product product, String? option) {
    final cartItem = CartItem(product: product, selectedOption: option);
    final key = cartItem.uniqueId;

    if (_items.containsKey(key)) {
      _items[key]!.quantity += 1;
    } else {
      _items[key] = cartItem;
    }
    _saveToPrefs();
    notifyListeners();
  }

  void removeItem(String key) {
    if (!_items.containsKey(key)) return;
    
    if (_items[key]!.quantity > 1) {
      _items[key]!.quantity -= 1;
    } else {
      _items.remove(key);
    }
    _saveToPrefs();
    notifyListeners();
  }

  void placeOrder(String name, String address) {
    if (_items.isEmpty) return;

    final order = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'date': DateTime.now().toIso8601String(),
      'items': _items.values.map((item) => item.toJson()).toList(),
      'total': totalPrice,
      'customer': {'name': name, 'address': address},
    };

    _orders.insert(0, order);
    _items.clear();
    _saveToPrefs();
    notifyListeners();
  }

  void clear() {
    _items.clear();
    _saveToPrefs();
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = _items.values.map((item) => item.toJson()).toList();
    await prefs.setString(_storageKey, jsonEncode(cartData));
    await prefs.setString(_ordersKey, jsonEncode(_orders));
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      final savedCart = prefs.getString(_storageKey);
      if (savedCart != null) {
        final List<dynamic> decoded = jsonDecode(savedCart);
        _items.clear();
        for (var itemData in decoded) {
          final item = CartItem.fromJson(itemData);
          _items[item.uniqueId] = item;
        }
      }

      final savedOrders = prefs.getString(_ordersKey);
      if (savedOrders != null) {
        final List<dynamic> decoded = jsonDecode(savedOrders);
        _orders.clear();
        _orders.addAll(List<Map<String, dynamic>>.from(decoded));
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading data from prefs: $e');
    }
  }
}
