import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/user_data_models/user_id_model.dart';
import 'package:tabzsnappro/screens/singleChat/single_chat_main.dart';
import 'package:tabzsnappro/services/database_service.dart';
import 'package:tabzsnappro/shared/loading.dart';

class SingleChat extends StatefulWidget {
  final String otherId;
  final String otherName;
  SingleChat(this.otherId, this.otherName);

  @override
  State<SingleChat> createState() => _SingleChatState();
}

class _SingleChatState extends State<SingleChat> {

  late DatabaseService _databaseService;
  late String _chatId;

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserIdModel?>(context);

    if (_user != null) 
    {
      List<String> _ids = [_user.uid!, widget.otherId];
      _ids.sort();

      _chatId = _ids[0] + _ids[1];

      _databaseService = DatabaseService(uid: _user.uid, otherId: widget.otherId, chatId: _chatId);
    }

    return _user==null? Loading() : FutureBuilder(
        future: _databaseService.add_chat(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // Future hasn't finished yet, return a placeholder
            return Loading();
          }
          return snapshot.data == true
              ? SingleChatMain(_chatId, widget.otherName)
              : Loading();
        });
  }
}
