import 'package:flutter/material.dart';

class customAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 25,
      ),
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/mainPage');
        },
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 0.5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
          ),
        ),
      ),
    );
  }
}
