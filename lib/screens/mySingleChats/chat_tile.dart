import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/user_data_models/other_user_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_data_model.dart';
import 'package:tabzsnappro/screens/singleChat/single_chat.dart';
import 'package:tabzsnappro/shared/colors.dart';
import 'package:tabzsnappro/shared/loading.dart';
import 'package:tabzsnappro/shared/multi_chat.dart';

class ChatTile extends StatefulWidget {

  ChatTile();

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {

  bool _selected = false;

  void _removeUser(String userId)
  {
     setState(() {
       usersToAdd.remove(userId);
       _selected = !_selected;
     });
  }

  void _addUser(String userId)
  {
     setState(() {
       usersToAdd.add(userId);
       _selected = !_selected;
     });
  }

  @override
  Widget build(BuildContext context) {

    print("users to add "+usersToAdd.toString());

    final _userDetials = Provider.of<UserDataModel?>(context);
    final _otherUserDetails = Provider.of<OtherUserDataModel?>(context);

    bool _blocked = false;

    print('selected: ' + _selected.toString());

    if (_userDetials != null && _otherUserDetails != null) {
      if (_userDetials.blocked!.contains(_otherUserDetails.uid) ||
          _userDetials.blocked_by!.contains(_otherUserDetails.uid)) {
        _blocked = true;
      }
    }

    return _userDetials == null || _otherUserDetails == null
        ? Loading()
        : _blocked
            ? SizedBox()
            : GestureDetector(
                onTap: () {
                  groupChat? 
                    _selected ? _removeUser(_otherUserDetails.uid!) : _addUser(_otherUserDetails.uid!)
                   
                   : Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SingleChat(
                          _otherUserDetails.uid!, _otherUserDetails.name!)));
                },
                child: ListTile(
                  leading: groupChat? Container(
                    width: 90,
                    child: Row(
                      children: [
                         Checkbox(
                          value: _selected,
                          onChanged: (value) {
                          },
                        ),
                        _otherUserDetails.hasProfilePic!
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                    _otherUserDetails.profilePicUri!),
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/usericon.png'),
                              ),
                      ],
                    ),
                  ) : 
                  _otherUserDetails.hasProfilePic!
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                    _otherUserDetails.profilePicUri!),
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/usericon.png'),
                                backgroundColor: red_main,    
                              ),
                  title: Text(_otherUserDetails.name!),
                ),
              );
  }
}
