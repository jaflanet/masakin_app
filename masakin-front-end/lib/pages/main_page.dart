import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:masakin_app/api/food_api.dart';
import 'package:masakin_app/models/food.dart';
import 'package:masakin_app/pages/screen/food_cart.dart';
import 'package:masakin_app/navbar_key.dart';
import 'package:masakin_app/pages/screen/account.dart';
import 'package:masakin_app/pages/screen/home.dart';
import 'package:masakin_app/pages/screen/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';

late String finalEmail;

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  List<Food> foods = [];
  String query = '';
  late SharedPreferences sharedPreferences;
  late String finalEmail;

  @override
  void initState() {
    super.initState();
    getImageData();
    checkLoginStatus();
    getAccountData();
  }

  Future getImageData() async {
    foods = await getFoods(query);
  }

  static Future<List<Food>> getFoods(String query) async {
    final response =
        await http.get(Uri.https('masakin-rpl.herokuapp.com', 'menu'));
    if (response.statusCode == 200) {
      final List foods = json.decode(response.body);
      // print(foods);
      return foods.map((json) => Food.fromJson(json)).toList().where((food) {
        final titleLower = food.menuTitle.toLowerCase();
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  checkLoginStatus() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString('email'));
    if (sharedPreferences.getString('email') == null) {
      Navigator.pushReplacementNamed(context, '/loginPage');
    }
  }

  Future getAccountData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    finalEmail = sharedPreferences.getString('email')!;
    print(sharedPreferences.getString('email'));

    var queryParameters = {'email': finalEmail};
    var response = await http.get(
        Uri.https(
            'masakin-rpl.herokuapp.com', 'account/byemail', queryParameters),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    var jsonData = jsonDecode(response.body);
    print(response.body);

    List<Account> accounts = [];

    for (var u in jsonData) {
      Account account = Account(u['name'], u['email'], u['accPhoneNumber'],
          u['profilePicture'], u['address'], u['accountType']);
      accounts.add(account);
      print(accounts);
    }
    return accounts;
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFFFDFBF2),
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.transparent,
        color: Color(0xFFF5C901),
        animationDuration: Duration(milliseconds: 400),
        index: selectedIndex,
        key: NavbarKey.getKey(),
        items: [
          Icon(
            Icons.home,
            size: 30,
          ),
          Icon(Icons.library_books, size: 30),
          Icon(Icons.add_shopping_cart, size: 30),
          Icon(
            Icons.person,
            size: 30,
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: FutureBuilder(
          future: getAccountData(),
          builder: (context, snapshot) {
            if (snapshot.data == null || foods.isEmpty) {
              return Container(
                child: Center(
                  child: SpinKitCircle(color: Color(0xFFF5C901)),
                ),
              );
            } else {
              var dataAccount = (snapshot.data as List<Account>).toList();
              // print(foods);
              final screen = [
                HomeScreen(accounts: dataAccount, foods: foods),
                MenuScreen(),
                foodCart(),
                AccountScreen(accounts: dataAccount)
              ];
              return Container(
                child: screen[selectedIndex],
              );
            }
          }),
    ));
  }
}
