import 'package:flutter/material.dart';
import 'package:masakin_app/api/food_api.dart';
import 'package:masakin_app/controllers/cart_controller.dart';
import 'package:get/get.dart';

import 'package:masakin_app/models/food.dart';
import 'package:masakin_app/widget/search_widget.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

class FoodList extends StatefulWidget {
  @override
  _FoodList createState() => _FoodList();
}

class _FoodList extends State<FoodList> {
  List<Food> foods = [];
  String query = '';
  final CartController = Get.put(cartController());
  Timer? debouncer;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 100),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    foods = await FoodApi.getFoods(query);

    setState(() => this.foods = foods);
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Container(
            child: SpinKitCircle(
            color: Color(0xFFF5C901),
          ))
        : Scaffold(
            body: Column(
              children: [
                buildSearch(),
                Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 15),
                  child: Row(
                    children: [
                      Text(
                        'Menu',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: foods.length,
                    itemBuilder: (context, index) {
                      final food = foods[index];
                      return listFood(food);
                    },
                  ),
                ),
              ],
            ),
          );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search here..',
        onChanged: searchFood,
      );

  Future searchFood(String query) async => debounce(() async {
        final foods = await FoodApi.getFoods(query);
        if (!mounted) return;
        setState(() {
          this.query = query;
          this.foods = foods;
        });
        setState(() => loading = false);
      });

  Widget listFood(Food food) {
    double c_width = MediaQuery.of(context).size.width * 0.4;
    Color getColor(String text) {
      if (text == 'HALAL') {
        return Color(0xFF23AB17);
      } else {
        return Color(0xFFF5C901);
      }
    }

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(right: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    food.photo,
                    width: 80,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: c_width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: getColor(food.type), width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        food.type,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
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
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  CartController.addItem(food);
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
