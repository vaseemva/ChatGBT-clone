import 'package:chatgpt_clone/models/models_model.dart';
import 'package:chatgpt_clone/services/api_service.dart';
import 'package:flutter/material.dart';

class ModelsProvider with ChangeNotifier {
  List<ModelsModel> models = [];
  String currentModel = 'text-davinci-003';
  List<ModelsModel> get getModels => models;

  String get getCurrentModel => currentModel;
  set setCurrentModel(String value) {
    currentModel = value;
    notifyListeners();
  }
  Future<List<ModelsModel>>getAllModels()async{
    models=await ApiServices.getModels();
    return models;
  }
}
