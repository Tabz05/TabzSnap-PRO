import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/user_data_models/other_user_data_model.dart';
import 'package:tabzsnappro/models/post_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_data_model.dart';
import 'package:tabzsnappro/screens/feed/feed_post_tile_fin.dart';
import 'package:tabzsnappro/services/database_service.dart';
import 'package:tabzsnappro/shared/colors.dart';

class FeedPostTile extends StatefulWidget {
  
  final PostModel feedPost;
  const FeedPostTile(this.feedPost);

  @override
  State<FeedPostTile> createState() => _FeedPostTileState();
}

class _FeedPostTileState extends State<FeedPostTile> {
  @override
  Widget build(BuildContext context) {
       
      return StreamProvider<OtherUserDataModel?>.value(
      catchError:(_,__)=>null,
      initialData: null,
      value: DatabaseService(otherUserProfileId:widget.feedPost.owner).otherUserDetails,
      child: FeedPostTileFin(widget.feedPost)
    );

  }
}