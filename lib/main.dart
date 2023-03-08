import 'package:flutter/material.dart';

import 'pages/cart.dart';
import 'pages/checkout.dart';
import 'pages/create.dart';
import 'pages/details.dart';
import 'pages/manage.dart';
import 'pages/menu.dart';
import 'pages/orders.dart';
import 'pages/shop.dart';

void main() {
  runApp(GolfWang());
}

class GolfWang extends StatelessWidget {
  final ColorScheme customColors = const ColorScheme.light().copyWith(
    primary: const Color(0xFFFAB9C9),
    secondary: const Color(0xFFBDD6E5),
    tertiary: const Color(0xFFFFDD4A),
    surface: const Color(0xFFA9C973),
    background: Colors.black,
    onBackground: Colors.white,
  );

  GolfWang({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GolfWang",
      theme: ThemeData(
        fontFamily: "Cabinet Grotesk",
        useMaterial3: true,
        colorScheme: customColors,
      ),
      home: const GWShop(),
      routes: {
        '/cart': (ctx) => GWCart(),
        '/checkout': (ctx) => GWCheckout(),
        '/orders': (ctx) => GWOrders(),
        '/favs': (ctx) => const GWShop(),
        '/details': (ctx) => GWDetails(),
        '/manage': (ctx) => GWManage(),
        '/create': (ctx) => GWCreate(),
      },
    );
  }
}
