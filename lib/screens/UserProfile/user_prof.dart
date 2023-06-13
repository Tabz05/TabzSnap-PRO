import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/user_data_models/user_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_id_model.dart';
import 'package:tabzsnappro/screens/UserProfile/user_profile.dart';
import 'package:tabzsnappro/services/database_service.dart';
import 'package:tabzsnappro/shared/loading.dart';

class UserProf extends StatefulWidget {

  final String userId;
  UserProf(this.userId);

  @override
  State<UserProf> createState() => _UserProfState();
}

class _UserProfState extends State<UserProf> {
  @override
  Widget build(BuildContext context) {
      
    final _user = Provider.of<UserIdModel?>(context);
      
    return _user==null? Loading() : StreamProvider<UserDataModel?>.value(
      catchError:(_,__)=>null,
      initialData: null,
      value: DatabaseService(uid:_user.uid).userDetails,
      child: UserProfile(widget.userId)
    );

  }
}