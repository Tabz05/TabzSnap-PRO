import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tabzsnappro/models/user_data_models/user_id_model.dart';
import 'package:tabzsnappro/services/database_service.dart';
import 'package:tabzsnappro/shared/colors.dart';
import 'package:tabzsnappro/shared/loading.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  
  File? _imageFile = null;
  final _picker = ImagePicker();

  Future _imgFromGallery() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  Future _imgFromCamera() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  TextEditingController _postText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    final _user = Provider.of<UserIdModel?>(context);

    final DatabaseService _databaseService = DatabaseService();

    return _user==null?Loading(): SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text('New Post'),
          centerTitle: true,
          backgroundColor: red_main,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Column(children: [
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter text here...",
                      ),
                      cursorColor: red_main,
                      maxLines: 8,
                      controller: _postText,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () async {
                              await _imgFromGallery();
                            },
                            child: Icon(
                              Icons.image,
                              color: red_main,
                              size: 30,
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: () async {
                              await _imgFromCamera();
                            },
                            child: Icon(
                              Icons.camera,
                              color: red_main,
                              size: 30,
                            ))
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: red_main)),
              ),
              SizedBox(
                height: 30,
              ),
              _imageFile == null
                  ? SizedBox()
                  : Column(
                      children: [
                        Container(
                            width: 200,
                            height: 200,
                            child: Image(
                              image: FileImage(_imageFile!),
                              fit: BoxFit.cover,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _imageFile = null;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.yellow[600],
                            ),
                            child: Text(
                              'Remove',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  _postText.text.isEmpty && _imageFile == null
                      ? ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Enter text or choose image"),
                          ),
                        )
                      : 
                       await _databaseService.createNewPost(_user.uid!,_postText.text, _imageFile);
                    
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Post uploaded"),
                          ),
                        );
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: red_main),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
