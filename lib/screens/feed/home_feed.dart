import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/post_model.dart';
import 'package:tabzsnappro/screens/feed/feed_post_tile.dart';
import 'package:tabzsnappro/screens/myMultiChats/my_multi_chats_prof.dart';
import 'package:tabzsnappro/screens/mySingleChats/my_chats_prof.dart';
import 'package:tabzsnappro/shared/colors.dart';
import 'package:tabzsnappro/shared/loading.dart';

class HomeFeed extends StatefulWidget {
  const HomeFeed({super.key});

  @override
  State<HomeFeed> createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  @override
  Widget build(BuildContext context) {
     
     final _postsList = Provider.of<List<PostModel>?>(context);

      return _postsList==null? Loading() : Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Align(
                  child: GestureDetector(
                    onTap: (){
                       Navigator.of(context).push(MaterialPageRoute(
                       builder: (context) => MyMultiChatsProf()));
                    },
                    child: Icon(Icons.group,size: 28,color: red_main,)),
                  alignment: Alignment.topRight,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Align(
                  child: GestureDetector(
                    onTap: (){
                       Navigator.of(context).push(MaterialPageRoute(
                       builder: (context) => MyChatsProf()));
                    },
                    child: Icon(Icons.message,size: 28,color: red_main,)),
                  alignment: Alignment.topRight,
                ),
              ),
            ],
          ),
          Text('Welcome',style: TextStyle(color: red_main,fontSize: 20),),
          Expanded(
            child: ListView.builder(
              itemCount: _postsList.length,
              itemBuilder: (context,index){
                return FeedPostTile(_postsList[index]);
              },
               ),
          ),
        ],
      );

  }
}