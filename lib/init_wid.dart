import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabzsnappro/init_wid_fin.dart';
import 'package:tabzsnappro/models/user_data_models/user_id_model.dart';
import 'package:tabzsnappro/screens/agree.dart';
import 'package:tabzsnappro/screens/authentication/authenticate.dart';
import 'package:tabzsnappro/screens/home.dart';
import 'package:tabzsnappro/services/auth_service.dart';

class InitializerWidget extends StatefulWidget {
  const InitializerWidget({Key? key}) : super(key: key);

  @override
  State<InitializerWidget> createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {

  @override
  Widget build(BuildContext context) {
     
    return StreamProvider<UserIdModel?>.value(
      catchError:(_,__)=>null,
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
         debugShowCheckedModeBanner: false,
         home: InitializerWidgetFin(),
      ),
    );
      
  }
}