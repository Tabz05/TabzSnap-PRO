import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/chat_model.dart';
import 'package:tabzsnappro/models/user_data_models/other_user_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_id_model.dart';
import 'package:tabzsnappro/screens/mySingleChats/chat_tile.dart';
import 'package:tabzsnappro/services/database_service.dart';
import 'package:tabzsnappro/shared/loading.dart';

class ChatOtherDetails extends StatefulWidget {
  final ChatModel chatModel;
  ChatOtherDetails(this.chatModel);

  @override
  State<ChatOtherDetails> createState() => _ChatOtherDetailsState();
}

class _ChatOtherDetailsState extends State<ChatOtherDetails> {

  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {

    final _user = Provider.of<UserIdModel?>(context);

    var _recipient1 = widget.chatModel.recipients![0];
    var _recipient2 = widget.chatModel.recipients![1];

    String _otherPersonId = "";

    if (_user != null) 
    {
      if (_recipient1 == _user.uid)
      {
        _otherPersonId = _recipient2;
      } 
      else 
      {
        _otherPersonId = _recipient1;
      }
    }

    return _user == null
        ? Loading()
        : StreamProvider<OtherUserDataModel?>.value(
            catchError: (_, __) => null,
            initialData: null,
            value: DatabaseService(otherUserProfileId: _otherPersonId).otherUserDetails,
            child: ChatTile());
  }
}
