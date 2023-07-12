import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/chat_models/chat_model.dart';
import 'package:tabzsnappro/models/chat_models/multi_chat_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_id_model.dart';
import 'package:tabzsnappro/screens/myMultiChats/my_multi_chat_tile.dart';
import 'package:tabzsnappro/shared/colors.dart';
import 'package:tabzsnappro/shared/loading.dart';

class MyMultiChatsFin extends StatefulWidget {
  const MyMultiChatsFin({super.key});

  @override
  State<MyMultiChatsFin> createState() => _MyMultiChatsFinState();
}

class _MyMultiChatsFinState extends State<MyMultiChatsFin> {
  @override
  Widget build(BuildContext context) {
    
    final _multiChats = Provider.of<List<MultiChatModel>?>(context) ?? [];
    final _user = Provider.of<UserIdModel?>(context);

    return _multiChats == null || _user == null
        ? Loading()
        : SafeArea(
            child: Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                title: Text("Your Group Chats"),
                centerTitle: true,
                backgroundColor: red_main,
              ),
              body: ListView.builder(
                      itemCount: _multiChats.length,
                      itemBuilder: (context, index) {
                        return MyMultiChatTile(_multiChats[index]);
                      },
                    ),
              ),
            );
          
  }
}