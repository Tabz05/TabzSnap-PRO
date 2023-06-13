import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/user_data_models/blocked_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_id_model.dart';
import 'package:tabzsnappro/services/database_service.dart';
import 'package:tabzsnappro/shared/colors.dart';

class BlockedListTile extends StatefulWidget {
  
  BlockedDataModel blockedDataModel;
  BlockedListTile(this.blockedDataModel);

  @override
  State<BlockedListTile> createState() => _BlockedListTileState();
}

class _BlockedListTileState extends State<BlockedListTile> {

  final DatabaseService _databaseService = DatabaseService();
  
  @override
  Widget build(BuildContext context) {

    final _user = Provider.of<UserIdModel?>(context);
    
    return _user==null? Text('Loading'): Card(
          child: ListTile(
              leading: widget.blockedDataModel.hasProfilePic!? CircleAvatar(
                backgroundImage: NetworkImage(widget.blockedDataModel.profilePicUri!),
              ) : CircleAvatar(
                backgroundImage: AssetImage('assets/images/usericon.png'),
                backgroundColor:red_main
              ),
              title: Row(
                children: [
                  Text(widget.blockedDataModel.name!,style: TextStyle(fontSize: 16),),
                  Flexible(child: SizedBox(),flex:1,fit:FlexFit.tight),
                  GestureDetector(
                    onTap: () async{
                      await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Unblock '+widget.blockedDataModel.name!+"?"),
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
                                                await _databaseService.unBlock(
                                                    _user.uid!,
                                                    widget.blockedDataModel.uid!);
                                                    
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop();
      
                                              },
                                              child: Text('Yes')),
                                        ],
                                      );
                                    });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text('Unblock',style: TextStyle(color: Colors.white),),
                      decoration: BoxDecoration(  
                        borderRadius: BorderRadius.circular(10),
                        color: red_main
                      )
                  
                    ,),
                  )
                ],
              ),
          ),
        );
  }
}