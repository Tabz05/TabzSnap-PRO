import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/user_data_models/follower_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_data_model.dart';
import 'package:tabzsnappro/screens/UserProfile/user_prof.dart';
import 'package:tabzsnappro/shared/colors.dart';

class FollowerListTile extends StatefulWidget {

  final FollowerDataModel followerDataModel;
  FollowerListTile(this.followerDataModel);

  @override
  State<FollowerListTile> createState() => _FollowerListTileState();
}

class _FollowerListTileState extends State<FollowerListTile> {
  @override
  Widget build(BuildContext context) {

    final _userDetails = Provider.of<UserDataModel?>(context);

    bool _blocked = false;

    if(_userDetails!=null)
    {
       if(_userDetails.blocked!.contains(widget.followerDataModel.uid) ||
          _userDetails.blocked_by!.contains(widget.followerDataModel.uid))
        {
           _blocked = true;
        }
    }
   
    return _userDetails==null? SizedBox(): _blocked? Container(
      child: Icon(Icons.block,color: red_main,size:100),
    ) : GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => UserProf(widget.followerDataModel.uid!)));
      },
      child: widget.followerDataModel.hasProfilePic!
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Column(
                children: [
                  CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          NetworkImage(widget.followerDataModel.profilePicUri!)),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.followerDataModel.name!,
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            )
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Column(
                children: [
                  CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/usericon.png'),
                      backgroundColor: red_main),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.followerDataModel.name!,
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
    );
  }
}
