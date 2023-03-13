import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:golfwang/widgets/items.dart';
import 'package:provider/provider.dart';

import '../widgets/nav.dart';
import '../data/datas.dart';
import '../data/models.dart';

class GWCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProv = Provider.of<CartProvider>(context);
    List<CartItem> cartItems = [];
    cartProv.getCart.forEach((key, value) {
      cartItems.add(value);
    });
    final borderSide = BorderSide(
      width: 2,
      color: Theme.of(context).colorScheme.background,
    );

    List emptyCart = [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 175, horizontal: 50),
            decoration: BoxDecoration(
              border: Border(
                left: borderSide,
                right: borderSide,
                top: borderSide,
              ),
              color: Theme.of(context).colorScheme.onBackground,
            ),
            child: Column(
              children: [
                SvgPicture.asset(
                  "assets/icons/cart.svg",
                  width: 75,
                  height: 75,
                ),
                SizedBox(height: 10),
                Text(
                  "Cart is Empty.",
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed("/");
            },
            child: GWBigButton(text: "GO TO SHOP"),
          ),
        ],
      )
    ];

    List itemCart = [
      ...cartItems.map(
        (e) => Dismissible(
          key: ValueKey(e.id),
          child: GWCartItem(e.id),
          onDismissed: (_) {
            cartProv.removeItem(e.id);
          },
        ),
      ),
      Container(
        decoration: BoxDecoration(
          border: Border(
            left: borderSide,
            right: borderSide,
            top: borderSide,
          ),
          color: Theme.of(context).colorScheme.onBackground,
        ),
        child: Row(
          children: [
            Container(
              width: 122,
              height: 80,
              decoration: BoxDecoration(
                border: Border(
                  right: borderSide,
                ),
                color: Theme.of(context).colorScheme.onBackground,
              ),
              child: Center(
                child: Text(
                  "Delivery",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                child: Text(
                  "\$ ${cartProv.deliveryFee.toStringAsFixed(0)}",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        decoration: BoxDecoration(
          border: Border(
            left: borderSide,
            right: borderSide,
            top: borderSide,
          ),
          color: Theme.of(context).colorScheme.tertiary,
        ),
        child: Row(
          children: [
            Container(
              width: 122,
              height: 80,
              decoration: BoxDecoration(
                border: Border(
                  right: borderSide,
                ),
                color: Theme.of(context).colorScheme.onBackground,
              ),
              child: Center(
                child: Text(
                  "Total",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                child: Text(
                  "\$ ${cartProv.getTotal}",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed("/confirm");
        },
        child: GWBigButton(text: "CHECKOUT"),
      ),
    ];

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: GWNav(
            background: Theme.of(context).colorScheme.primary,
            titleColor: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 32),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Your Cart.",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${cartProv.cartItemCount} items",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                ...cartItems.length == 0 ? emptyCart : itemCart,
              ],
            ),
          ),
        ));
  }
}

class GWCartItem extends StatelessWidget {
  final String id;

  const GWCartItem(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    final cartProv = Provider.of<CartProvider>(context);
    final cartItem = cartProv.getCartItem(id);

    final borderSide = BorderSide(
      width: 2,
      color: Theme.of(context).colorScheme.background,
    );

    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: borderSide,
          right: borderSide,
          top: borderSide,
        ),
        color: Theme.of(context).colorScheme.onBackground,
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onBackground,
                border: Border(right: borderSide),
              ),
              child: Image.network(
                cartItem.design.img,
                width: 120,
                height: 120,
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                      child: Column(
                        children: [
                          Text(
                            cartItem.name,
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: cartItem.design.color,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                cartItem.size.name,
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: borderSide,
                                right: borderSide,
                              ),
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            width: 120,
                            height: 50,
                            child: Center(
                              child: Text(
                                "\$ ${(cartItem.price * cartItem.quantity).toStringAsFixed(0)}",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: borderSide,
                                ),
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      cartProv.decreaseItem(cartItem.id);
                                    },
                                    child: SvgPicture.asset(
                                        "assets/icons/minus.svg"),
                                  ),
                                  Text(
                                    (cartItem.quantity).toString(),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      cartProv.increaseItem(cartItem.id);
                                    },
                                    child: SvgPicture.asset(
                                        "assets/icons/plus.svg"),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
