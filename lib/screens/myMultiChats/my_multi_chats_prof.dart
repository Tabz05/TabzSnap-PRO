import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/user_data_models/user_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_id_model.dart';
import 'package:tabzsnappro/screens/myMultiChats/my_multi_chats.dart';
import 'package:tabzsnappro/services/database_service.dart';
import 'package:tabzsnappro/shared/loading.dart';

class MyMultiChatsProf extends StatefulWidget {
  const MyMultiChatsProf({super.key});

  @override
  State<MyMultiChatsProf> createState() => _MyMultiChatsProfState();
}

class _MyMultiChatsProfState extends State<MyMultiChatsProf> {
  @override
  Widget build(BuildContext context) {
    
    final _user = Provider.of<UserIdModel?>(context);
      
    return _user==null? Loading() : StreamProvider<UserDataModel?>.value(
      catchError:(_,__)=>null,
      initialData: null,
      value: DatabaseService(uid:_user.uid).userDetails,
      child: MyMultiChats()
    );
  }
}