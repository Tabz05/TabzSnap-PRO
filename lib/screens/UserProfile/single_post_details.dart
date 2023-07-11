import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/post_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_id_model.dart';
import 'package:tabzsnappro/services/database_service.dart';
import 'package:tabzsnappro/shared/colors.dart';
import 'package:tabzsnappro/shared/loading.dart';

class SinglePostDetails extends StatefulWidget {
  final PostModel postModel;
  SinglePostDetails(this.postModel);

  @override
  State<SinglePostDetails> createState() => _SinglePostDetailsState();
}

class _SinglePostDetailsState extends State<SinglePostDetails> {

  final DatabaseService _databaseService = DatabaseService();

  bool _deleted = false;

  @override
  Widget build(BuildContext context) {

    final _user = Provider.of<UserIdModel?>(context);

    return _user == null
        ? Loading()
        : _deleted? SafeArea(
          child: Scaffold(
          backgroundColor: backgroundColor,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Post Deleted'),
              ],
            )))) : SafeArea(
            child: Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                backgroundColor: red_main,
              ),
              body: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: SingleChildScrollView(
                    child: Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: red_main),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                            width: double.infinity,
                            height: 400,
                            child: !widget.postModel.postImageUri!.isEmpty
                                ? Image(
                                    image: NetworkImage(
                                        widget.postModel.postImageUri!),
                                    fit: BoxFit.cover,
                                  )
                                : Image(
                                    image: AssetImage(
                                        'assets/images/imageicon.png'),
                                    fit: BoxFit.cover,
                                  )),
                        widget.postModel.postText!.length>0 ? SizedBox(
                          height: 20,
                        ) : SizedBox(),
                        widget.postModel.postText!.length>0 ? Container(
                          width: double.infinity,
                          child: Text(
                            widget.postModel.postText!,
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ): SizedBox(),
                        SizedBox(
                          height: 20,
                        ),
                        widget.postModel.owner==_user.uid ? IconButton(
                            onPressed: ()async{
                              await _databaseService.deletePost(widget.postModel.postId!);

                              setState(() {
                                _deleted = true;
                              });
                            },
                            icon: Icon(Icons.delete,color: red_main,size: 32)) : SizedBox()
                      ],
                    ),
                  ),
                ])),
              ),
            ),
          );
  }
}
