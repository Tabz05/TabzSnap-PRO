import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/user_data_models/other_user_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_data_model.dart';
import 'package:tabzsnappro/screens/UserProfile/user_profile_followers.dart';
import 'package:tabzsnappro/services/database_service.dart';

class UserProfile extends StatefulWidget {
  
  final String userId;
  UserProfile(this.userId);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
      
    return StreamProvider<OtherUserDataModel?>.value(
      catchError:(_,__)=>null,
      initialData: null,
      value: DatabaseService(otherUserProfileId:widget.userId).otherUserDetails,
      child: UserProfileFollowers()
    );
  }
}