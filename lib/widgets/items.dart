import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../data/models.dart';

class GWShopItem extends StatelessWidget {
  final Color bgColor;

  const GWShopItem({
    super.key,
    this.bgColor = const Color(0xFFFAB9C9),
  });

  @override
  Widget build(BuildContext context) {
    final Item item = Provider.of<Item>(context);

    return Container(
      width: 160,
      decoration: BoxDecoration(
        border: Border.fromBorderSide(bside(context)),
        color: bgColor,
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
                bottom: bside(context),
              ),
            ),
            child: Hero(
              tag: item.id,
              child: Image.network(
                item.designs[0].img,
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
                Text(item.name,
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
                        border: Border.fromBorderSide(bside(context)),
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      child: Text("\$ ${item.price.truncate()}",
                          style: const TextStyle(fontSize: 14)),
                    ),
                    ColorRow(
                        colors: [...item.designs.map((e) => e.color)],
                        space: 6,
                        size: 12)
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
  final List<dynamic> items;
  final dynamic selectedValue;
  final Function onChange;
  final bool bold;
  final Color itemColor;

  const GWDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChange,
    this.bold = true,
    this.itemColor = const Color(0xFFBDD6E5),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 14,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        border: Border.fromBorderSide(bside(context)),
      ),
      child: DropdownButton(
        value: selectedValue,
        onChanged: (newValue) {
          onChange(newValue);
        },
        items: items.map((x) {
          return DropdownMenuItem(
            value: x,
            child: Text(x.toString().split('.').last.toUpperCase()),
          );
        }).toList(),
        dropdownColor: itemColor,
        elevation: 0,
        borderRadius: BorderRadius.circular(0),
        isExpanded: true,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontFamily: bold ? "Cabinet Grotesk Bold" : "Cabinet Grotesk",
        ),
        underline: Container(color: Theme.of(context).colorScheme.tertiary),
        focusColor: Theme.of(context).colorScheme.secondary,
        alignment: Alignment.center,
        iconEnabledColor: Colors.black,
        icon: SvgPicture.asset("assets/icons/dropdown.svg"),
        iconSize: 10,
        itemHeight: 50,
        menuMaxHeight: 200,
      ),
    );
  }
}

class GWBigButton extends StatelessWidget {
  final String text;

  const GWBigButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Center(
        child: Text(
          text,
          style:
              const TextStyle(fontSize: 24, fontFamily: "Cabinet Grotesk Bold"),
        ),
      ),
    );
  }
}

class GWEmptyMessage extends StatelessWidget {
  final String message;
  final String icon;

  const GWEmptyMessage({
    super.key,
    required this.message,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 175, horizontal: 50),
          decoration: BoxDecoration(
            border: Border(
              left: bside(context),
              right: bside(context),
              top: bside(context),
            ),
            color: Theme.of(context).colorScheme.onBackground,
          ),
          child: Column(
            children: [
              SvgPicture.asset(
                icon,
                width: 75,
                height: 75,
              ),
              const SizedBox(height: 10),
              Text(
                message,
                style: const TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed("/");
          },
          child: const GWBigButton(text: "GO TO SHOP"),
        ),
      ],
    );
  }
}

BorderSide bside(ctx) {
  return BorderSide(width: 2, color: Theme.of(ctx).colorScheme.background);
}

void showSnack(context, message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1),
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 3,
    ),
  );
}
