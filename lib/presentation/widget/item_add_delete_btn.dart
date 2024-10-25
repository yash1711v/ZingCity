import 'package:flutter/material.dart';
import 'package:real_estate/presentation/utils/utils.dart';
import 'package:real_estate/presentation/widget/custom_test_style.dart';

import '../utils/constraints.dart';

class ItemAddBtn extends StatelessWidget {
  const ItemAddBtn({super.key, this.title = 'Add New'});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      //width: 100.0,
      // width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: greenColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextStyle(
            text: title,
            color: whiteColor,
            fontSize: 18.0,
          ),
          Utils.horizontalSpace(10.0),
          const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class ItemSaveBtn extends StatelessWidget {
  const ItemSaveBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
      decoration: BoxDecoration(
        color: yellowColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Text(
        "Save",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
      ),
    );
  }
}

class DeleteIconBtn extends StatelessWidget {
  const DeleteIconBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: redColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Icon(
        Icons.delete,
        size: 20,
        color: Colors.white,
      ),
    );
  }
}
