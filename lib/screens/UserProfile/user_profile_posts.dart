import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/user_data_models/follower_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/other_user_data_model.dart';
import 'package:tabzsnappro/models/post_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_data_model.dart';
import 'package:tabzsnappro/screens/UserProfile/user_profile_main.dart';
import 'package:tabzsnappro/services/database_service.dart';
import 'package:tabzsnappro/shared/loading.dart';

class UserProfilePosts extends StatefulWidget {
  const UserProfilePosts({Key? key}) : super(key: key);

  @override
  State<UserProfilePosts> createState() => _UserProfilePostsState();
}

class _UserProfilePostsState extends State<UserProfilePosts> {
  @override
  Widget build(BuildContext context) {
      
    final _otherUserDetails = Provider.of<OtherUserDataModel?>(context);
    
    return _otherUserDetails==null? Loading() : StreamProvider<List<PostModel>?>.value(
      catchError:(_,__)=>null,
      initialData: null,
      value: DatabaseService(otherUserProfileId:_otherUserDetails.uid).otherUserPosts,
      child: UserProfileMain()
    );
      

  }
}