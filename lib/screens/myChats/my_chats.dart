import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/chat_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_id_model.dart';
import 'package:tabzsnappro/screens/myChats/my_chats_fin.dart';
import 'package:tabzsnappro/services/database_service.dart';

class MyChats extends StatefulWidget {
  const MyChats({Key? key}) : super(key: key);

  @override
  State<MyChats> createState() => _MyChatsState();
}

class _MyChatsState extends State<MyChats> {
  @override
  Widget build(BuildContext context) {
      
    final _user = Provider.of<UserIdModel?>(context);
      
    return _user==null?SizedBox():StreamProvider<List<ChatModel>?>.value(
      catchError:(_,__)=>null,
      initialData: null,
      value: DatabaseService(uid:_user.uid).getMyChats,
      child: MyChatsFin()
    );

  }
}