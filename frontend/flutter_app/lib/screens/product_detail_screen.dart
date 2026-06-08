import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    if (widget.product.options != null && widget.product.options!.isNotEmpty) {
      _selectedOption = widget.product.options![0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 250,
              color: Colors.grey[100],
              child: widget.product.image != null
                  ? Image.asset(
                      'assets/${widget.product.image}',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(_getIconForProduct(widget.product.id), size: 100, color: Colors.indigo),
                    )
                  : Icon(_getIconForProduct(widget.product.id), size: 100, color: Colors.indigo),
            ),
            const SizedBox(height: 20),
            Text(
              widget.product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${widget.product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, color: Colors.indigo, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.description,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            if (widget.product.options != null) ...[
              const Text(
                'Select Option',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: widget.product.options!.map((opt) {
                  final isSelected = _selectedOption == opt;
                  return ChoiceChip(
                    label: Text(opt),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) setState(() => _selectedOption = opt);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
            ],
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<CartProvider>().addItem(widget.product, _selectedOption);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added ${widget.product.name} to cart'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Add to Cart', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForProduct(String id) {
    if (id.startsWith('TSR')) return Icons.checkroom;
    if (id.startsWith('PIN')) return Icons.blur_on;
    if (id.startsWith('KEY')) return Icons.vpn_key;
    if (id.startsWith('PR')) return Icons.image;
    if (id.startsWith('TOT')) return Icons.shopping_bag;
    return Icons.card_giftcard;
  }
}
