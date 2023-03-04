import 'dart:convert';

import 'dart:io';

import 'package:chatgpt_clone/models/models_model.dart';
import 'package:chatgpt_clone/utils/api_consts.dart';
import 'package:http/http.dart' as http;
class ApiServices {
  static Future<List<ModelsModel>>getModels()async{
    try {
    var response=await  http.get(Uri.parse("$baseurl/models"),headers: { 
        'Authorization': 'Bearer $apiKey'
      });
      Map jsonResponse=jsonDecode(response.body); 
      if(jsonResponse['error']!=null){
        print(jsonResponse['error']['message']);
        throw HttpException(jsonResponse['error']['message']);
        
      }
      List temp=[];
      for (var element in jsonResponse["data"]) {
        temp.add(element);
        // log("Tempffff $element['id']");
      }
     
      return ModelsModel.fromSnapshot(temp);
    } catch (e) {
      print(e.toString());
      rethrow; 
    }
  }
  
}