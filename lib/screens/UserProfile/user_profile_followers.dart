import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/user_data_models/other_user_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/follower_data_model.dart';
import 'package:tabzsnappro/screens/UserProfile/user_profile_followings.dart';
import 'package:tabzsnappro/services/database_service.dart';
import 'package:tabzsnappro/shared/loading.dart';

class UserProfileFollowers extends StatefulWidget {
  
  UserProfileFollowers();

  @override
  State<UserProfileFollowers> createState() => _UserProfileFollowersState();
}

class _UserProfileFollowersState extends State<UserProfileFollowers> {

  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {

    final _otherUserDetails = Provider.of<OtherUserDataModel?>(context);

    List<dynamic> _followersList = [];

    if(_otherUserDetails!=null)
    {
       _followersList = _otherUserDetails.followers!.toList();
       _followersList.add('#'); //need this because wherein clause cant work on empty lists
    }
    
    return _otherUserDetails==null? Loading() : StreamProvider<List<FollowerDataModel>?>.value(
      catchError:(_,__)=>null,
      initialData: null,
      value: DatabaseService(followersList:_followersList).otherUserFollowers,
      child: UserProfileFollowings()
    );
      
  }
}
