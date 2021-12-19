import 'package:flutter/material.dart';
import '../../widget/widgets.dart';

class foodCart extends StatelessWidget {
  const foodCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF5C901),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                      ),
                    ),
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 25, 0, 20),
                    child: Row(
                      children: [
                        Icon(Icons.add_shopping_cart),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          children: [
                            Text(
                              'Your Cart',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 30, 0, 20),
                child: Container(
                  child: Text(
                    'Order List',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              CartProducts(),
              CartTotal(),
            ],
          ),
        ),
      ),
    );
  }
}
