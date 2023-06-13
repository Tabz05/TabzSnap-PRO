import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/post_model.dart';
import 'package:tabzsnappro/models/user_data_models/other_user_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_data_model.dart';
import 'package:tabzsnappro/services/database_service.dart';
import 'package:tabzsnappro/shared/colors.dart';
import 'package:tabzsnappro/shared/loading.dart';

class FeedPostTileFin extends StatefulWidget {
  PostModel feedPost;
  FeedPostTileFin(this.feedPost);

  @override
  State<FeedPostTileFin> createState() => _FeedPostTileFinState();
}

class _FeedPostTileFinState extends State<FeedPostTileFin> {
  @override
  Widget build(BuildContext context) {
    final _userDetails = Provider.of<UserDataModel?>(context);
    final _otherUserDetails = Provider.of<OtherUserDataModel?>(context);

    final DatabaseService _databaseService = DatabaseService();

    bool _userHasBlockedPost = false;
    bool _userBlockedBy = false;
    bool _userHasBlocked = false;

    if (_userDetails != null && _otherUserDetails != null) {
      if (widget.feedPost.blockedBy!.contains(_userDetails.uid)) {
        _userHasBlockedPost = true;
      }

      if (_otherUserDetails.blocked!.contains(_userDetails.uid)) {
        _userBlockedBy = true;
      }

      if (_otherUserDetails.blocked_by!.contains(_userDetails.uid)) {
        _userHasBlocked = true;
      }
    }

    return _userDetails == null || _otherUserDetails == null
        ? Loading()
        : _userHasBlocked || _userBlockedBy || _userHasBlockedPost
            ? SizedBox()
            : Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: red_main)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _otherUserDetails.hasProfilePic!
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                    _otherUserDetails.profilePicUri!))
                            : CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/usericon.png'),
                                backgroundColor: red_main),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          _otherUserDetails.name!,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async{

                            final Email _postReport = Email(
                              body: 'Post Id: ${widget.feedPost.postId}, User Id: ${_otherUserDetails.uid}, Reported by: ${_userDetails.uid}',
                              subject: 'Post Report',
                              recipients: ['tabzappdevep1@gmail.com'],
                              cc: ['tabishtabz18@gmail.com','tabishtabz05@gmail.com'],
                              isHTML: false,
                            );

                            await FlutterEmailSender.send(_postReport);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.yellow[700]),
                            child: Text('Report'),
                          ),
                        ),
                        Flexible(
                          child: SizedBox(),
                          fit: FlexFit.tight,
                          flex: 1,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await _databaseService.addPostBlock(
                                widget.feedPost.postId!, _userDetails.uid!);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Post blocked"),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: red_main),
                            child: Text(
                              'Block',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    !widget.feedPost.postImageUri!.isEmpty? Container(
                        width: double.infinity,
                        height: 200,
                        child: Image(
                                image:
                                    NetworkImage(widget.feedPost.postImageUri!),
                                fit: BoxFit.cover)) : SizedBox(),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.feedPost.postText!,
                          style: TextStyle(fontSize: 16),
                          maxLines: 5,
                        ))
                  ],
                ));
  }
}
