import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/nav.dart';
import '../data/models.dart';
import '../widgets/items.dart';

class GWDetails extends StatelessWidget {
  const GWDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as Item;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: GWNav(
          background: Theme.of(context).colorScheme.tertiary,
          titleColor: Theme.of(context).colorScheme.secondary,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: DetailsBody(item: item),
    );
  }
}

class DetailsBody extends StatefulWidget {
  final Item item;
  const DetailsBody({
    super.key,
    required this.item,
  });

  @override
  State<DetailsBody> createState() => _DetailsBodyState();
}

class _DetailsBodyState extends State<DetailsBody> {
  late bool isFav;
  late ItemSizes selectedSize;
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
    isFav = widget.item.isFav;
    selectedSize = widget.item.sizes[widget.item.sizes.length - 1];
    currentImgIdx = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                tag: widget.item.id,
                child: Image.network(widget.item.designs[currentImgIdx].img),
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
                      widget.item.name,
                      style: const TextStyle(
                          fontSize: 24, fontFamily: "Cabinet Grotesk Bold"),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isFav = !isFav;
                    });
                  },
                  child: isFav
                      ? SvgPicture.asset("assets/icons/heart_fill.svg")
                      : SvgPicture.asset("assets/icons/heart_empty.svg"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: ColorRow(
                colors: [...widget.item.designs.map((e) => e.color)],
                space: 15,
                size: 25,
                border: 2,
                changeIndex: changeImageIdx,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              widget.item.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                GWDropdown(
                  items: widget.item.sizes,
                  selectedValue: selectedSize,
                  onChange: changeDropDownValue,
                ),
                const Spacer(),
                Text(
                  "\$ ${widget.item.price.toStringAsFixed(0)}",
                  style: const TextStyle(
                      fontSize: 28, fontFamily: "Cabinet Grotesk Bold"),
                )
              ],
            ),
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(
                  width: 3,
                  color: Theme.of(context).colorScheme.background,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.background,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  "ADD TO CART",
                  style: TextStyle(
                      fontSize: 24, fontFamily: "Cabinet Grotesk Bold"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
