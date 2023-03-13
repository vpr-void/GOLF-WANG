import 'package:flutter/material.dart';
import 'package:golfwang/data/datas.dart';
import 'package:provider/provider.dart';

import '../widgets/nav.dart';
import '../data/models.dart';

class GWConfirm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProv = Provider.of<CartProvider>(context, listen: false);
    List<CartItem> cartItems = [];
    cartProv.getCart.forEach((key, value) {
      cartItems.add(value);
    });
    final borSide = BorderSide(
      width: 2,
      color: Theme.of(context).colorScheme.background,
    );

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
                      "Checkout.",
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
                ...cartItems.map((e) => GWCheckoutItem(e)),
                Container(
                  decoration: BoxDecoration(
                    border: Border.fromBorderSide(borSide),
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: 92,
                          height: 70,
                          decoration: BoxDecoration(
                            border: Border(right: borSide),
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                          child: Center(
                            child: Text(
                              "Total",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Theme.of(context).colorScheme.surface,
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
                )
              ],
            ),
          ),
        ));
  }
}

class GWCheckoutItem extends StatelessWidget {
  final CartItem item;
  const GWCheckoutItem(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final borSide = BorderSide(
      width: 2,
      color: Theme.of(context).colorScheme.background,
    );

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: borSide,
          right: borSide,
          left: borSide,
        ),
        color: Theme.of(context).colorScheme.onBackground,
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: Border(right: borSide),
                color: Theme.of(context).colorScheme.onBackground,
              ),
              child: Image.network(
                item.design.img,
                width: 80,
                height: 80,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: item.design.color,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          item.size.name,
                          style: TextStyle(fontSize: 14),
                        ),
                        Spacer(),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 7),
                          decoration: BoxDecoration(
                            border: Border.fromBorderSide(borSide),
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          child: Text(
                            "x${item.quantity}",
                            style: TextStyle(fontSize: 12),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: 80,
              decoration: BoxDecoration(
                border: Border(left: borSide),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Center(
                child: Text(
                  "\$ ${(item.price * item.quantity).toStringAsFixed(0)}",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
