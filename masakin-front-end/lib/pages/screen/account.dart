import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  List accounts = [];
  AccountScreen({Key? key, required this.accounts}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late SharedPreferences sharedPreferences;
  late String finalEmail;

  @override
  void initState() {
    super.initState();
    logOut();
  }

  Future logOut() async {
    sharedPreferences = await SharedPreferences.getInstance();
    finalEmail = sharedPreferences.getString('email')!;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5C901),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  height: 200,
                ),
                Positioned(
                    top: 100,
                    child: Container(
                      height: 165,
                      width: 165,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFFDFBF2), width: 10),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image:
                              NetworkImage(widget.accounts[0].profilePicture),
                        ),
                      ),
                    ))
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 45),
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Text(
                    widget.accounts[0].name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  buildEmailText(widget.accounts[0].email),
                  buildPhoneNum(widget.accounts[0].accPhoneNumber),
                  buildAddrText(widget.accounts[0].address),
                  buildAddMenu(widget.accounts[0].accountType),
                  buildButtonSignOut(),
                ],
              )),
        ],
      ),
    );
  }

  Column buildEmailText(email) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Icon(
              Icons.email_outlined,
              size: 30,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Email',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              email,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ],
        ),
        Divider(
          color: Color(0xFFF5C901),
          thickness: 3,
        ),
      ],
    );
  }

  Column buildPhoneNum(phoneNum) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Icon(
              Icons.phone_outlined,
              size: 30,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Phone Number',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              phoneNum,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ],
        ),
        Divider(
          color: Color(0xFFF5C901),
          thickness: 3,
        ),
      ],
    );
  }

  Column buildAddrText(address) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Icon(
              Icons.email_outlined,
              size: 30,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Address',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Flexible(
              child: Text(
                address,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: Color(0xFFF5C901),
          thickness: 3,
        ),
      ],
    );
  }

  Container buildButtonSignOut() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 50, 0, 40),
      child: TextButton(
        onPressed: () {
          print(context);
          sharedPreferences.clear();
          Navigator.pushReplacementNamed(context, '/loginPage');
        },
        child: Text('Logout',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            )),
        style: TextButton.styleFrom(
          elevation: 6,
          shadowColor: Colors.black,
          padding: EdgeInsets.fromLTRB(55.0, 15.0, 55.0, 15.0),
          backgroundColor: Color(0xFFFF8023),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(37),
          ),
        ),
      ),
    );
  }

  Container buildAddMenu(accountType) {
    if (accountType == 'ADMINISTRATOR') {
      return Container(
        padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
        child: TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/addMenu');
          },
          child: Text(
            'Add menu',
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
            backgroundColor: Color(0xFFF5C901),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(37),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

class Account {
  final String name,
      email,
      accPhoneNumber,
      profilePicture,
      address,
      accountType;

  Account(this.name, this.email, this.accPhoneNumber, this.profilePicture,
      this.address, this.accountType);
}
