import 'package:chatgpt_clone/providers/models_provider.dart';
import 'package:chatgpt_clone/services/api_service.dart';
import 'package:chatgpt_clone/utils/colors.dart';
import 'package:chatgpt_clone/utils/constants.dart';
import 'package:chatgpt_clone/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModelDropDown extends StatefulWidget {
  const ModelDropDown({Key? key}) : super(key: key);

  @override
  State<ModelDropDown> createState() => _ModelDropDownState();
}

class _ModelDropDownState extends State<ModelDropDown> {
  String currentModel = 'text-davinci:001';
  @override
  Widget build(BuildContext context) {
    final modelsProvider=Provider.of<ModelsProvider>(context,listen: false);
    return FutureBuilder(
      future: modelsProvider.getAllModels(), 
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: TextWidget(label: snapshot.error.toString()),
          );
        }
        return snapshot.data == null || snapshot.data!.isEmpty
            ? const SizedBox.shrink()
            : FittedBox( 
              child: DropdownButton(
                  dropdownColor: scaffoldBackgroundColor,
                  iconEnabledColor: Colors.white,
                  items: List<DropdownMenuItem<String>>.generate(
                      snapshot.data!.length,
                      (index) => DropdownMenuItem(
                            value: snapshot.data![index].id,
                            child: TextWidget(label: snapshot.data![index].id),
                          )),
                  value: currentModel,
                  onChanged: (value) {
                    setState(() {
                      currentModel = value.toString();
                    });
                  },
                ),
            );
      },
    );
  }
}
