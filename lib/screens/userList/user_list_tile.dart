import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/user_data_models/search_user_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_data_model.dart';
import 'package:tabzsnappro/screens/UserProfile/user_prof.dart';
import 'package:tabzsnappro/shared/colors.dart';
import 'package:tabzsnappro/shared/loading.dart';

class UserListTile extends StatefulWidget {
  
  final SearchUserDataModel searchUserDataModel;
  UserListTile(this.searchUserDataModel);

  @override
  State<UserListTile> createState() => _UserListTileState();
}

class _UserListTileState extends State<UserListTile> {
  @override
  Widget build(BuildContext context) {

    final _userDetails = Provider.of<UserDataModel?>(context);

      return _userDetails==null? Loading() :  _userDetails.uid == widget.searchUserDataModel.uid? SizedBox():
      widget.searchUserDataModel.blocked!.contains(_userDetails.uid!) || widget.searchUserDataModel.blocked_by!.contains(_userDetails.uid) ? SizedBox() :
      GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UserProf(widget.searchUserDataModel.uid!)));
        },
        child: Card(
          child: ListTile(
              leading: widget.searchUserDataModel.hasProfilePic!? CircleAvatar(
                backgroundImage: NetworkImage(widget.searchUserDataModel.profilePicUri!),
              ) : CircleAvatar(
                backgroundImage: AssetImage('assets/images/usericon.png'),
                backgroundColor:red_main
              ),
              title: Text(widget.searchUserDataModel.name!,style: TextStyle(fontSize: 16),),
          ),
        ),
      );
  }
}