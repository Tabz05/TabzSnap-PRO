import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/chat_models/multi_chat_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_data_model.dart';
import 'package:tabzsnappro/screens/multiChat/multi_chat_main.dart';
import 'package:tabzsnappro/shared/loading.dart';

class MyMultiChatTile extends StatefulWidget {

  MultiChatModel multiChatModel;
  MyMultiChatTile(this.multiChatModel);

  @override
  State<MyMultiChatTile> createState() => _MyMultiChatTileState();
}

class _MyMultiChatTileState extends State<MyMultiChatTile> {
  @override
  Widget build(BuildContext context) {

    final _userDetails = Provider.of<UserDataModel?>(context);

    return _userDetails==null? Loading() : GestureDetector(
                onTap: () {

                  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider.value(
                              value: _userDetails,
                              child: MultiChatMain(widget.multiChatModel.chat_id,widget.multiChatModel.group_name),
                            ),
                          ),
                        );
                },
                child: ListTile(
                  
                  title: Text(widget.multiChatModel.group_name!),
                ),
              );
  }
}