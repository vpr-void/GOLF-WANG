import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:golfwang/widgets/items.dart';
import 'package:provider/provider.dart';

import '../widgets/nav.dart';
import '../data/datas.dart';
import '../data/models.dart';

class GWCart extends StatelessWidget {
  const GWCart({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProv = Provider.of<CartProvider>(context);
    List<CartItem> cartItems = [];
    cartProv.getCart.forEach((key, value) {
      cartItems.add(value);
    });

    List emptyCart = [
      const GWEmptyMessage(
          message: "Cart is Empty.", icon: "assets/icons/cart.svg"),
    ];

    List itemCart = [
      ...cartItems.map(
        (e) => Dismissible(
          key: ValueKey(e.id),
          child: GWCartItem(e.id),
          onDismissed: (_) {
            cartProv.removeItem(e.id);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Item Removed from Cart."),
                duration: const Duration(seconds: 1),
                backgroundColor: Theme.of(context).colorScheme.background,
                elevation: 3,
              ),
            );
          },
        ),
      ),
      Container(
        decoration: BoxDecoration(
          border: Border(
            left: bside(context),
            right: bside(context),
            top: bside(context),
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
                  right: bside(context),
                ),
                color: Theme.of(context).colorScheme.onBackground,
              ),
              child: const Center(
                child: Text(
                  "Delivery",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                child: Text(
                  "\$ ${cartProv.deliveryFee.toStringAsFixed(0)}",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        decoration: BoxDecoration(
          border: Border(
            left: bside(context),
            right: bside(context),
            top: bside(context),
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
                  right: bside(context),
                ),
                color: Theme.of(context).colorScheme.onBackground,
              ),
              child: const Center(
                child: Text(
                  "Total",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                child: Text(
                  "\$ ${cartProv.getTotal}",
                  style: const TextStyle(fontSize: 20),
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
        child: const GWBigButton(text: "CHECKOUT"),
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
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 32),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Your Cart.",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      cartProv.cartItemCount == 1
                          ? "${cartProv.cartItemCount} items"
                          : "${cartProv.cartItemCount} item",
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                ...cartItems.isEmpty ? emptyCart : itemCart,
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

    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: bside(context),
          right: bside(context),
          top: bside(context),
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
                border: Border(right: bside(context)),
              ),
              child: Image.network(
                cartItem.design.img,
                width: 120,
                height: 120,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          cartItem.name,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 5),
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
                            const SizedBox(width: 10),
                            Text(
                              cartItem.size.name,
                              style: const TextStyle(fontSize: 14),
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
                              top: bside(context),
                              right: bside(context),
                            ),
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          width: 120,
                          height: 50,
                          child: Center(
                            child: Text(
                              "\$ ${(cartItem.price * cartItem.quantity).toStringAsFixed(0)}",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: bside(context),
                              ),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  style: const TextStyle(fontSize: 16),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cartProv.increaseItem(cartItem.id);
                                  },
                                  child:
                                      SvgPicture.asset("assets/icons/plus.svg"),
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
            )
          ],
        ),
      ),
    );
  }
}
