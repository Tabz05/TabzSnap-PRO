import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/user_data_models/following_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/other_user_data_model.dart';
import 'package:tabzsnappro/screens/UserProfile/user_profile_posts.dart';
import 'package:tabzsnappro/services/database_service.dart';

class UserProfileFollowings extends StatefulWidget {
  
  UserProfileFollowings();

  @override
  State<UserProfileFollowings> createState() => _UserProfileFollowingsState();
}

class _UserProfileFollowingsState extends State<UserProfileFollowings> {

  @override
  Widget build(BuildContext context) {

    final _otherUserDetails = Provider.of<OtherUserDataModel?>(context);

    List<dynamic> _followingsList = [];

    if(_otherUserDetails!=null)
    {
       _followingsList = _otherUserDetails.followings!.toList();
       _followingsList.add('#');
    }
    
    return StreamProvider<List<FollowingDataModel>?>.value(
      catchError:(_,__)=>null,
      initialData: null,
      value: DatabaseService(followingsList:_followingsList).otherUserFollowings,
      child: UserProfilePosts()
    );
      
  }
}
