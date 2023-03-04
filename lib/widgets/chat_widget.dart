import 'package:chatgpt_clone/services/assets_manager.dart';
import 'package:chatgpt_clone/utils/colors.dart';
import 'package:chatgpt_clone/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({Key? key, required this.msg, required this.index})
      : super(key: key);
  final String msg;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: index == 0 ? scaffoldBackgroundColor : cardColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                Image.asset(
                  index == 0 ? AssetsManger.personLogo : AssetsManger.chatLogo,
                  height: 30,
                  width: 30,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(label: msg),
                )),
                index==0?const SizedBox.shrink():Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.thumb_up_alt,color: Colors.white,),
                    SizedBox(width: 8,),
                     Icon(Icons.thumb_down_alt,color: Colors.white,) 
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
