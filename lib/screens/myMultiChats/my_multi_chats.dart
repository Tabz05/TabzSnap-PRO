import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/multi_chat_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_id_model.dart';
import 'package:tabzsnappro/screens/myMultiChats/my_multi_chats_fin.dart';
import 'package:tabzsnappro/services/database_service.dart';
import 'package:tabzsnappro/shared/loading.dart';

class MyMultiChats extends StatefulWidget {
  const MyMultiChats({super.key});

  @override
  State<MyMultiChats> createState() => _MyMultiChatsState();
}

class _MyMultiChatsState extends State<MyMultiChats> {
  @override
  Widget build(BuildContext context) {
    
    final _user = Provider.of<UserIdModel?>(context);
      
    return _user==null? Loading():StreamProvider<List<MultiChatModel>?>.value(
      catchError:(_,__)=>null,
      initialData: null,
      value: DatabaseService(uid:_user.uid).getMyMultiChats,
      child: MyMultiChatsFin()
    );
  }
}