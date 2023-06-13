import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/chat_model.dart';
import 'package:tabzsnappro/screens/myChats/chat_other_details.dart';
import 'package:tabzsnappro/shared/colors.dart';

class MyChatsFin extends StatefulWidget {
  const MyChatsFin({Key? key}) : super(key: key);

  @override
  State<MyChatsFin> createState() => _MyChatsFinState();
}

class _MyChatsFinState extends State<MyChatsFin> {
  @override
  Widget build(BuildContext context) {
       
    final _chats = Provider.of<List<ChatModel>?>(context) ?? [];
     
     return SafeArea(
       child: Scaffold(
         backgroundColor: backgroundColor,
         appBar: AppBar(
          title: Text("Your Chats"),
          centerTitle: true,
          backgroundColor: red_main,
         ),
         body: ListView.builder(
              itemCount: _chats.length,
              itemBuilder: (context,index){
                return ChatOtherDetails(_chats[index]);
              },
         ),
       ),
     );
  }
}