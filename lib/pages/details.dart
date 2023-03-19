import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../data/datas.dart';
import '../widgets/nav.dart';
import '../data/models.dart';
import '../widgets/items.dart';

class GWDetails extends StatelessWidget {
  const GWDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final itemId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: GWNav(
          background: Theme.of(context).colorScheme.tertiary,
          titleColor: Theme.of(context).colorScheme.secondary,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: DetailsBody(itemId: itemId),
    );
  }
}

class DetailsBody extends StatefulWidget {
  final String itemId;
  const DetailsBody({
    super.key,
    required this.itemId,
  });

  @override
  State<DetailsBody> createState() => _DetailsBodyState();
}

class _DetailsBodyState extends State<DetailsBody> {
  ItemSizes? selectedSize;
  late int currentImgIdx;

  void changeDropDownValue(val) {
    setState(() {
      selectedSize = val;
    });
  }

  void changeImageIdx(val) {
    setState(() {
      currentImgIdx = val;
    });
  }

  @override
  void initState() {
    currentImgIdx = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ItemsProvider>(context, listen: false);
    final item =
        data.items.firstWhere((element) => element.id == widget.itemId);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.width - 64,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 3,
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              child: Hero(
                tag: item.id,
                child: Image.network(item.designs[currentImgIdx].img),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: 300,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      item.name,
                      style: const TextStyle(
                          fontSize: 24, fontFamily: "Cabinet Grotesk Bold"),
                    ),
                  ),
                ),
                Consumer<ItemsProvider>(
                  builder: (context, prov, child) {
                    return GestureDetector(
                      onTap: () {
                        data.toggleFav(widget.itemId);
                      },
                      child: item.isFav
                          ? SvgPicture.asset("assets/icons/heart_fill.svg")
                          : SvgPicture.asset("assets/icons/heart_empty.svg"),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: ColorRow(
                colors: [...item.designs.map((e) => e.color)],
                space: 15,
                size: 25,
                border: 2,
                changeIndex: changeImageIdx,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              item.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                GWDropdown(
                  items: item.sizes,
                  selectedValue:
                      selectedSize ?? item.sizes[item.sizes.length - 1],
                  onChange: changeDropDownValue,
                ),
                const Spacer(),
                Text(
                  "\$ ${item.price.toStringAsFixed(0)}",
                  style: const TextStyle(
                      fontSize: 28, fontFamily: "Cabinet Grotesk Bold"),
                )
              ],
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Provider.of<CartProvider>(context, listen: false).addToCart(
                  "${item.name}_${currentImgIdx}_${(selectedSize ?? item.sizes[item.sizes.length - 1]).name}",
                  item.name,
                  selectedSize ?? item.sizes[item.sizes.length - 1],
                  item.designs[currentImgIdx],
                  item.price,
                );
                showSnack(context, "Item Added to Cart.");
              },
              child: const GWBigButton(text: "ADD TO CART"),
            )
          ],
        ),
      ),
    );
  }
}
