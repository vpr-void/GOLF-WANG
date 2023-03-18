import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../data/datas.dart';
import '../data/models.dart';
import '../widgets/nav.dart';
import '../widgets/items.dart';

class GWOrders extends StatelessWidget {
  final Widget emptyOrders = const GWEmptyMessage(
      message: "You have No Orders yet.", icon: "assets/icons/orders.svg");

  const GWOrders({super.key});

  Widget haveOrders(List<Order> orders, ctx) {
    return ListView.separated(
      itemBuilder: (ctx, idx) {
        return GWExpand(order: orders[idx]);
      },
      separatorBuilder: (ctx, idx) {
        return const SizedBox(height: 20);
      },
      itemCount: orders.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your Orders.",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),
              orders.isEmpty ? emptyOrders : haveOrders(orders, context),
            ],
          ),
        ),
      ),
    );
  }
}

class GWExpand extends StatefulWidget {
  final Order order;

  const GWExpand({super.key, required this.order});

  @override
  State<GWExpand> createState() => _GWExpandState();
}

class _GWExpandState extends State<GWExpand> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final BorderSide bside =
        BorderSide(width: 2, color: Theme.of(context).colorScheme.background);

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              border: Border.fromBorderSide(bside),
              color: Theme.of(context).colorScheme.onBackground,
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 100,
                    height: 90,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        border: Border(right: bside)),
                    child: Center(
                      child: Text(
                        "\$ ${widget.order.total.toStringAsFixed(0)}",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.order.buyerName,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.order.dateTime.millisecondsSinceEpoch.toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const Spacer(),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 300),
                    turns: isExpanded ? 0.5 : 0,
                    child: SvgPicture.asset(
                      "assets/icons/dropdown.svg",
                      width: 15,
                      height: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOutExpo,
          height: isExpanded
              ? (40 +
                      (15 * widget.order.items.length) +
                      (10 * widget.order.items.length - 1))
                  .toDouble()
              : 0,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              left: bside,
              right: bside,
              bottom: bside,
            ),
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 1000),
            padding: EdgeInsets.only(
                bottom: isExpanded ? 20 : 0, top: 20, left: 20, right: 20),
            child: ListView.separated(
              itemBuilder: (ctx, idx) {
                return Row(
                  children: [
                    Text(
                      widget.order.items[idx].name,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "x ${widget.order.items[idx].quantity}",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const Spacer(),
                    Text(
                      "\$ ${(widget.order.items[idx].price * widget.order.items[idx].quantity).toStringAsFixed(0)}",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: widget.order.items.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
        ),
      ],
    );
  }
}
