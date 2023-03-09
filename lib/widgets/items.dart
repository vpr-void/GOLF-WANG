import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../data/models.dart';

class GWShopItem extends StatelessWidget {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final List<Color> colors;

  const GWShopItem({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Theme.of(context).colorScheme.background,
        ),
        color: Theme.of(context).colorScheme.secondary,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.background,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2,
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
            ),
            child: Hero(
              tag: id,
              child: Image.network(
                imageUrl,
                width: 160,
                height: 160,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                      fontSize: 16,
                    )),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          width: 2,
                          color: Theme.of(context).colorScheme.background,
                        ),
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      child: Text("\$ ${price.truncate()}",
                          style: const TextStyle(fontSize: 14)),
                    ),
                    ColorRow(colors: colors, space: 6, size: 12)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ColorRow extends StatelessWidget {
  final List<Color> colors;
  final double space;
  final double size;
  final double border;
  final Function? changeIndex;

  const ColorRow({
    super.key,
    required this.colors,
    required this.space,
    required this.size,
    this.border = 1,
    this.changeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (space * (colors.length - 1)) + (colors.length * size),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...colors.map((e) {
            return GestureDetector(
              onTap: () {
                if (changeIndex != null) {
                  changeIndex!(colors.indexOf(e));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size / 2),
                  color: e,
                  border: Border.all(
                    width: 1,
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
                width: size,
                height: size,
              ),
            );
          })
        ],
      ),
    );
  }
}

class GWDropdown extends StatelessWidget {
  final List<ItemSizes> items;
  final ItemSizes selectedValue;
  final Function onChange;

  const GWDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 14,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        border: Border.all(
          width: 2,
          color: Theme.of(context).colorScheme.background,
        ),
      ),
      child: DropdownButton(
        value: selectedValue,
        onChanged: (newValue) {
          onChange(newValue);
        },
        items: items.map((x) {
          return DropdownMenuItem(
            value: x,
            child: Text(x.name),
          );
        }).toList(),
        dropdownColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        borderRadius: BorderRadius.circular(0),
        isExpanded: true,
        style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontFamily: "Cabinet Grotesk Bold"),
        underline: Container(color: Theme.of(context).colorScheme.tertiary),
        focusColor: Theme.of(context).colorScheme.secondary,
        alignment: Alignment.center,
        iconEnabledColor: Colors.black,
        icon: SvgPicture.asset("assets/icons/dropdown.svg"),
        iconSize: 10,
        isDense: true,
        itemHeight: 50,
        menuMaxHeight: 200,
      ),
    );
  }
}
