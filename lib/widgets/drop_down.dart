import 'package:chatgpt_clone/utils/colors.dart';
import 'package:chatgpt_clone/utils/constants.dart';
import 'package:flutter/material.dart';

class ModelDropDown extends StatefulWidget {
  const ModelDropDown({Key? key}) : super(key: key);

  @override
  State<ModelDropDown> createState() => _ModelDropDownState();
}

class _ModelDropDownState extends State<ModelDropDown> {
  String currentModel = 'Model1';
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: scaffoldBackgroundColor,
      iconEnabledColor: Colors.white, 
      items: getModelsItem,
      value: currentModel, 
      onChanged: (value) {
        setState(() {
          currentModel = value.toString();
        });
      },
    );
  }
}
