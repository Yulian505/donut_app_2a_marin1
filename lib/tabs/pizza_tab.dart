import 'package:flutter/material.dart';
import '../utils/donut_tile.dart';

class PizzaTab extends StatelessWidget {
  final Function(double) onAddToCart;

  PizzaTab({super.key, required this.onAddToCart});

  // Lista de pizzas en venta
  final List<List<dynamic>> pizzasOnSale = [
    ["Margherita", "Pizza Hut", 85.0, Colors.red, "lib/images/margherita_pizza.jpg"],
    ["Pepperoni", "Domino's", 95.0, Colors.redAccent, "lib/images/pepperoni_pizza.jpg"],
    ["Vegetarian", "Papa John's", 90.0, Colors.green, "lib/images/vegetarian_pizza.jpg"],
    ["Hawaiian", "Pizza Hut", 100.0, Colors.orange, "lib/images/hawaiian_pizza.jpg"],
    ["BBQ Chicken", "Domino's", 110.0, Colors.brown, "lib/images/bbq_pizza.jpg"],
    ["Supreme", "Papa John's", 120.0, Colors.purple, "lib/images/supreme_pizza.png"],
    ["Cheese", "Pizza Hut", 80.0, Colors.yellow, "lib/images/cheese_pizza.jpg"],
    ["Mushroom", "Domino's", 95.0, Colors.grey, "lib/images/mushroom_pizza.webp"],
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: pizzasOnSale.length,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        return DonutTile(
          donutFlavor: pizzasOnSale[index][0],
          donutStore: pizzasOnSale[index][1],
          donutPrice: pizzasOnSale[index][2],
          donutColor: pizzasOnSale[index][3],
          imageName: pizzasOnSale[index][4],
          onAddToCart: () => onAddToCart(pizzasOnSale[index][2]),
        );
      },
    );
  }
}
