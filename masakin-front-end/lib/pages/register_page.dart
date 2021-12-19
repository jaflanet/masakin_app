import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;

class registerPage extends StatefulWidget {
  const registerPage({Key? key}) : super(key: key);

  @override
  _registerPageState createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController accPhoneNumber = new TextEditingController();
  TextEditingController address = new TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _showPassword = true;

  void _toggleShow() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void validateInput() {
    if (formKey.currentState!.validate()) {
      signup(name.text, email.text, password.text, accPhoneNumber.text,
          address.text);
    } else {
      print("Not validated");
    }
  }

  signup(String name, email, password, accPhoneNumber, address) async {
    final response = await http.post(
      Uri.parse('https://masakin-rpl.herokuapp.com/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "name": name,
        "email": email,
        "password": password,
        "accPhoneNumber": accPhoneNumber,
        "address": address
      }),
    );

    if (response.statusCode == 200) {
      print("success to create account");
      successDialog(context);
      Navigator.pushReplacementNamed(context, '/loginPage');
    } else {
      print("failed to create account");
    }
  }

  successDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          title: Text(
            'Your account has been created',
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Please log in with your account',
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: new SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    "assets/images/register.png",
                    scale: 1.3,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Container(
                    padding: EdgeInsets.only(left: 75.0, right: 75.0),
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: const Text(
                                  'Sign up',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          buildName(),
                          const SizedBox(height: 23.0),
                          buildEmail(),
                          const SizedBox(height: 23),
                          buildPassword(),
                          const SizedBox(height: 23),
                          buildPhoneNumber(),
                          const SizedBox(height: 23),
                          buildAddress(),
                          const SizedBox(height: 35),
                          buildButtonSignUp(),
                          SizedBox(height: 28),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: kElevationToShadow[6],
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/loginPage');
                              },
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 9),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Color(0xFFF5C901),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildName() => Container(
          child: TextFormField(
        controller: name,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
        validator: RequiredValidator(errorText: "Required"),
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          errorStyle: TextStyle(
            fontWeight: FontWeight.w500,
          ),
          hintText: 'Name',
          hintStyle: TextStyle(
            color: Color(0xFF817E7E),
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(37),
            borderSide: BorderSide(
              color: Color(0xFFF5C901),
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(37),
            borderSide: BorderSide(
              color: Color(0xFFF5C901),
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.all(16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(37),
          ),
        ),
      ));

  Widget buildEmail() => Container(
        child: TextFormField(
          controller: email,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
          validator: MultiValidator(
            [
              RequiredValidator(errorText: "Required"),
              EmailValidator(errorText: "Not a valid email"),
            ],
          ),
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            errorStyle: TextStyle(
              fontWeight: FontWeight.w500,
            ),
            hintText: 'Email',
            hintStyle: TextStyle(
              color: Color(0xFF817E7E),
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(37),
              borderSide: BorderSide(
                color: Color(0xFFF5C901),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(37),
              borderSide: BorderSide(
                color: Color(0xFFF5C901),
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(37),
            ),
          ),
        ),
      );

  Widget buildPassword() => Container(
        child: TextFormField(
          controller: password,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
          obscureText: _showPassword,
          validator: MultiValidator(
            [
              RequiredValidator(
                errorText: "Required",
              ),
              MinLengthValidator(
                8,
                errorText: "Min. 8 characters",
              )
            ],
          ),
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(_showPassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined),
              onPressed: _toggleShow,
              color: Color(_showPassword ? 0xFF817E7E : 0xFFF5C901),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            errorStyle: TextStyle(
              fontWeight: FontWeight.w500,
            ),
            hintText: 'Password',
            hintStyle: TextStyle(
              color: Color(0xFF817E7E),
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(37),
              borderSide: BorderSide(
                color: Color(0xFFF5C901),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(37),
              borderSide: BorderSide(
                color: Color(0xFFF5C901),
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(37),
            ),
          ),
        ),
      );

  Widget buildPhoneNumber() => Container(
        child: TextFormField(
          controller: accPhoneNumber,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
          keyboardType: TextInputType.phone,
          validator: MultiValidator(
            [
              RequiredValidator(
                errorText: "Required",
              ),
            ],
          ),
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            errorStyle: TextStyle(
              fontWeight: FontWeight.w500,
            ),
            hintText: 'Phone Number',
            hintStyle: TextStyle(
              color: Color(0xFF817E7E),
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(37),
              borderSide: BorderSide(
                color: Color(0xFFF5C901),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(37),
              borderSide: BorderSide(
                color: Color(0xFFF5C901),
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(37),
            ),
          ),
        ),
      );

  Widget buildAddress() => Container(
          child: TextFormField(
        controller: address,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
        validator: RequiredValidator(errorText: "Required"),
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          errorStyle: TextStyle(
            fontWeight: FontWeight.w500,
          ),
          hintText: 'Address',
          hintStyle: TextStyle(
            color: Color(0xFF817E7E),
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(37),
            borderSide: BorderSide(
              color: Color(0xFFF5C901),
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(37),
            borderSide: BorderSide(
              color: Color(0xFFF5C901),
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.all(16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(37),
          ),
        ),
      ));

  Widget buildButtonSignUp() => TextButton(
        onPressed: () {
          validateInput();
        },
        child: Text(
          'Sign up',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        style: TextButton.styleFrom(
          elevation: 6,
          shadowColor: Colors.black,
          padding: EdgeInsets.fromLTRB(
            55.0,
            15.0,
            55.0,
            15.0,
          ),
          backgroundColor: Color(0xFFFF8023),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(37)),
        ),
      );
}
