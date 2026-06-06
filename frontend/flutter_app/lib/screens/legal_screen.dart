import 'package:flutter/material.dart';

class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Legal Information')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('IP Compliance', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text(
              'GachaMerch is a fan-led project and is not affiliated with, endorsed by, or sponsored by miHoYo or HoYoverse. '
              'All "Honkai Star Rail" related characters, logos, and imagery are trademarks of miHoYo/HoYoverse.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text('Terms of Service', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(
              'This application is a prototype for demonstration purposes only. No actual transactions are processed, '
              'and no products will be shipped.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text('Contact', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(
              'For licensing inquiries or removal requests, please contact the project administrator.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
