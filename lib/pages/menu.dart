import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:url_launcher/url_launcher.dart';

import '../widgets/nav.dart';

class GWMenu extends StatelessWidget {
  final List<Map> menus = const [
    {"name": "SHOP", "icon": "assets/icons/shop.svg", "route": "/"},
    {"name": "CART", "icon": "assets/icons/cart.svg", "route": "/cart"},
    {"name": "FAVOURITES", "icon": "assets/icons/heart.svg", "route": "/favs"},
    {"name": "ORDERS", "icon": "assets/icons/orders.svg", "route": "/orders"},
    {"name": "MANAGE", "icon": "assets/icons/manage.svg", "route": "/manage"},
  ];

  final List<Map> links = const [
    {
      "icon": "assets/icons/flower.svg",
      "color": Color(0xFFFFDD4A),
      "link": "https://golflefleur.com/",
    },
    {
      "icon": "assets/icons/web.svg",
      "color": Color(0xFFA9C973),
      "link": "https://golfwang.com/",
    },
    {
      "icon": "assets/icons/twitter.svg",
      "color": Color(0xFF70C9FF),
      "link": "https://twitter.com/tylerthecreator",
    },
    {
      "icon": "assets/icons/insta.svg",
      "color": Color(0xFFE3B5FF),
      "link": "https://www.instagram.com/golfwang",
    },
  ];

  const GWMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: GWNav(
          title: "MENU",
          background: Theme.of(context).colorScheme.secondary,
          titleColor: Theme.of(context).colorScheme.surface,
          icon: "close",
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.secondary,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 32),
        child: Column(
          children: [
            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 25),
              itemCount: menus.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (ctx, idx) {
                return GWMenuItem(
                  name: menus[idx]["name"],
                  iconUrl: menus[idx]["icon"],
                  route: menus[idx]["route"],
                );
              },
            ),
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...links.map((e) => GWLinkItem(
                        iconUrl: e["icon"],
                        color: e["color"],
                        link: e["link"],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GWMenuItem extends StatelessWidget {
  final String name;
  final String iconUrl;
  final String route;

  const GWMenuItem({
    super.key,
    required this.name,
    required this.iconUrl,
    this.route = "/",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(route);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onBackground,
            border: Border.all(
              width: 3,
              color: Theme.of(context).colorScheme.background,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.background,
                offset: const Offset(5, 5),
              ),
            ]),
        padding: const EdgeInsets.only(left: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                border: Border(
                  left: BorderSide(
                    width: 3,
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
              ),
              child: SvgPicture.asset(
                iconUrl,
                width: 30,
                height: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GWLinkItem extends StatelessWidget {
  final String iconUrl;
  final Color color;
  final String link;

  const GWLinkItem({
    super.key,
    required this.iconUrl,
    required this.color,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("lanch");
        launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            width: 2,
            color: Theme.of(context).colorScheme.background,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.background,
              offset: const Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: SvgPicture.asset(
          iconUrl,
          width: 25,
          height: 25,
        ),
      ),
    );
  }
}

class MenuRoute extends PageRouteBuilder {
  final Widget page;

  MenuRoute({required this.page})
      : super(
          transitionDuration: const Duration(milliseconds: 500),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (ctx, animation, animation2) {
            return page;
          },
          barrierColor: Colors.black38,
          transitionsBuilder: (ctx, animation, animation2, child) {
            Animation<double> crv =
                CurvedAnimation(parent: animation, curve: Curves.easeOutExpo);
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(crv),
              child: child,
            );
          },
        );
}
