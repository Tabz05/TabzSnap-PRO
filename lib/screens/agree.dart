import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabzsnappro/init_wid.dart';
import 'package:tabzsnappro/models/user_data_models/user_id_model.dart';
import 'package:tabzsnappro/screens/authentication/authenticate.dart';

class Agreement extends StatefulWidget {
  const Agreement({super.key});

  @override
  State<Agreement> createState() => _AgreementState();
}

class _AgreementState extends State<Agreement> {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserIdModel?>(context);

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black)),
          child: Column(children: [
            Text(
              'User Policy',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Text('* Users must not post offensive texts and/or images'),
            SizedBox(
              height: 20,
            ),
            Text('* Texts must not contain use of abusive language'),
            SizedBox(
              height: 20,
            ),
            Text('* Posts must not encourage animosity towards other people'),
            SizedBox(
              height: 20,
            ),
            Text('* Posts must be suitable for all age groups'),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.setString('accept', 'yes');

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return InitializerWidget();
                }));
              },
              child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green),
                  child: Text(
                    'Accept',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ]),
        ),
      ),
    ));
  }
}
