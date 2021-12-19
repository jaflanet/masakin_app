import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masakin_app/controllers/cart_controller.dart';
import 'package:masakin_app/models/food.dart';

class CartProducts extends StatelessWidget {
  final cartController controller = Get.put(cartController());

  CartProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double c_height = MediaQuery.of(context).size.height * 0.45;
    return Obx(
      () => SizedBox(
        height: c_height,
        child: ListView.builder(
            itemCount: controller.foods.length,
            itemBuilder: (BuildContext context, int index) {
              return CartProductCard(
                controller: controller,
                food: controller.foods.keys.toList()[index],
                quantity: controller.foods.values.toList()[index],
                index: index,
              );
            }),
      ),
    );
  }
}

class CartProductCard extends StatelessWidget {
  final cartController controller;
  final Food food;
  final int quantity;
  final int index;

  const CartProductCard({
    Key? key,
    required this.controller,
    required this.food,
    required this.quantity,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: kElevationToShadow[1],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Image.network(
                  food.photo,
                  width: 80,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.menuTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Rp. ${food.price}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  controller.removeItem(food);
                },
                icon: Icon(
                  Icons.remove_circle,
                ),
              ),
              Text('${quantity}'),
              IconButton(
                onPressed: () {
                  controller.addItem(food);
                },
                icon: Icon(
                  Icons.add_circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
