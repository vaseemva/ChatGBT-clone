import 'package:chatgpt_clone/utils/colors.dart';
import 'package:chatgpt_clone/widgets/drop_down.dart';
import 'package:chatgpt_clone/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class Services {
  static Future<void> showModalsheet(BuildContext context) async {
    await showModalBottomSheet(
      backgroundColor: scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Flexible(child: TextWidget(label: "Selected Model :")),
              Flexible(flex: 2,child: ModelDropDown())
            ],
          ),
        );
      },
    );
  }
}
