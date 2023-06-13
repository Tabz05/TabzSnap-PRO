import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/messages_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_id_model.dart';
import 'package:tabzsnappro/shared/encryption.dart';

class MessageTile extends StatefulWidget {
  
  final MessageModel messageModel;
  MessageTile(this.messageModel);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {

    final _user = Provider.of<UserIdModel?>(context);

    bool _isSender = widget.messageModel.sender==_user!.uid;

    //applying vigenere cipher to decrypt text message

    String _decryptMessage(String message)
    {
        String decryptedMessage = "";

        int n  = message.length;

        int dec;

        for(int i=0;i<n;i++)
        {
           if(message[i]==' ' || operators.contains(message[i]))
           {
              decryptedMessage+=message[i];
           }
           else if(message[i]==message[i].toUpperCase())
           {
              dec = ((int.parse(message[i].codeUnits[0].toString())-65) - (int.parse(encryptionKey[i%keyLen].toUpperCase().codeUnits[0].toString())-65) +26)%26;
              dec+=65;
              decryptedMessage+=String.fromCharCode(dec);
           }
           else
           {
              dec = ((int.parse(message[i].codeUnits[0].toString())-97) - (int.parse(encryptionKey[i%keyLen].codeUnits[0].toString())-97) +26)%26;
              dec+=97;
              decryptedMessage+=String.fromCharCode(dec);
           }
        }
         
        return decryptedMessage;
    }
      
    return _isSender? Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(height: 5,),
        Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
            color: Colors.red[100]),
            child: Text(_decryptMessage(widget.messageModel.text!))
          ),
        SizedBox(height: 5,),
      ],
    ) : 
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5,),
        Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
            color: Colors.blue[100]),
            child: Text(_decryptMessage(widget.messageModel.text!))
            
          ),
        SizedBox(height: 5,),
      ],
    );

  }
}