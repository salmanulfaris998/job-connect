import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jobconnect/core/widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Iconsax.location, size: 20),
            SizedBox(width: 6),
            Text(
              'Kerala',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        title: const SizedBox.shrink(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.notification, size: 22),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.heart, size: 22),
          ),
        ],
      ),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
