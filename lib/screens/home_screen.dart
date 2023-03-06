import 'package:chatgpt_clone/providers/models_provider.dart';
import 'package:chatgpt_clone/services/api_service.dart';
import 'package:chatgpt_clone/services/assets_manager.dart';
import 'package:chatgpt_clone/services/services.dart';
import 'package:chatgpt_clone/utils/colors.dart';
import 'package:chatgpt_clone/utils/constants.dart';
import 'package:chatgpt_clone/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool _isTyping = false;
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManger.openAiLogo),
          ),
          elevation: 2,
          title: const Text('ChatGBT'),
          actions: [
            IconButton(
                onPressed: () async {
                  await Services.showModalsheet(context);
                },
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                ))
          ],
        ),
        body: SafeArea(
            child: Column(children: [
          Flexible(
            child: ListView.builder(
              itemBuilder: (context, index) => ChatWidget(
                msg: chatMessages[index]["msg"].toString(),
                index: int.parse(chatMessages[index]["chatIndex"].toString()),
              ),
              itemCount: 6,
            ),
          ),
          if (_isTyping) ...[
            const SpinKitThreeBounce(
              color: Colors.white,
              size: 18,
            ),
          ],
          const SizedBox(
            height: 12,
          ),
          Material(
            color: cardColor,
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _textEditingController,
                  onSubmitted: (value) {},
                  decoration: const InputDecoration.collapsed(
                      hintText: "Type a message",
                      hintStyle: TextStyle(color: Colors.grey)),
                )),
                IconButton(
                    onPressed: () async {
                      setState(() {
                        _isTyping = true;
                      });
                      try {
                        await ApiServices.sendmessage(
                            message: _textEditingController.text,
                            modelId: modelsProvider.getCurrentModel);
                      } catch (e) {
                        print(e.toString());
                      } finally {
                        setState(() {
                          _isTyping = false;
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ))
              ],
            ),
          )
        ])));
  }
}
