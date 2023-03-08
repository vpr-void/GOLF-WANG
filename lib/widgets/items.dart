import 'package:flutter/material.dart';

class GWShopItem extends StatelessWidget {
  final String name;
  final double price;
  final String imageUrl;
  final List<Color> colors;

  const GWShopItem({
    super.key,
    this.name = "STAY AT HOME TEE",
    this.price = 40,
    this.imageUrl =
        "https://cdn.shopify.com/s/files/1/0412/0133/6481/products/2IrSGXpI_1080x.jpg?v=1667411013",
    this.colors = const [
      Color(0xFFBDD6E5),
      Color(0xFFFF800B),
      Color(0xFF000000),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Theme.of(context).colorScheme.background,
        ),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2,
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
            ),
            child: Image.network(
              imageUrl,
              width: 160,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                      fontSize: 16,
                    )),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          width: 2,
                          color: Theme.of(context).colorScheme.background,
                        ),
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      child: Text("\$ ${price.truncate()}",
                          style: const TextStyle(fontSize: 14)),
                    ),
                    SizedBox(
                      width: 50,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...colors.map((e) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: e,
                                border: Border.all(
                                  width: 1,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                              ),
                              width: 12,
                              height: 12,
                            );
                          })
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
