import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/post_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_data_model.dart';
import 'package:tabzsnappro/screens/feed/home_feed.dart';
import 'package:tabzsnappro/services/database_service.dart';
import 'package:tabzsnappro/shared/loading.dart';

class HomeMainFin extends StatefulWidget {
  const HomeMainFin({Key? key}) : super(key: key);

  @override
  State<HomeMainFin> createState() => _HomeMainFinState();
}

class _HomeMainFinState extends State<HomeMainFin> {
  @override
  Widget build(BuildContext context) {
      
      final _userDetails = Provider.of<UserDataModel?>(context);

      List<String>? _followingsList = [];

      if(_userDetails!=null)
      {
        _followingsList = _userDetails.followings!.toList();
        _followingsList.add(_userDetails.uid.toString());
      }

      return _userDetails==null? Loading() : StreamProvider<List<PostModel>?>.value(
      catchError:(_,__)=>null,
      initialData: null,
      value: DatabaseService(uid: _userDetails.uid,followingsList:_followingsList).myFeed,
      child: HomeFeed()
    );
  }
}