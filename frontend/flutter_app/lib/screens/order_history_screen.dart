import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<CartProvider>().orders;

    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: orders.isEmpty
          ? const Center(
              child: Text('No orders found', style: TextStyle(fontSize: 18, color: Colors.grey)),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, i) {
                final order = orders[i];
                final date = DateTime.parse(order['date']);
                final items = order['items'] as List;

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Order #${order['id']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text('${date.day}/${date.month}/${date.year}', style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                        const Divider(),
                        ...items.map((item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${item['product']['name']} (x${item['quantity']})'),
                              Text('\$${(item['product']['price'] * item['quantity']).toStringAsFixed(2)}'),
                            ],
                          ),
                        )),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Paid', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('\$${order['total'].toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('Ship to: ${order['customer']['name']}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        Text('Address: ${order['customer']['address']}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
