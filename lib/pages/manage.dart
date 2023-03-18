import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../widgets/nav.dart';
import '../widgets/items.dart';
import '../data/models.dart';
import '../data/datas.dart';

class GWManage extends StatelessWidget {
  const GWManage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<ItemsProvider>(context).items;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: GWNav(
          background: Theme.of(context).colorScheme.secondary,
          titleColor: Theme.of(context).colorScheme.surface,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 32),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "MANAGE ITEMS*",
                    style: TextStyle(fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed("/create");
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onBackground,
                          border: Border.fromBorderSide(bside(context)),
                          boxShadow: const [
                            BoxShadow(offset: Offset(3, 3)),
                          ]),
                      child: SvgPicture.asset('assets/icons/add.svg'),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              ListView.separated(
                itemBuilder: ((ctx, idx) {
                  return GWManageItem(item: items[idx]);
                }),
                separatorBuilder: (ctx, idx) {
                  return const SizedBox(height: 20);
                },
                itemCount: items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GWManageItem extends StatelessWidget {
  final Item item;

  const GWManageItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground,
        border: Border.fromBorderSide(bside(context)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              decoration: BoxDecoration(
                border: Border(right: bside(context)),
              ),
              child: Image.network(
                item.designs[0].img,
                width: 80,
                height: 80,
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    ColorRow(
                      colors: [...item.designs.map((e) => e.color)],
                      space: 10,
                      size: 15,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "\$ ${item.price}",
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        "/create",
                        arguments: item.id,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border(left: bside(context)),
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/pencil.svg",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          barrierColor: Colors.white70,
                          builder: (ctx) {
                            return Center(
                              child: Container(
                                width: 302,
                                decoration: BoxDecoration(
                                  border: Border.fromBorderSide(bside(context)),
                                  boxShadow: const [
                                    BoxShadow(offset: Offset(0, 3))
                                  ],
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 30),
                                        child: const Text(
                                          "SURE U WANNA DELETE?",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  top: bside(context),
                                                ),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surface,
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "CANCLE",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              Provider.of<ItemsProvider>(
                                                context,
                                                listen: false,
                                              ).removeItem(item.id);
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: bside(context),
                                                  top: bside(context),
                                                ),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "DELETE",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: 50,
                      decoration: BoxDecoration(
                        border:
                            Border(left: bside(context), top: bside(context)),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/close.svg",
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
