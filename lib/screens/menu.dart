import 'package:flutter/material.dart';
import 'package:tabzsnappro/screens/blocked%20list/blocked_list.dart';
import 'package:tabzsnappro/screens/blocked%20list/user_block_list.dart';
import 'package:tabzsnappro/services/auth_service.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
      
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(children: [

              Divider(thickness: 1,),
              GestureDetector(
                onTap: () {
                   Navigator.of(context).push(MaterialPageRoute(
                   builder: (context) => UserBlockList()));
                },
                child: ListTile(title: Text("Blocked"),leading: Icon(Icons.block),)),
              Divider(thickness: 1,),
              Divider(thickness: 1,),
              GestureDetector(
                onTap: () async{
                   await _auth.signOut();
                },
                child: ListTile(title: Text("LogOut"),leading: Icon(Icons.logout),)),
              Divider(thickness: 1,),
            ]),
          ),
        ),
      );

  }
}