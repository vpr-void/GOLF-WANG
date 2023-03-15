import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/datas.dart';
import '../widgets/nav.dart';
import '../widgets/items.dart';

class GWOrders extends StatelessWidget {
  final Widget emptyOrders = GWEmptyMessage(
      message: "You have No Orders yet.", icon: "assets/icons/orders.svg");

  Widget haveOrders(orders) {
    return ListView.separated(
      itemBuilder: (ctx, idx) {
        return Text(orders[idx].id);
      },
      separatorBuilder: (ctx, idx) {
        return SizedBox(height: 30);
      },
      itemCount: orders.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orderProv = Provider.of<OrderProvider>(context);
    final orders = orderProv.getOrders;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Orders.",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 30),
              orders.length == 0 ? emptyOrders : haveOrders(orders),
            ],
          ),
        ),
      ),
    );
  }
}
