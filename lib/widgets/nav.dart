import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:golfwang/pages/menu.dart';

class GWNav extends StatelessWidget {
  final String title;
  final Color titleColor;
  final Color background;
  final String icon;

  const GWNav({
    super.key,
    this.title = "GOLF",
    required this.titleColor,
    required this.background,
    this.icon = "menu",
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding:
            const EdgeInsets.only(top: 25, bottom: 29, left: 32, right: 32),
        decoration: BoxDecoration(
          color: background,
          border: Border(
            bottom: BorderSide(
              width: 2,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                  color: titleColor,
                  border: Border.all(
                    width: 3,
                    color: Theme.of(context).colorScheme.background,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.background,
                      offset: const Offset(4, 4),
                    ),
                  ]),
              child: Text(
                title,
                style: const TextStyle(fontFamily: "Arial", fontSize: 24),
              ),
            ),
            GestureDetector(
              child: SvgPicture.asset('assets/icons/$icon.svg'),
              onTap: () {
                switch (icon) {
                  case "menu":
                    {
                      Navigator.of(context).push(
                        MenuRoute(page: const GWMenu()),
                      );
                    }
                    break;
                  case "close":
                    {
                      Navigator.of(context).pop();
                    }
                    break;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GWChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const GWChip({
    super.key,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).colorScheme.onBackground,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          width: 2,
          color: Theme.of(context).colorScheme.background,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
