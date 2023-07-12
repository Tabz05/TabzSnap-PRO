import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/message_models/multi_message_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_data_model.dart';
import 'package:tabzsnappro/screens/multiChat/multi_chat_fin.dart';
import 'package:tabzsnappro/services/database_service.dart';
import 'package:tabzsnappro/shared/colors.dart';
import 'package:tabzsnappro/shared/encryption.dart';
import 'package:tabzsnappro/shared/loading.dart';

class MultiChatMain extends StatefulWidget {

  final String? multiChatId;
  final String? groudName;

  MultiChatMain(this.multiChatId,this.groudName);

  @override
  State<MultiChatMain> createState() => _MultiChatMainState();
}

class _MultiChatMainState extends State<MultiChatMain> {

  
  TextEditingController messageToSend = TextEditingController();
  
  @override
  Widget build(BuildContext context) {

    final _userDetails = Provider.of<UserDataModel?>(context);
    final DatabaseService _databaseService = DatabaseService(multiChatId: widget.multiChatId); 

    //applying vigenere cipher to encrypt text message

    String _encryptMessage(String message)
    {
        String encryptedMessage = "";

        int n  = message.length;

        int enc;

        for(int i=0;i<n;i++)
        {
           if(message[i]==sp || op.contains(message[i]) || em(message[i]))
           {
              encryptedMessage+=message[i];
           }
           else if(message[i]==message[i].toUpperCase())
           {
              enc = ((int.parse(message[i].codeUnits[0].toString())-65) + (int.parse(encryptionKey[i%keyLen].toUpperCase().codeUnits[0].toString())-65))%26;
              enc+=65;
              encryptedMessage+=String.fromCharCode(enc);
           }
           else
           {
              enc = ((int.parse(message[i].codeUnits[0].toString())-97) + (int.parse(encryptionKey[i%keyLen].codeUnits[0].toString())-97))%26;
              enc+=97;
              encryptedMessage+=String.fromCharCode(enc);
           }
        }
         
        return encryptedMessage;
    }
      
    return _userDetails==null? Loading() : StreamProvider<List<MultiMessageModel>?>.value(
      catchError:(_,__)=>null,
      initialData: null,
      value: DatabaseService(multiChatId: widget.multiChatId).getMultiMessages,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Row(
              children: [
                Text(widget.groudName!),
              ],
            ),
            backgroundColor: red_main,
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(10),
            child: Column(children: [
                MultiChatFin(),
                Row(children: [
                  Flexible(
                    flex:3,
                    fit:FlexFit.tight,
                    child: TextField(
                      controller: messageToSend,
                      decoration: InputDecoration(
                        hintText: "Enter message here..."
                      ),
                    )),
                  Flexible(
                    flex:1,
                    fit:FlexFit.tight,
                    child: GestureDetector(
                      onTap: () async{
                         if(!messageToSend.text.isEmpty)
                         {
                            String encryptedMessage = _encryptMessage(messageToSend.text.toString());
                            await _databaseService.addMultiMessage(encryptedMessage,_userDetails.uid!,_userDetails.name!,_userDetails.hasProfilePic!,_userDetails.profilePicUri!,DateTime.now().microsecondsSinceEpoch);
                            messageToSend.clear();
                         }
                      },
                      child: Icon(Icons.send,color: Colors.red,size: 32,)
                    ),
                  )
                ],)
            ],
            
            ),
            
          ),
        )
        )
    );
  }
}