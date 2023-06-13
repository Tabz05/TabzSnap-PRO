import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/user_data_models/user_data_model.dart';
import 'package:tabzsnappro/screens/userList/user_list_tile.dart';
import 'package:tabzsnappro/shared/loading.dart';

class FindUserList extends StatefulWidget {
  const FindUserList({Key? key}) : super(key: key);

  @override
  State<FindUserList> createState() => _FindUserListState();
}

class _FindUserListState extends State<FindUserList> {
  @override
  Widget build(BuildContext context) {

    final _userList = Provider.of<List<UserDataModel>?>(context) ?? [];
     
    return Expanded(
      child: ListView.builder(
              itemCount: _userList.length,
              itemBuilder: (context,index){
                return UserListTile(_userList[index]);
              },
           ),
    );

  }
}