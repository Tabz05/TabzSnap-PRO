import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/message_models/messages_model.dart';
import 'package:tabzsnappro/screens/singleChat/message_tile.dart';

class SingleChatFin extends StatefulWidget {
  const SingleChatFin({Key? key}) : super(key: key);

  @override
  State<SingleChatFin> createState() => _SingleChatFinState();
}

class _SingleChatFinState extends State<SingleChatFin> {
  @override
  Widget build(BuildContext context) {
      
    final _messages = Provider.of<List<MessageModel>?>(context) ?? [];
     
     return Expanded(
       child: ListView.builder(
          itemCount: _messages.length,
          itemBuilder: (context,index){
            return MessageTile(_messages[index]);
          },
       ),
     );

  }
}