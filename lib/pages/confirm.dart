import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/nav.dart';
import '../data/models.dart';
import '../data/datas.dart';
import '../widgets/items.dart';

class GWConfirm extends StatelessWidget {
  final nameField = TextEditingController();
  final emailField = TextEditingController();
  final phoneField = TextEditingController();
  final addressField = TextEditingController();

  GWConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProv = Provider.of<CartProvider>(context, listen: false);
    List<CartItem> cartItems = [];
    cartProv.getCart.forEach((key, value) {
      cartItems.add(value);
    });

    final contactInfo = Provider.of<ContactProvider>(context, listen: false);
    nameField.text = contactInfo.fullName;
    emailField.text = contactInfo.email;
    phoneField.text = contactInfo.phone;
    addressField.text = contactInfo.address;

    final ordersProv = Provider.of<OrderProvider>(context, listen: false);

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "Checkout.",
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
                ...cartItems.map((e) => GWCheckoutItem(e)),
                Container(
                  decoration: BoxDecoration(
                    border: Border.fromBorderSide(bside(context)),
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: 92,
                          height: 70,
                          decoration: BoxDecoration(
                            border: Border(right: bside(context)),
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                          child: const Center(
                            child: Text(
                              "Total",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Theme.of(context).colorScheme.surface,
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
                ),
                const SizedBox(height: 50),
                const Text(
                  "Contact Info.",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      left: bside(context),
                      top: bside(context),
                      right: bside(context),
                    ),
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  child: TextField(
                    controller: nameField,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    cursorColor: Theme.of(context).colorScheme.background,
                    style: const TextStyle(fontSize: 18),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Full Name",
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      left: bside(context),
                      top: bside(context),
                      right: bside(context),
                    ),
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  child: TextField(
                    controller: emailField,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    cursorColor: Theme.of(context).colorScheme.background,
                    style: const TextStyle(fontSize: 18),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      left: bside(context),
                      top: bside(context),
                      right: bside(context),
                    ),
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  child: TextField(
                    controller: phoneField,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    cursorColor: Theme.of(context).colorScheme.background,
                    style: const TextStyle(fontSize: 18),
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Phone",
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      left: bside(context),
                      top: bside(context),
                      right: bside(context),
                    ),
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  child: TextField(
                    controller: addressField,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    cursorColor: Theme.of(context).colorScheme.background,
                    style: const TextStyle(fontSize: 18),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Address",
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (nameField.text.isNotEmpty &&
                        emailField.text.isNotEmpty &&
                        phoneField.text.isNotEmpty &&
                        addressField.text.isNotEmpty) {
                      contactInfo.setValue(
                        fullName: nameField.text,
                        email: emailField.text,
                        phone: phoneField.text,
                        address: addressField.text,
                      );
                      ordersProv.createOrder(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        dateTime: DateTime.now(),
                        total: cartProv.getTotal,
                        buyerName: nameField.text,
                        items: cartItems,
                      );
                      cartProv.clearCart();
                      Navigator.of(context).pushNamed("/orders");
                    } else {
                      showSnack(context, "Please fill all fields.");
                    }
                  },
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.fromBorderSide(bside(context)),
                        color: Theme.of(context).colorScheme.tertiary,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.background,
                            offset: const Offset(0, 3),
                          ),
                        ]),
                    child: const Center(
                        child: Text(
                      "CONFIRM ORDER.",
                      style: TextStyle(fontSize: 18),
                    )),
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
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: bside(context),
          right: bside(context),
          left: bside(context),
        ),
        color: Theme.of(context).colorScheme.onBackground,
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: Border(right: bside(context)),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
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
                        const SizedBox(width: 10),
                        Text(
                          item.size.name,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 7),
                          decoration: BoxDecoration(
                            border: Border.fromBorderSide(bside(context)),
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          child: Text(
                            "x${item.quantity}",
                            style: const TextStyle(fontSize: 12),
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
                border: Border(left: bside(context)),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Center(
                child: Text(
                  "\$ ${(item.price * item.quantity).toStringAsFixed(0)}",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
