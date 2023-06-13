import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/user_data_models/following_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_data_model.dart';
import 'package:tabzsnappro/screens/UserProfile/user_prof.dart';
import 'package:tabzsnappro/shared/colors.dart';

class FollowingListTile extends StatefulWidget {

  final FollowingDataModel followingDataModel;
  FollowingListTile(this.followingDataModel);

  @override
  State<FollowingListTile> createState() => _FollowingListTileState();
}

class _FollowingListTileState extends State<FollowingListTile> {
  @override
  Widget build(BuildContext context) {
    
    final _userDetails = Provider.of<UserDataModel?>(context);

    bool _blocked = false;

    if(_userDetails!=null)
    {
       if(_userDetails.blocked!.contains(widget.followingDataModel.uid) ||
          _userDetails.blocked_by!.contains(widget.followingDataModel.uid))
        {
           _blocked = true;
        }
    }

    return _userDetails==null? SizedBox(): _blocked? Container(
      child: Icon(Icons.block,color: red_main,size:100),
    ) : GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => UserProf(widget.followingDataModel.uid!)));
      },
      child: widget.followingDataModel.hasProfilePic!
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Column(
                children: [
                  CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          NetworkImage(widget.followingDataModel.profilePicUri!)),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.followingDataModel.name!,
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
                    widget.followingDataModel.name!,
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
    );
  }
}
