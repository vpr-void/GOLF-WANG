import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:palette_generator/palette_generator.dart';

import '../widgets/nav.dart';
import '../widgets/items.dart';
import '../data/models.dart';
import '../data/datas.dart';

Future<Color> getImagePalette(ImageProvider imageProvider) async {
  final PaletteGenerator paletteGenerator =
      await PaletteGenerator.fromImageProvider(imageProvider);
  return paletteGenerator.dominantColor!.color;
}

class GWCreate extends StatefulWidget {
  const GWCreate({super.key});

  @override
  State<GWCreate> createState() => _GWCreateState();
}

class _GWCreateState extends State<GWCreate> {
  TextEditingController nameCont = TextEditingController();
  TextEditingController descCont = TextEditingController();
  TextEditingController priceCont = TextEditingController();

  bool isNew = false;
  List<ItemTypes> allTypes = [...ItemTypes.values.map((e) => e)];
  ItemTypes? selectedType = ItemTypes.tees;
  List<ItemSizes> allSizes = [...ItemSizes.values.map((e) => e)];
  List<ItemSizes> selectedSizes = [];
  List<ItemDesign> varients = [];
  List<String> imageData = ["", "", "", "", ""];

  bool isNewFlag = false;
  bool typeFlag = false;

  void changeSelectedType(val) {
    setState(() {
      selectedType = val;
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameCont.dispose();
    descCont.dispose();
    priceCont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var itemID = ModalRoute.of(context)!.settings.arguments;
    Item? item = Provider.of<ItemsProvider>(context).getItem(itemID);

    isNew = item != null && !isNewFlag ? item.isNew : isNew;
    selectedType = item != null && !typeFlag ? item.itemType : selectedType;

    isNewFlag = true;
    typeFlag = true;

    selectedSizes = item != null ? item.sizes : selectedSizes;
    varients = item != null ? item.designs : varients;

    nameCont.text =
        item != null && nameCont.text.isEmpty ? item.name : nameCont.text;
    descCont.text = item != null && descCont.text.isEmpty
        ? item.description
        : descCont.text;
    priceCont.text = item != null && priceCont.text.isEmpty
        ? item.price.toString()
        : priceCont.text;

    if (item != null) {
      List itemImgs = [];
      for (var desg in item.designs) {
        itemImgs.add(desg.img);
      }
      imageData.replaceRange(0, itemImgs.length, [...itemImgs]);
    }

    final itemProv = Provider.of<ItemsProvider>(context, listen: false);
    final navi = Navigator.of(context);

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item == null ? "ADD NEW ITEM*" : "EDIT ITEM*",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.fromBorderSide(bside(context)),
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                child: TextField(
                  controller: nameCont,
                  cursorColor: Theme.of(context).colorScheme.background,
                  style: const TextStyle(fontSize: 18),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Name",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.fromBorderSide(bside(context)),
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                child: TextField(
                  controller: descCont,
                  cursorColor: Theme.of(context).colorScheme.background,
                  style: const TextStyle(fontSize: 18),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Description",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: bside(context),
                          bottom: bside(context),
                          left: bside(context),
                        ),
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      width: 50,
                      child: const Center(
                          child: Text(
                        "\$",
                        style: TextStyle(fontSize: 18),
                      )),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.fromBorderSide(bside(context)),
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        child: TextField(
                          controller: priceCont,
                          cursorColor: Theme.of(context).colorScheme.background,
                          style: const TextStyle(fontSize: 18),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Price",
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isNew = !isNew;
                  });
                },
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onBackground,
                        border: Border.fromBorderSide(bside(context)),
                      ),
                      child: Center(
                          child: Container(
                        color: isNew
                            ? Theme.of(context).colorScheme.background
                            : Theme.of(context).colorScheme.onBackground,
                      )),
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      "IS NEW ?",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("TYPE."),
                    const SizedBox(height: 10),
                    GWDropdown(
                      items: allTypes,
                      selectedValue: selectedType,
                      onChange: changeSelectedType,
                      bold: false,
                      itemColor: Theme.of(context).colorScheme.onBackground,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("AVAILABLE SIZES."),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onBackground,
                        border: Border.fromBorderSide(bside(context)),
                      ),
                      child: Row(
                        children: [
                          ...allSizes.map((e) {
                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSizes.contains(e)
                                        ? selectedSizes.remove(e)
                                        : selectedSizes.add(e);
                                  });
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  decoration: BoxDecoration(
                                    border: allSizes.indexOf(e) == 0
                                        ? null
                                        : Border(left: bside(context)),
                                    color: selectedSizes.contains(e)
                                        ? Theme.of(context).colorScheme.primary
                                        : null,
                                  ),
                                  child: Center(
                                    child: Text(
                                      e.name,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ListView.separated(
                itemBuilder: (ctx, idx) {
                  return IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.fromBorderSide(bside(context)),
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                          width: 120,
                          height: 120,
                          child: Center(
                            child: imageData[idx] != ""
                                ? Image.network(imageData[idx])
                                : SvgPicture.asset("assets/icons/add.svg"),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 0),
                            decoration: BoxDecoration(
                              border: Border.fromBorderSide(bside(context)),
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                            child: TextField(
                              controller:
                                  TextEditingController(text: imageData[idx]),
                              onSubmitted: (val) {
                                setState(() {
                                  imageData[idx] = val;
                                });
                              },
                              cursorColor:
                                  Theme.of(context).colorScheme.background,
                              style: const TextStyle(fontSize: 16),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.next,
                              maxLines: 4,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Image URL",
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (ctx, idx) {
                  return const SizedBox(height: 20);
                },
                itemCount: imageData.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () async {
                  if (nameCont.text == "" ||
                      descCont.text == "" ||
                      priceCont.text == "") {
                    showSnack(context, "Please fill the Empty Fields.");
                  } else if (selectedSizes.isEmpty) {
                    showSnack(context, "Please choose at least one Size.");
                  } else if (imageData.every((element) => element == "")) {
                    showSnack(context, "Please add at lease one Image.");
                  } else {
                    List tempDesigns = [];

                    for (var desg in imageData) {
                      if (desg.isNotEmpty) {
                        ItemDesign tempD = ItemDesign(
                          desg,
                          await getImagePalette(
                            NetworkImage(desg),
                          ),
                        );
                        tempDesigns.add(tempD);
                      }
                    }

                    Map<String, dynamic> tempData = {
                      "name": nameCont.text,
                      "description": descCont.text,
                      "price": double.parse(priceCont.text),
                      "isNew": isNew,
                      "type": selectedType,
                      "sizes": [...selectedSizes],
                      "designs": tempDesigns,
                    };

                    print(tempData);

                    item != null
                        ? itemProv.updateItem(item.id, tempData)
                        : itemProv.createItem(tempData);

                    navi.pop();
                  }
                },
                child: GWBigButton(text: item != null ? "UPDATE" : "ADD"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
