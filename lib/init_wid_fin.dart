import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/user_data_models/user_id_model.dart';
import 'package:tabzsnappro/screens/authentication/authenticate.dart';
import 'package:tabzsnappro/screens/home.dart';

class InitializerWidgetFin extends StatefulWidget {
  const InitializerWidgetFin({super.key});

  @override
  State<InitializerWidgetFin> createState() => _InitializerWidgetFinState();
}

class _InitializerWidgetFinState extends State<InitializerWidgetFin> {
  @override
  Widget build(BuildContext context) {

    final _user = Provider.of<UserIdModel?>(context);
    
    return _user==null? Authenticate() : Home();
  }
}