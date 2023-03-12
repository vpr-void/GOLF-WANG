import 'package:flutter/material.dart';

import 'models.dart';

class ItemsProvider with ChangeNotifier {
  final List<Item> _items = [
    Item(
      id: "G-1",
      name: "STAY AT HOME TEE",
      description:
          "ALL COTTON CLASSIC GOLF FIT T-SHIRT WITH SCREEN PRINTED FRONT GRAPHIC.",
      price: 40,
      isNew: false,
      isFav: true,
      sizes: [ItemSizes.XL, ItemSizes.XX, ItemSizes.LG],
      itemType: ItemTypes.tees,
      designs: [
        ItemDesign(
          "https://cdn.shopify.com/s/files/1/0412/0133/6481/products/4T32SaqE_1080x.jpg?v=1667411494",
          const Color(0xFFbcd5e3),
        ),
        ItemDesign(
          "https://cdn.shopify.com/s/files/1/0412/0133/6481/products/NUycdIac_1080x.jpg?v=1667411504",
          const Color(0xFFfd8117),
        ),
        ItemDesign(
          "https://cdn.shopify.com/s/files/1/0412/0133/6481/products/nji5u8sI_1080x.jpg?v=1667411506",
          const Color(0xFF000000),
        ),
      ],
    ),
    Item(
      id: "G-2",
      name: "GOLF WANG BREAKFAST TEE",
      description:
          "ALL COTTON CLASSIC GOLF FIT T-SHIRT WITH SCREEN PRINTED FRONT GRAPHIC.",
      price: 40,
      isNew: true,
      isFav: false,
      sizes: [ItemSizes.XL, ItemSizes.XX, ItemSizes.LG],
      itemType: ItemTypes.tees,
      designs: [
        ItemDesign(
          "https://cdn.shopify.com/s/files/1/0412/0133/6481/products/2IrSGXpI_1080x.jpg?v=1667411013",
          const Color(0xFF354f3b),
        ),
        ItemDesign(
          "https://cdn.shopify.com/s/files/1/0412/0133/6481/products/btdya6Vs_1080x.jpg?v=1667411016",
          const Color(0xFF69472e),
        ),
        ItemDesign(
          "https://cdn.shopify.com/s/files/1/0412/0133/6481/products/DtYmCjWY_1080x.jpg?v=1667411017",
          const Color(0xFF013a5f),
        ),
      ],
    ),
    Item(
      id: "G-3",
      name: "SAVE THE BEES TEE",
      description:
          "ALL COTTON CLASSIC GOLF FIT T-SHIRT WITH SCREEN PRINTED FRONT GRAPHIC.",
      price: 40,
      isNew: false,
      isFav: true,
      sizes: [ItemSizes.XL, ItemSizes.XX, ItemSizes.LG],
      itemType: ItemTypes.tees,
      designs: [
        ItemDesign(
          "https://cdn.shopify.com/s/files/1/0412/0133/6481/products/SAVETHEBEESTEE-WHITE_PINK2_1080x.jpg?v=1642715799",
          const Color(0xFFe7e9f8),
        ),
        ItemDesign(
          "https://cdn.shopify.com/s/files/1/0412/0133/6481/products/SAVETHEBEESTEE-BLACK2_853f9b55-c822-4019-9a36-65f95fca2f58_1080x.jpg?v=1642715810",
          const Color(0xFF000000),
        ),
        ItemDesign(
          "https://cdn.shopify.com/s/files/1/0412/0133/6481/products/SAVETHEBEESTEE-SAND2_6dcc692c-2b32-4fec-8995-78538d69e6a3_1080x.jpg?v=1642715823",
          const Color(0xFFbea891),
        ),
      ],
    ),
    Item(
      id: "G-4",
      name: "WESTERN SHIRT JACKET",
      description:
          "WOOL JACKET WITH CONTRAST MOHAIR PIECING AT CHEST AND SLEEVES. ALL OVER CONTRAST LEATHER PIPING WITH LEFT CHEST EMBROIDERY.",
      price: 250,
      isNew: true,
      isFav: true,
      sizes: [ItemSizes.XL, ItemSizes.XX, ItemSizes.LG],
      itemType: ItemTypes.tops,
      designs: [
        ItemDesign(
          "https://cdn.shopify.com/s/files/1/0412/0133/6481/products/WESTERNSHIRTJACKETGREEN1_1080x.jpg?v=1667599784",
          const Color(0xFFf4e9e1),
        ),
        ItemDesign(
          "https://cdn.shopify.com/s/files/1/0412/0133/6481/products/WESTERNSHIRTJACKETBLUE1_1080x.jpg?v=1667599701",
          const Color(0xFF161616),
        ),
      ],
    ),
    Item(
      id: "G-5",
      name: "STITCH SWEATPANTS",
      description:
          "COTTON BLEND FLEECE PANT WITH ALL OVER CONTRAST STITCHING AND EMBROIDERED LOGO.",
      price: 90,
      isNew: true,
      isFav: false,
      sizes: [ItemSizes.XL, ItemSizes.XX, ItemSizes.LG],
      itemType: ItemTypes.bottoms,
      designs: [
        ItemDesign(
          "https://cdn.shopify.com/s/files/1/0412/0133/6481/products/FW22LOGOSWEATS-BROWN_1080x.jpg?v=1675797739",
          const Color(0xFF644942),
        ),
        ItemDesign(
          "https://cdn.shopify.com/s/files/1/0412/0133/6481/products/FW22LOGOSWEATS-YELLOW_1080x.jpg?v=1675797739",
          const Color(0xFFe9c959),
        ),
        ItemDesign(
          "https://cdn.shopify.com/s/files/1/0412/0133/6481/products/FW22LOGOSWEATS-MINT_1080x.jpg?v=1675797748",
          const Color(0xFFbacfcc),
        ),
      ],
    ),
    Item(
      id: "G-6",
      name: "COLLARED LOGO SWEATER",
      description:
          "COTTON BLEND LONG SLEEVE SWEATER WITH CONTRAST COLLAR AND FRONT CHEST EMBROIDERED LOGO.",
      price: 100,
      isNew: true,
      isFav: false,
      sizes: [ItemSizes.XL, ItemSizes.XX, ItemSizes.LG],
      itemType: ItemTypes.tops,
      designs: [
        ItemDesign(
          "https://cdn.shopify.com/s/files/1/0412/0133/6481/products/GALAXYCOLLAREDSWEATERGREEN_1080x.jpg?v=1666979354",
          const Color(0xFF4b7c4b),
        ),
        ItemDesign(
          "https://cdn.shopify.com/s/files/1/0412/0133/6481/products/GALAXYCOLLAREDSWEATERCAMELIA_1080x.jpg?v=1666979351",
          const Color(0xFFff473a),
        ),
      ],
    ),
    Item(
      id: "G-7",
      name: "PUZZLE CAMO BEANIE",
      description: "ALL ACRLYIC JACQUARD GRAPHIC BEANIE.",
      price: 40,
      isNew: false,
      isFav: true,
      sizes: [ItemSizes.XL, ItemSizes.XX, ItemSizes.LG],
      itemType: ItemTypes.hats,
      designs: [
        ItemDesign(
          "https://cdn.shopify.com/s/files/1/0412/0133/6481/products/PUZZLECAMOBEANIEGREEN_1080x.jpg?v=1667503512",
          const Color(0xFF477547),
        ),
        ItemDesign(
          "https://cdn.shopify.com/s/files/1/0412/0133/6481/products/PUZZLECAMOBEANIEIVORY_1080x.jpg?v=1667503513",
          const Color(0xFFcfbea0),
        ),
      ],
    ),
    Item(
      id: "G-8",
      name: "3D GOLF NECKLACE",
      description: "18K GOLD FILL/ENAMEL.",
      price: 60,
      isNew: false,
      isFav: true,
      sizes: [ItemSizes.XL, ItemSizes.XX, ItemSizes.LG],
      itemType: ItemTypes.accessories,
      designs: [
        ItemDesign(
          "https://cdn.shopify.com/s/files/1/0412/0133/6481/products/3DGOLFNECKLACE_1080x.jpg?v=1616626030",
          const Color(0xFFfabe8a),
        ),
      ],
    ),
    Item(
      id: "G-9",
      name: "GOLF LOGO TOTE BAG",
      description:
          "ALL NYLON PUFFER WITH ALL OVER CONTRAST STITCHING, FRONT EMBROIDERED LOGO AND NYLON WEBBED STRAPS.",
      price: 60,
      isNew: true,
      isFav: true,
      sizes: [ItemSizes.XL, ItemSizes.XX, ItemSizes.LG],
      itemType: ItemTypes.accessories,
      designs: [
        ItemDesign(
          "https://cdn.shopify.com/s/files/1/0412/0133/6481/products/FW22NYLONTOTEBAG-YELLOW_1080x.jpg?v=1675716322",
          const Color(0xFFe9c959),
        ),
        ItemDesign(
          "https://cdn.shopify.com/s/files/1/0412/0133/6481/products/FW22NYLONTOTEBAG-BROWN_1080x.jpg?v=1675716322",
          const Color(0xFF644942),
        ),
        ItemDesign(
          "https://cdn.shopify.com/s/files/1/0412/0133/6481/products/FW22NYLONTOTEBAG-MINT_1080x.jpg?v=1675716322",
          const Color(0xFFbacfcc),
        ),
      ],
    ),
  ];

  List<Item> get items {
    return [..._items];
  }

  Item getItem(id) {
    return _items.where((e) => e.id == id).toList()[0];
  }

  void addItem(item) {
    _items.add(item);
    notifyListeners();
  }

  List<Item> filterItems(filter, isFav) {
    List<Item> result =
        isFav ? [..._items.where((element) => element.isFav)] : [..._items];

    if (filter == "all") {
      return [...result];
    } else if (filter == "new") {
      return [...result.where((element) => element.isNew)];
    } else {
      return [...result.where((element) => element.itemType.name == filter)];
    }
  }

  void toggleFav(id) {
    _items.firstWhere((element) => element.id == id).toggleFav();
    notifyListeners();
  }
}