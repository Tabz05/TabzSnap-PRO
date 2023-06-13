import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/user_data_models/user_data_model.dart';
import 'package:tabzsnappro/screens/UserProfile/user_prof.dart';
import 'package:tabzsnappro/shared/colors.dart';
import 'package:tabzsnappro/shared/loading.dart';

class UserListTile extends StatefulWidget {
  
  final UserDataModel userDataModel;
  UserListTile(this.userDataModel);

  @override
  State<UserListTile> createState() => _UserListTileState();
}

class _UserListTileState extends State<UserListTile> {
  @override
  Widget build(BuildContext context) {

    final _userDetails = Provider.of<UserDataModel?>(context);

      return _userDetails==null? Loading() : _userDetails.uid == widget.userDataModel.uid? SizedBox():
      GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UserProf(widget.userDataModel.uid!)));
        },
        child: Card(
          child: ListTile(
              leading: widget.userDataModel.hasProfilePic!? CircleAvatar(
                backgroundImage: NetworkImage(widget.userDataModel.profilePicUri!),
              ) : CircleAvatar(
                backgroundImage: AssetImage('assets/images/usericon.png'),
                backgroundColor:red_main
              ),
              title: Text(widget.userDataModel.name!,style: TextStyle(fontSize: 16),),
          ),
        ),
      );
  }
}