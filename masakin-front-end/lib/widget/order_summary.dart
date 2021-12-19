import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masakin_app/controllers/cart_controller.dart';
import 'package:http/http.dart' as http;
import 'package:masakin_app/widget/custom_app_bar.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class orderSummary extends StatefulWidget {
  const orderSummary({Key? key}) : super(key: key);

  @override
  _orderSummaryState createState() => _orderSummaryState();
}

class _orderSummaryState extends State<orderSummary> {
  late SharedPreferences sharedPreferences;
  late String finalEmail;

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  Future getEmail() async {
    sharedPreferences = await SharedPreferences.getInstance();
    finalEmail = sharedPreferences.getString('email')!;
  }

  final cartController controller = Get.find();

  order(String orderlist, String totalprice) async {
    final response = await http.post(
      Uri.parse('https://masakin-rpl.herokuapp.com/order'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email": finalEmail,
        "orderFood": orderlist,
        "totalPrice": totalprice,
      }),
    );

    if (response.statusCode == 200) {
      print("success");
      controller.clearList();
       Navigator.pushReplacementNamed(context, '/mainPage');
      // successDialog(context);
    } else {
      print("failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.4;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    customAppBar(),
                  ],
                ),
                Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 22),
                Text(
                  'Pujasera M.O.M',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      'Order Summary',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 400,
                  child: ListView.builder(
                      itemCount: controller.foodList2.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: kElevationToShadow[1],
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                Text(
                                  '${controller.foodAmount[index]}x',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: c_width,
                                  child: Text(
                                    '${controller.foodName[index]}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'Rp. ${controller.foodPrice[index]}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Row(
                  children: [
                    Text(
                      'Payment Summary',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Rp. ${controller.getTotal()}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                orderButton2(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  createModal(BuildContext context2) {
    double c_height = MediaQuery.of(context).size.height * 1;
    return showModalBottomSheet(
      backgroundColor: Color(0xFFF5C901).withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      context: context2,
      builder: (context2) {
        return Container(
          height: c_height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Column(
            children: [
              SizedBox(height: 30),
              Text(
                'Scan to Pay',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 30),
              Image.asset(
                'assets/images/barcode_saweria.jpg',
                height: 200,
                width: 200,
              ),
              Spacer(),
              Text(
                'or',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () async {
                  const url = 'https://saweria.co/masakin';
                  if (await launch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Text(
                  'saweria.co/masakin',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),
                ),
              ),
              Spacer(),
              ConfirmButton(context2),
            ],
          ),
        );
      },
    );
  }

  Container orderButton2(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          createModal(context);
        },
        child: Row(
          children: [
            Icon(
              Icons.assignment_outlined,
              color: Colors.black,
              size: 28,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              'Order',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          elevation: 5,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(37),
          ),
        ),
      ),
    );
  }

  Widget ConfirmButton(BuildContext context2) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
      child: Container(
        child: ElevatedButton(
          onPressed: () {
            order(controller.foodlist().toString(),
                controller.getTotal().toString());
            Navigator.pop(context2);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            elevation: 6,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(37)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Confirm Payment',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
