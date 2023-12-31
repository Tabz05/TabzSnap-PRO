import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/message_models/messages_model.dart';
import 'package:tabzsnappro/models/user_data_models/other_user_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_id_model.dart';
import 'package:tabzsnappro/screens/singleChat/single_chat_fin.dart';
import 'package:tabzsnappro/services/database_service.dart';
import 'package:tabzsnappro/shared/colors.dart';
import 'package:tabzsnappro/shared/encryption.dart';
import 'package:tabzsnappro/shared/loading.dart';

class SingleChatMain extends StatefulWidget {
  
  final String chatId;
  SingleChatMain(this.chatId);

  @override
  State<SingleChatMain> createState() => _SingleChatMainState();
}

class _SingleChatMainState extends State<SingleChatMain> {

  TextEditingController messageToSend = TextEditingController();

  @override
  Widget build(BuildContext context) {
 
    final _user = Provider.of<UserIdModel?>(context);
    final _otherUserDetails = Provider.of<OtherUserDataModel?>(context);
    
    final DatabaseService _databaseService = DatabaseService(uid:_user!.uid,chatId: widget.chatId);

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
      
    return _otherUserDetails==null? Loading() : StreamProvider<List<MessageModel>?>.value(
      catchError:(_,__)=>null,
      initialData: null,
      value: DatabaseService(chatId: widget.chatId).getMessages,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Row(
              children: [
                _otherUserDetails.hasProfilePic!? CircleAvatar(backgroundImage: NetworkImage(_otherUserDetails.profilePicUri!),) : CircleAvatar(backgroundImage: AssetImage('assets/images/usericon.png'),),
                SizedBox(width: 10),
                Text(_otherUserDetails.name!),
              ],
            ),
            backgroundColor: red_main,
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(10),
            child: Column(children: [
                SingleChatFin(),
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
                            print("hiiiii sending");
                            String encryptedMessage = _encryptMessage(messageToSend.text.toString());
                            await _databaseService.addMessage(encryptedMessage,DateTime.now().microsecondsSinceEpoch);
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