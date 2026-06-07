class Product {
  final String id;
  final String name;
  final String type;
  final String description;
  final int stock;
  final String? image;
  final double price;
  final List<String>? options;

  const Product({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.stock,
    this.image,
    required this.price,
    this.options,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      description: json['description'],
      stock: json['stock'],
      image: json['image'],
      price: double.parse(json['price'].toString()),
      options: json['options'] != null ? List<String>.from(json['options']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'description': description,
      'stock': stock,
      'image': image,
      'price': price,
      'options': options,
    };
  }
}