import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/chat_models/chat_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_id_model.dart';
import 'package:tabzsnappro/screens/mySingleChats/chat_other_details.dart';
import 'package:tabzsnappro/services/database_service.dart';
import 'package:tabzsnappro/shared/colors.dart';
import 'package:tabzsnappro/shared/loading.dart';
import 'package:tabzsnappro/shared/multi_chat.dart';

class MyChatsFin extends StatefulWidget {
  const MyChatsFin({Key? key}) : super(key: key);

  @override
  State<MyChatsFin> createState() => _MyChatsFinState();
}

class _MyChatsFinState extends State<MyChatsFin> {
  final DatabaseService _databaseService = DatabaseService();

  String _groupName = "";

  @override
  Widget build(BuildContext context) {
    final _chats = Provider.of<List<ChatModel>?>(context) ?? [];
    final _user = Provider.of<UserIdModel?>(context);

    return _chats == null || _user == null
        ? Loading()
        : SafeArea(
            child: Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                title: Text("Your Chats",style:TextStyle(color:Colors.white)),
                centerTitle: true,
                backgroundColor: red_main,
                actions: [
                  IconButton(
                    icon: groupChat ? Icon(Icons.cancel) : Icon(Icons.group),
                    onPressed: () {
                      setState(() {
                        groupChat = !groupChat;
                      });
                    },
                  ),
                ],
              ),
              body: Column(
                children: [
                  groupChat
                      ? SizedBox(
                          height: 20,
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  groupChat
                      ? GestureDetector(
                          onTap: () {
                            usersToAdd.length > 0
                                ? showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Enter Group Name'),
                                        content: TextField(
                                            decoration: InputDecoration(
                                                hintText: 'My Group...'),
                                            onChanged: ((value) {
                                              _groupName = value;
                                            })),
                                        actions: [
                                          TextButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('Create'),
                                            onPressed: () async {
                                              if (_groupName.length > 0) {
                                                usersToAdd.add(_user.uid!);

                                                DateTime now = DateTime.now();
                                                String timestamp =
                                                    now.toString();

                                                String chatId = _user.uid! +
                                                    _groupName +
                                                    timestamp;

                                                await _databaseService
                                                    .addMultiChat(chatId, _groupName,usersToAdd);

                                                Navigator.of(context).pop();
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content:
                                                      Text("Enter group name"),
                                                ));
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                : ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                    content: Text("Select at least one user"),
                                  ));
                          },
                          child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                'Create Group',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )),
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  groupChat
                      ? SizedBox(
                          height: 20,
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _chats.length,
                      itemBuilder: (context, index) {
                        return ChatOtherDetails(_chats[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
