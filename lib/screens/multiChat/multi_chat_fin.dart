import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/message_models/multi_message_model.dart';
import 'package:tabzsnappro/screens/multiChat/multi_message_tile.dart';

class MultiChatFin extends StatefulWidget {
  const MultiChatFin({super.key});

  @override
  State<MultiChatFin> createState() => _MultiChatFinState();
}

class _MultiChatFinState extends State<MultiChatFin> {
  @override
  Widget build(BuildContext context) {
    
    final _multiMessages = Provider.of<List<MultiMessageModel>?>(context) ?? [];
     
     return Expanded(
       child: ListView.builder(
          itemCount: _multiMessages.length,
          itemBuilder: (context,index){
            return MultiMessageTile(_multiMessages[index]);
          },
       ),
     );
  }
}