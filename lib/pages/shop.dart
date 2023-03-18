import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../widgets/nav.dart';
import '../widgets/items.dart';
import '../data/models.dart';
import '../data/datas.dart';

class GWShop extends StatefulWidget {
  final bool isFavPage;

  const GWShop({
    super.key,
    this.isFavPage = false,
  });

  @override
  State<GWShop> createState() => _GWShopState();
}

class _GWShopState extends State<GWShop> {
  final List<String> itemTypes = [
    "all",
    "new",
    ...ItemTypes.values.map((e) => e.name)
  ];
  int itemFilterIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isFavPage = widget.isFavPage;
    final List<Item> items = Provider.of<ItemsProvider>(context)
        .filterItems(itemTypes[itemFilterIndex], isFavPage);

    return Scaffold(
      backgroundColor: isFavPage
          ? Theme.of(context).colorScheme.secondary
          : Theme.of(context).colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: GWNav(
          background: isFavPage
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.primary,
          titleColor: isFavPage
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).colorScheme.tertiary,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 32, top: 30),
              child: Text(
                isFavPage ? "Favourites*" : "Shop*",
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  children: [
                    ...itemTypes.map((e) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                itemFilterIndex = itemTypes.indexOf(e);
                              });
                            },
                            child: GWChip(
                              label: e[0].toUpperCase() + e.substring(1),
                              isSelected:
                                  itemFilterIndex == itemTypes.indexOf(e),
                              selectedColor: isFavPage
                                  ? Theme.of(context).colorScheme.tertiary
                                  : Theme.of(context).colorScheme.surface,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      );
                    })
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
                  mainAxisSpacing: 45,
                  crossAxisSpacing: MediaQuery.of(context).size.width - 384,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (ctx, idx) {
                  return ChangeNotifierProvider.value(
                    value: items[idx],
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed("/details", arguments: items[idx].id);
                      },
                      child: GWShopItem(
                        bgColor: isFavPage
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
