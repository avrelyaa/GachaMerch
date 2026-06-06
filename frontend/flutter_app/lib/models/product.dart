class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final List<String>? options; // e.g. ['S', 'M', 'L', 'XL']

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.options,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      options: json['options'] != null ? List<String>.from(json['options']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'options': options,
    };
  }
}

final List<Product> sampleProducts = const [
  Product(
    id: 'TSR-001',
    name: 'T-shirt — TSR-001',
    description: 'Character silhouette tee (100% cotton)',
    price: 24.0,
    options: ['S', 'M', 'L', 'XL'],
  ),
  Product(
    id: 'PIN-001',
    name: 'Enamel pin — PIN-001',
    description: 'Hard enamel pin (1.25in)',
    price: 8.0,
  ),
  Product(
    id: 'KEY-001',
    name: 'Keychain — KEY-001',
    description: 'Acrylic charm keychain (50mm)',
    price: 6.0,
  ),
  Product(
    id: 'PR-001',
    name: 'Art print — PR-001',
    description: '8x12 matte art print (Limited run)',
    price: 12.0,
  ),
  Product(
    id: 'TOT-001',
    name: 'Tote bag — TOT-001',
    description: 'Natural canvas tote with simple logo',
    price: 14.0,
  ),
];
