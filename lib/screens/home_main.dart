import 'package:flutter/material.dart';
import 'package:tabzsnappro/screens/UserProfile/user_profile.dart';
import 'package:tabzsnappro/screens/edit_profile.dart';
import 'package:tabzsnappro/screens/userList/find_users.dart';
import 'package:tabzsnappro/screens/feed/home_main_fin.dart';
import 'package:tabzsnappro/screens/menu.dart';
import 'package:tabzsnappro/screens/new_post.dart';
import 'package:tabzsnappro/shared/colors.dart';

class HomeMain extends StatefulWidget {
  
  final String userId;
  HomeMain(this.userId);

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {

  int _selectedIndex = 1;
  List<Widget> _tabs=[];

  @override
  void initState() {
    super.initState();

    _tabs = [
      FindUsers(),HomeMainFin(),UserProfile(widget.userId), EditProfile(),Menu(),
    ];
  }

  @override
  Widget build(BuildContext context) {
      
      return SafeArea(
          child: Scaffold(
            backgroundColor: backgroundColor,
            //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                print(widget.userId);
                Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NewPost()));
              },
              child: Icon(Icons.add,color: Colors.white),
              backgroundColor: red_main,
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,//for 4 or more items
              backgroundColor: red_main,
              selectedItemColor: Colors.white,  //for label color
              unselectedItemColor: Colors.white,
              items: <BottomNavigationBarItem>[

              BottomNavigationBarItem(
                activeIcon: Icon(Icons.person_search,color: Colors.white,),
                icon:  Icon(Icons.person_search_outlined,color: Colors.white,),
                label: 'Find Users',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.home,color: Colors.white,),
                icon: Icon(Icons.home_outlined,color: Colors.white,),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.person,color: Colors.white,),
                icon: Icon(Icons.person_outlined,color: Colors.white,),
                label: 'My Profile',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.edit,color: Colors.white,),
                icon: Icon(Icons.edit,color: Colors.white,),
                label: 'Edit Profile',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.settings,color: Colors.white),
                icon: const Icon(Icons.settings_outlined,color: Colors.white),
                label: 'Settings',
              ),

            ],
            currentIndex: _selectedIndex,
            onTap: (int index){
              setState(() {
                _selectedIndex=index;
              });
            },
            ),
            body: 
                _tabs[_selectedIndex],
              
          ),

      );

  }
}

