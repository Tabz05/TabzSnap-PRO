import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{
    
    final String? text;
    final String? sender;
    final int? timeStampMicro;

    MessageModel({this.text,this.sender,this.timeStampMicro});

}