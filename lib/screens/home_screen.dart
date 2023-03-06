import 'package:chatgpt_clone/providers/chat_provider.dart';
import 'package:chatgpt_clone/providers/models_provider.dart';
import 'package:chatgpt_clone/services/assets_manager.dart';
import 'package:chatgpt_clone/services/services.dart';
import 'package:chatgpt_clone/utils/colors.dart';
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
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  // List<ChatModel> chatList =;
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
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
              controller: _scrollController,
              itemBuilder: (context, index) => ChatWidget(
                msg: chatProvider.chatListl[index].msg,
                index: chatProvider.chatListl[index].chatIndex,
              ),
              itemCount: chatProvider.chatListl.length,
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
                      enabled: !_isTyping,
                  focusNode: _focusNode,
                  style: const TextStyle(color: Colors.white),
                  controller: _textEditingController,
                  onSubmitted: (value) async {
                    await sendmessage(modelsProvider, chatProvider);
                  },
                  decoration: const InputDecoration.collapsed(
                      hintText: "Type a message",
                      hintStyle: TextStyle(color: Colors.grey)),
                )),
                IconButton(
                    onPressed: () async {
                      await sendmessage(modelsProvider, chatProvider);
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

  scrollToEnd() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.easeInOut);
  }

  sendmessage(ModelsProvider modelsProvider, ChatProvider chatProvider) async {
    if (_textEditingController.text.isNotEmpty) {
      String msg = _textEditingController.text;
      setState(() {
        _isTyping = true;

        chatProvider.addUserMessage(message: msg);
        _textEditingController.clear();
        _focusNode.unfocus();
      });
      try {
        await chatProvider.sendMessageAndGetResp(
            message: msg, chosenModel: modelsProvider.getCurrentModel);

        setState(() {});
      } catch (e) {
        print(e.toString());
      } finally {
        setState(() {
          scrollToEnd();
          _isTyping = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("please Type something")));
    }
  }
}
