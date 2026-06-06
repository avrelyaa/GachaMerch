import 'product.dart';

class CartItem {
  final Product product;
  final String? selectedOption;
  int quantity;

  CartItem({
    required this.product,
    this.selectedOption,
    this.quantity = 1,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']),
      selectedOption: json['selectedOption'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'selectedOption': selectedOption,
      'quantity': quantity,
    };
  }

  String get uniqueId => '${product.id}_${selectedOption ?? ""}';
}
