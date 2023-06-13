import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/user_data_models/blocked_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_data_model.dart';
import 'package:tabzsnappro/screens/blocked%20list/blocked_list_fin.dart';
import 'package:tabzsnappro/services/database_service.dart';
import 'package:tabzsnappro/shared/loading.dart';

class BlockedList extends StatefulWidget {
  const BlockedList({super.key});

  @override
  State<BlockedList> createState() => _BlockedListState();
}

class _BlockedListState extends State<BlockedList> {
  @override
  Widget build(BuildContext context) {
       
    final _userDetails = Provider.of<UserDataModel?>(context);

    List<dynamic> _blockedList = [];

    if(_userDetails!=null)
    {
      _blockedList = _userDetails.blocked!.toList();
      _blockedList.add('#');
    }

    return _userDetails==null? Loading() : StreamProvider<List<BlockedDataModel>?>.value(
                catchError:(_,__)=>null,
                initialData: null,
                value: DatabaseService(uid:_userDetails.uid,blockedList: _blockedList).myBlocked,
                child: BlockedListFin()
                  );
    
  }
}