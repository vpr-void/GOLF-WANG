import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/nav.dart';
import '../widgets/items.dart';
import '../data/models.dart';
import '../data/datas.dart';

class GWCreate extends StatefulWidget {
  const GWCreate({super.key});

  @override
  State<GWCreate> createState() => _GWCreateState();
}

class _GWCreateState extends State<GWCreate> {
  final Map data = {};
  bool isNew = false;
  List<ItemTypes> allTypes = [...ItemTypes.values.map((e) => e)];
  ItemTypes? selectedType;
  List<ItemSizes> allSizes = [...ItemSizes.values.map((e) => e)];
  List<ItemSizes> selectedSizes = [];

  void changeSelectedType(val) {
    setState(() {
      selectedType = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    var itemID = ModalRoute.of(context)!.settings.arguments;
    Item? item = Provider.of<ItemsProvider>(context).getItem(itemID);
    isNew = item != null ? item.isNew : isNew;
    selectedType = item != null ? item.itemType : allTypes[0];
    selectedSizes = item != null ? item.sizes : selectedSizes;

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
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item == null ? "ADD NEW ITEM*" : "EDIT ITEM*",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 30),
              Form(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.fromBorderSide(bside(context)),
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      child: TextFormField(
                        controller: TextEditingController(
                            text: item != null ? item.name : ""),
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
                    SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.fromBorderSide(bside(context)),
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      child: TextFormField(
                        controller: TextEditingController(
                            text: item != null ? item.description : ""),
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
                    SizedBox(height: 20),
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
                            child: Center(
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
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                              child: TextFormField(
                                controller: TextEditingController(
                                    text: item != null
                                        ? item.price.toString()
                                        : ""),
                                cursorColor:
                                    Theme.of(context).colorScheme.background,
                                style: const TextStyle(fontSize: 18),
                                keyboardType: TextInputType.name,
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
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isNew = !isNew;
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3),
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onBackground,
                              border: Border.fromBorderSide(bside(context)),
                            ),
                            child: Center(
                                child: Container(
                              color: isNew
                                  ? Theme.of(context).colorScheme.onBackground
                                  : Theme.of(context).colorScheme.background,
                            )),
                          ),
                          SizedBox(width: 15),
                          Text(
                            "IS NEW ?",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("TYPE."),
                          SizedBox(height: 10),
                          GWDropdown(
                            items: allTypes,
                            selectedValue: selectedType,
                            onChange: changeSelectedType,
                            bold: false,
                            itemColor:
                                Theme.of(context).colorScheme.onBackground,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("AVAILABLE SIZES."),
                          SizedBox(height: 10),
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
                                            EdgeInsets.symmetric(vertical: 20),
                                        decoration: BoxDecoration(
                                          border: allSizes.indexOf(e) == 0
                                              ? null
                                              : Border(left: bside(context)),
                                          color: selectedSizes.contains(e)
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : null,
                                        ),
                                        child: Center(
                                          child: Text(
                                            e.name,
                                            style: TextStyle(fontSize: 16),
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
                    // ####################################################### HERE #####################################
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
