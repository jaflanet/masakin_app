import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderList createState() => _OrderList();
}

class _OrderList extends State<OrderList> {
  late SharedPreferences sharedPreferences;
  late String finalEmail;
  @override
  void initState() {
    super.initState();
    getMenuData();
  }

  Future getMenuData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    finalEmail = sharedPreferences.getString('email')!;
    var queryParameters = {'email': finalEmail};
    var response = await http.get(
        Uri.https(
            'masakin-rpl.herokuapp.com', 'order/byemail', queryParameters),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    var jsonData = jsonDecode(response.body);
    print(response.body);

    List<Order> menus = [];

    for (var u in jsonData) {
      Order menu = Order(u['email'], u['orderFood'], u['totalPrice']);
      menus.add(menu);
    }
    print(menus.length);
    return menus;
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.45;
    return FutureBuilder(
        future: getMenuData(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
                child: SpinKitCircle(
              color: Color(0xFFF5C901),
            ));
          } else {
            var dataMenu = (snapshot.data as List<Order>).toList();
            if (dataMenu.isEmpty) {
              return Center(
                child: Text('No transcations yet',
                    style: TextStyle(color: Colors.black)),
              );
            }
            return ListView.builder(
              itemCount: dataMenu.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(30, 5, 30, 15),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: kElevationToShadow[1],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: Image.asset(
                                "assets/images/splash.png",
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Container(
                            width: c_width,
                            child: Text(
                              dataMenu[i].orderFood,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  dataMenu[i].total,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        });
  }
}

class Order {
  final String email;
  // final String orderId;
  final String total;
  final String orderFood;

  Order(
    this.email,
    // this.orderId,
    this.orderFood,
    this.total,
  );
}
