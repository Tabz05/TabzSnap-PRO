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
  @override
  Widget build(BuildContext context) {

    final _user = Provider.of<UserIdModel?>(context);
    final DatabaseService _databaseService = DatabaseService(uid: _user!.uid);
      
    return _user==null ? Loading() : SafeArea(
        child: Scaffold(   
           backgroundColor: backgroundColor,
           appBar: AppBar(  
            backgroundColor: red_main,
           ),
           body: Container(   
             width: double.infinity,
             margin: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
             child: SingleChildScrollView(  
              child: Column(children: [
                 SizedBox(height: 20,),
                 Column(
                   children: [
                     Container(
                      width: double.infinity,
                      height: 400,
                      child: !widget.postModel.postImageUri!.isEmpty ? 
                             Image(image: NetworkImage(widget.postModel.postImageUri!),fit: BoxFit.cover,) :
                             Image(image: AssetImage('assets/images/imageicon.png'),fit: BoxFit.cover,)
                      ),
                      SizedBox(height: 20,),
                      Container(  
                        width: double.infinity,
                        child: Text(widget.postModel.postText!,style: TextStyle(color: Colors.black,fontSize: 18),),
                      ),
                      
                   ],
                 ),
                 SizedBox(height: 20,),
              ])),
              ),
        ),
      );

  }
}