import 'package:flutter/material.dart';
import 'package:masakin_app/widget/custom_app_bar.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';

class addMenu extends StatefulWidget {
  const addMenu({Key? key}) : super(key: key);

  @override
  _addMenuState createState() => _addMenuState();
}

class _addMenuState extends State<addMenu> {
  TextEditingController menu = new TextEditingController();
  TextEditingController type = new TextEditingController();
  TextEditingController price = new TextEditingController();
  TextEditingController description = new TextEditingController();

  Dio dio = new Dio();

  late File _image;
  late var image;

  Future<Response> sendFile(String url, XFile file) async {
    Dio dio = new Dio();
    var len = await file.length();
    var response = await dio.post(url,
        data: file.openRead(),
        options: Options(headers: {
          Headers.contentLengthHeader: len,
        } // set content-length
            ));
    return response;
  }

  Future<Response> sendForm(
      String url, Map<String, dynamic> data, Map<String, XFile?> files) async {
    Map<String, MultipartFile> fileMap = {};
    for (MapEntry fileEntry in files.entries) {
      XFile file = fileEntry.value;
      String fileName = basename(file.path);
      fileMap[fileEntry.key] = MultipartFile(
          file.openRead(), await file.length(),
          filename: fileName);
    }
    data.addAll(fileMap);
    var formData = FormData.fromMap(data);
    Dio dio = new Dio();
    return await dio.post(url,
        data: formData, options: Options(contentType: 'multipart/form-data'));
  }

  Future getImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    return Image.file(image);
  }

  Future postMenu(
      image, String menu, String type, int price, String description) async {
    print('upload started');
    //upload image
    //scenario  one - upload image as poart of formdata
    var res1 = await sendForm('http://masakin-rpl.herokuapp.com/menu', {
      'restaurantId': 5,
      'menuTitle': menu,
      'type': type,
      'price': price,
      'description': description
    }, {
      'image': image
    });
    print("upload $res1");
    setState(() {
      _image = image as File;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              Row(
                children: [
                  customAppBar(),
                ],
              ),
              SizedBox(height: 50),
              const Text(
                'Add new menu',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 50),
              buildTitle(),
              SizedBox(height: 20),
              buildPrice(),
              SizedBox(height: 20),
              buildDescription(),
              SizedBox(height: 20),
              buildType(),
              SizedBox(height: 30),
              IconButton(
                onPressed: getImage,
                icon: Icon(
                  Icons.add_a_photo_outlined,
                  size: 30,
                ),
              ),
              SizedBox(height: 30),
              buildButtonSubmit(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtonSubmit(BuildContext context) => TextButton(
        onPressed: () {
          postMenu(image, menu.text, type.text, int.parse(price.text),
              description.text);
          Navigator.pushReplacementNamed(context, '/mainPage');
        },
        child: Text(
          'Submit',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: TextButton.styleFrom(
          elevation: 6,
          shadowColor: Colors.black,
          padding: EdgeInsets.fromLTRB(55.0, 15.0, 55.0, 15.0),
          backgroundColor: Color(0xFFFF8023),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(37),
          ),
        ),
      );

  Widget buildTitle() => Container(
        child: TextFormField(
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          controller: menu,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              right: 20,
              left: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(27),
              borderSide: BorderSide(
                color: Color(0xFFF5C901),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(27),
              borderSide: BorderSide(
                color: Color(0xFFF5C901),
                width: 2,
              ),
            ),
            labelText: 'Menu name',
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      );

  Widget buildPrice() => Container(
        child: TextFormField(
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          controller: price,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              right: 20,
              left: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(27),
              borderSide: BorderSide(
                color: Color(0xFFF5C901),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(27),
              borderSide: BorderSide(
                color: Color(0xFFF5C901),
                width: 2,
              ),
            ),
            labelText: 'Menu price',
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      );

  Widget buildDescription() => Container(
        child: TextFormField(
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          controller: description,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              right: 20,
              left: 20,
              top: 15,
              bottom: 5,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(27),
              borderSide: BorderSide(
                color: Color(0xFFF5C901),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(27),
              borderSide: BorderSide(
                color: Color(0xFFF5C901),
                width: 2,
              ),
            ),
            labelText: 'Description',
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      );

  Widget buildType() => Container(
        child: TextFormField(
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          controller: type,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              right: 20,
              left: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(27),
              borderSide: BorderSide(
                color: Color(0xFFF5C901),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(27),
              borderSide: BorderSide(
                color: Color(0xFFF5C901),
                width: 2,
              ),
            ),
            labelText: 'Type',
            labelStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
      );
}
