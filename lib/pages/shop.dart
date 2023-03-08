import 'package:flutter/material.dart';

import '../widgets/nav.dart';
import '../widgets/items.dart';

class GWShop extends StatelessWidget {
  final List DUMMMM = const [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];
  const GWShop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: GWNav(
          background: Theme.of(context).colorScheme.primary,
          titleColor: Theme.of(context).colorScheme.tertiary,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 32, top: 30),
              child: const Text(
                "Shop*",
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  children: const [
                    GWChip(label: "New", isSelected: true),
                    SizedBox(width: 8),
                    GWChip(label: "All"),
                    SizedBox(width: 8),
                    GWChip(label: "New"),
                    SizedBox(width: 8),
                    GWChip(label: "All"),
                    SizedBox(width: 8),
                    GWChip(label: "New"),
                    SizedBox(width: 8),
                    GWChip(label: "All"),
                    SizedBox(width: 8),
                    GWChip(label: "New"),
                    SizedBox(width: 8),
                    GWChip(label: "All"),
                    SizedBox(width: 8),
                    GWChip(label: "New"),
                    SizedBox(width: 8),
                    GWChip(label: "All"),
                    SizedBox(width: 8),
                    GWChip(label: "New"),
                    SizedBox(width: 8),
                    GWChip(label: "All"),
                    SizedBox(width: 8),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 160 / 285,
                  mainAxisSpacing: 40,
                  crossAxisSpacing: MediaQuery.of(context).size.width - 384,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: DUMMMM.length,
                itemBuilder: (ctx, idx) {
                  return const GWShopItem();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
