import 'package:chatgpt_clone/providers/chat_provider.dart';
import 'package:chatgpt_clone/providers/models_provider.dart';
import 'package:chatgpt_clone/screens/home_screen.dart';
import 'package:chatgpt_clone/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        )
      ],
      child: MaterialApp(
        title: 'ChatGBT Clone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: scaffoldBackgroundColor,
            appBarTheme: AppBarTheme(color: cardColor)),
        home: const HomeScreen(),
      ),
    );
  }
}
