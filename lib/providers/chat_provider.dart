import 'package:chatgpt_clone/models/chat_model.dart';
import 'package:chatgpt_clone/services/api_service.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier{
  List<ChatModel>chatListl=[];
  List<ChatModel> get getChatList=>chatListl;

  addUserMessage({required String message}){
    chatListl.add(ChatModel(msg: message, chatIndex:0));
  }

 Future<void> sendMessageAndGetResp({required String message,required String chosenModel})async{
    chatListl.addAll(await ApiServices.sendmessage(
          message: message,
          modelId: chosenModel));
          notifyListeners();
  }
}