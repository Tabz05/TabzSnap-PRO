import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabzsnappro/firebase_options.dart';
import 'package:tabzsnappro/init_wid.dart';
import 'package:tabzsnappro/models/user_data_models/user_id_model.dart';
import 'package:tabzsnappro/screens/agree.dart';
import 'package:tabzsnappro/services/auth_service.dart';

void main() async{

WidgetsFlutterBinding.ensureInitialized();
  
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  Future _userAccepted() async {
    
    SharedPreferences sp = await SharedPreferences.getInstance();

    String accept = sp.getString('accept') ?? 'not';

    return accept;
  }
  
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      future: _userAccepted(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return SizedBox();
          } else if (snapshot.hasData) {
            if (snapshot.data == 'not') {

              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Agreement(),
              );
            } else {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home:InitializerWidget(),
              );

            }
          } else {
            return SizedBox();
          }
        } else {
          return SizedBox();
        }
      },
    );
    
  }
}