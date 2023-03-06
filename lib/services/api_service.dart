import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chatgpt_clone/models/chat_model.dart';
import 'package:chatgpt_clone/models/models_model.dart';
import 'package:chatgpt_clone/utils/api_consts.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(Uri.parse("$baseurl/models"),
          headers: {'Authorization': 'Bearer $apiKey'});
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        print(jsonResponse['error']['message']);
        throw HttpException(jsonResponse['error']['message']);
      }
      List temp = [];
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

  //send message
  static Future<List<ChatModel>> sendmessage(
      {required String message, required String modelId}) async {
    try {
      log("modelId $modelId");
      var response = await http.post(
          Uri.parse("https://api.openai.com/v1/completions"),
          headers: {
            'Authorization': 'Bearer $apiKey',
            "Content-Type": "application/json"
          },
          body: jsonEncode(
              {"model": modelId, "prompt": message, "max_tokens": 100}));
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        print(jsonResponse['error']['message']);
        print(response.statusCode);
        throw HttpException(jsonResponse['error']['message']);
      }
      List<ChatModel> list = [];

      if (jsonResponse['choices'].length > 0) {
        print("${jsonResponse['choices'][0]['text']}");
        list = List.generate(
            jsonResponse['choices'].length,
            (index) => ChatModel(
                msg: jsonResponse['choices'][index]['text'], chatIndex: 1));
      }
      return list;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
