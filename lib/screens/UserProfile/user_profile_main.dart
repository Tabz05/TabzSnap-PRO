import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/user_data_models/follower_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/following_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/other_user_data_model.dart';
import 'package:tabzsnappro/models/post_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_id_model.dart';
import 'package:tabzsnappro/screens/UserProfile/follower_list_tile.dart';
import 'package:tabzsnappro/screens/UserProfile/following_list_tile.dart';
import 'package:tabzsnappro/screens/UserProfile/post_list_tile.dart';
import 'package:tabzsnappro/screens/singleChat/single_chat.dart';
import 'package:tabzsnappro/services/database_service.dart';
import 'package:tabzsnappro/shared/colors.dart';
import 'package:tabzsnappro/shared/loading.dart';

class UserProfileMain extends StatefulWidget {
  const UserProfileMain({Key? key}) : super(key: key);

  @override
  State<UserProfileMain> createState() => _UserProfileMainState();
}

class _UserProfileMainState extends State<UserProfileMain> {

  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {

    final _user = Provider.of<UserIdModel?>(context);
    final _userDetails = Provider.of<UserDataModel?>(context);

    final _otherUserDetails = Provider.of<OtherUserDataModel?>(context);

    final _followersList = Provider.of<List<FollowerDataModel>?>(context);
    final _followingsList = Provider.of<List<FollowingDataModel>?>(context);

    final _postsList = Provider.of<List<PostModel>?>(context);

    bool _userHasBlocked = false;
    bool _userIsBlocked = false;

    if(_user != null && _userDetails!=null && _otherUserDetails != null && _followersList != null &&
        _followingsList != null && _postsList != null)
    {
          if(_otherUserDetails.blocked_by!.contains(_userDetails.uid))
          {
             _userHasBlocked = true;
          }

          if(_otherUserDetails.blocked!.contains(_userDetails.uid))
          {
             _userIsBlocked = true;
          }
    }

    return _user == null || _userDetails==null ||
            _otherUserDetails == null ||
            _followersList == null ||
            _followingsList == null ||
            _postsList == null
        ? Loading()
        : 
        _userIsBlocked || _userHasBlocked? SafeArea(
          child: Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(  
              backgroundColor: red_main,
              
            ),
            body: Container(
               width: double.infinity,
               height: double.infinity,
               margin: EdgeInsets.all(20),
               alignment: Alignment.center,
               child: Column(  
                children: [
                   Icon(Icons.block,color: red_main,size:36),
                   Text('Blocked',style: TextStyle(color: red_main),)
                ],
               ),
            ),
          )) :
        SafeArea(
            child: Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
                backgroundColor: red_main,
                title: Row(
                  children: [
                    _otherUserDetails.hasProfilePic!? CircleAvatar(backgroundImage: NetworkImage(_otherUserDetails.profilePicUri!)) : CircleAvatar(backgroundImage:AssetImage('assets/images/usericon.png')),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: SizedBox(),
                    ),
                    Text(_otherUserDetails.name!),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: SizedBox(),
                    ),
                    _user.uid != _otherUserDetails.uid
                        ? Row(
                            children: [
                              GestureDetector(
                                child: Icon(
                                  Icons.message_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SingleChat(
                                          _otherUserDetails.uid!,
                                          _otherUserDetails.name!)));
                                },
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              GestureDetector(
                                child: //Icon(Icons.block,color: Colors.white,size: 24,),
                                    Icon(Icons.block),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Block '+_otherUserDetails.name!+"?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
                                                },
                                                child: Text('No')),
                                            TextButton(
                                                onPressed: () async {

                                                  await _databaseService.addBlock(
                                                      _user.uid!,
                                                      _otherUserDetails.uid!);
                                                  
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
                                                },
                                                child: Text('Yes')),
                                          ],
                                        );
                                      });
                                },
                              ),
                            ],
                          )
                        : Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: SizedBox(),
                          ),
                  ],
                ),
              
            ),
            body: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  !_otherUserDetails.hasProfilePic!
                      ? CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              AssetImage('assets/images/usericon.png'),
                          backgroundColor: red_main)
                      : CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              NetworkImage(_otherUserDetails.profilePicUri!)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    _otherUserDetails.name!,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(_otherUserDetails.email!),
                  SizedBox(
                    height: 20,
                  ),
                  _otherUserDetails.uid == _user.uid
                      ? SizedBox()
                      : _otherUserDetails.followers!.contains(_user.uid)
                          ? GestureDetector(
                              onTap: () async {
                                await _databaseService.unfollow(
                                    _user.uid!, _otherUserDetails.uid!);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Unfollow',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.red),
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                await _databaseService.follow(
                                    _user.uid!, _otherUserDetails.uid!);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Follow',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.green),
                              ),
                            ),
                  _userDetails.uid == _otherUserDetails.uid? SizedBox():
                  GestureDetector(
                    onTap: () async{
                       
                       final Email _userReport = Email(
                              body: 'User Id: ${_otherUserDetails.uid}, Reported by: ${_userDetails.uid}',
                              subject: 'User Report',
                              recipients: ['tabzappdevep1@gmail.com'],
                              cc: ['tabishtabz18@gmail.com','tabishtabz05@gmail.com'],
                              isHTML: false,
                            );

                            await FlutterEmailSender.send(_userReport);
                    },
                    child: Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(  
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text('Report',style: TextStyle(color: Colors.white,fontSize: 16),),
                     ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Flexible(
                            child: SizedBox(), flex: 1, fit: FlexFit.tight),
                        Text(
                          'Followers',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue[600],
                              fontWeight: FontWeight.bold),
                        ),
                        Flexible(
                            child: SizedBox(), flex: 1, fit: FlexFit.tight),
                        Text(
                          'Posts',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue[600],
                              fontWeight: FontWeight.bold),
                        ),
                        Flexible(
                            child: SizedBox(), flex: 1, fit: FlexFit.tight),
                        Text(
                          'Followings',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue[600],
                              fontWeight: FontWeight.bold),
                        ),
                        Flexible(
                            child: SizedBox(), flex: 1, fit: FlexFit.tight),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Flexible(
                            child: SizedBox(), flex: 1, fit: FlexFit.tight),
                        Text(
                          _followersList.length.toString(),
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue[600],
                              fontWeight: FontWeight.bold),
                        ),
                        Flexible(
                            child: SizedBox(), flex: 2, fit: FlexFit.tight),
                        Text(
                          _postsList.length.toString(),
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue[600],
                              fontWeight: FontWeight.bold),
                        ),
                        Flexible(
                            child: SizedBox(), flex: 2, fit: FlexFit.tight),
                        Text(
                          _followingsList.length.toString(),
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue[600],
                              fontWeight: FontWeight.bold),
                        ),
                        Flexible(
                            child: SizedBox(), flex: 1, fit: FlexFit.tight),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    child: Text(
                      'Followers',
                      style: TextStyle(fontSize: 18),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _followersList.isEmpty
                      ? Text(
                          "No Followers",
                          style: TextStyle(fontSize: 16),
                        )
                      : SizedBox(
                          height:
                              180, //height is required for horizontal scrolling
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _followersList.length,
                            itemBuilder: (context, index) {
                              return FollowerListTile(_followersList[index]);
                            },
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    child: Text(
                      'Followings',
                      style: TextStyle(fontSize: 18),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _followingsList.isEmpty
                      ? Text(
                          "No Followings",
                          style: TextStyle(fontSize: 16),
                        )
                      : SizedBox(
                          height:
                              180, //height is required for horizontal scrolling
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _followingsList.length,
                            itemBuilder: (context, index) {
                              return FollowingListTile(_followingsList[index]);
                            },
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    child: Text(
                      'Posts',
                      style: TextStyle(fontSize: 18),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _postsList.isEmpty
                      ? Column(
                          children: [
                            Text(
                              "No Posts",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 100 * (((_postsList.length) / 3) + 1),
                              child: GridView.builder(
                                itemCount: _postsList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                itemBuilder: (context, index) {
                                  return Container(
                                      width: double.infinity,
                                      height: 100,
                                      child: PostListTile(_postsList[index]));
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                ]),
              ),
            ),
          ));
  }
}
