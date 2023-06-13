import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/user_data_models/blocked_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_id_model.dart';
import 'package:tabzsnappro/screens/userList/find_user_list.dart';
import 'package:tabzsnappro/services/database_service.dart';
import 'package:tabzsnappro/shared/colors.dart';
import 'package:tabzsnappro/shared/loading.dart';

class FindUsers extends StatefulWidget {
  const FindUsers({Key? key}) : super(key: key);

  @override
  State<FindUsers> createState() => _FindUsersState();
}

class _FindUsersState extends State<FindUsers> {

  String usernameToSearch="";

  @override
  Widget build(BuildContext context) {

      final _userDetails = Provider.of<UserDataModel?>(context);

      List<dynamic> _blocked_list=[];
      List<dynamic> _blocked_by_list=[];

      List<dynamic> _blockedList=[];

      if(_userDetails!=null)
      {
         _blocked_list = _userDetails.blocked!.toList();
         _blocked_by_list = _userDetails.blocked_by!.toList();
         
         _blockedList = _blocked_list + _blocked_by_list;
         _blockedList.add('#');

         print("blocked list: "+ _blockedList.toString());
      }
       
      return _userDetails==null? Loading() : SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: red_main),
                  color: Colors.white,
                ),
                child: TextField(
                  decoration: InputDecoration(  
                    hintText: 'Enter username...',
                    border: InputBorder.none,
                  ),
                  cursorColor: red_main,
                  onChanged: (value){
                     setState(() {
                       usernameToSearch = value;
                     });
                  },
                ),
              ),
              StreamProvider<List<UserDataModel>?>.value(
              catchError:(_,__)=>null,
              initialData: null,
              value: DatabaseService(uid:_userDetails.uid,usernameToSearch:usernameToSearch,blockedList: _blockedList).getUsers,
              child: FindUserList()
                ),
            ],
          ),
        ),
      );

  } 
}