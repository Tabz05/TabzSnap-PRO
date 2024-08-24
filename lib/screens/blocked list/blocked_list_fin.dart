import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/user_data_models/blocked_data_model.dart';
import 'package:tabzsnappro/screens/blocked%20list/block_list_tile.dart';
import 'package:tabzsnappro/shared/colors.dart';

class BlockedListFin extends StatefulWidget {
  const BlockedListFin({super.key});

  @override
  State<BlockedListFin> createState() => _BlockedListFinState();
}

class _BlockedListFinState extends State<BlockedListFin> {
  @override
  Widget build(BuildContext context) {
    
    final _blockedList = Provider.of<List<BlockedDataModel>?>(context) ?? [];
     
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(  
          backgroundColor: red_main,
          title: Text('Block list',style: TextStyle(color:Colors.white),),
          centerTitle: true,
        ),
        body: _blockedList.isEmpty? 
      Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Text('No Blocked users',style: TextStyle(color: red_main,fontSize: 18),)) :
         ListView.builder(
                itemCount: _blockedList.length,
                itemBuilder: (context,index){
                  return BlockedListTile(_blockedList[index]);
                },
        
      ),
      ) 
    );
      
  }
}