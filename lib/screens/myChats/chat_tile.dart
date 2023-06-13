import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/user_data_models/other_user_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_id_model.dart';
import 'package:tabzsnappro/screens/singleChat/single_chat.dart';
import 'package:tabzsnappro/shared/loading.dart';

class ChatTile extends StatefulWidget {
  const ChatTile({super.key});

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    
    final _userDetials = Provider.of<UserDataModel?>(context);
    final _otherUserDetails = Provider.of<OtherUserDataModel?>(context);

    bool _blocked=false;

    if(_userDetials!=null && _otherUserDetails!=null)
    {
        if(_userDetials.blocked!.contains(_otherUserDetails.uid) ||
           _userDetials.blocked_by!.contains(_otherUserDetails.uid))
           {
             _blocked = true;
           }
    }

    return _userDetials==null || _otherUserDetails==null ? SizedBox() : 
           _blocked? SizedBox() : 
           GestureDetector(
            onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SingleChat(_otherUserDetails.uid!,_otherUserDetails.name!)));
            },
             child: ListTile(  
                  leading: _otherUserDetails.hasProfilePic!? 
                           CircleAvatar( 
                            backgroundImage: NetworkImage(_otherUserDetails.profilePicUri!),
                           ) :
                           CircleAvatar(
                            backgroundImage: AssetImage('assets/images/usericon.png'),
                           ),
                  title: Text(_otherUserDetails.name!),
             ),
           );

  }
}