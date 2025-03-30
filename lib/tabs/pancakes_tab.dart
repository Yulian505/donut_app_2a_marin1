import 'package:flutter/material.dart';
import '../utils/donut_tile.dart';

class PancakesTab extends StatelessWidget {
  final Function(double) onAddToCart;

  final List pancakesOnSale = [
    ["Banana", "Krispy Cream", 36.0, Colors.blue, "lib/images/banana_pancake.jpg"],
    ["Blueberry", "Dunkin", 45.0, Colors.red, "lib/images/blueberry_pancake.jpg"],
    ["Chocolate", "Krispy Cream", 84.0, Colors.purple, "lib/images/chocolate_pancake.jpg"],
    ["Classic Pancake", "Dunkin Donuts", 95.0, Colors.brown, "lib/images/classic_pancake.jpg"],
    ["Pumpkin", "Krispy Cream", 42.0, Colors.white, "lib/images/pumpkin_pancake.jpg"],
    ["Strawberry", "Dunkin", 55.0, Colors.amber, "lib/images/strawberry_pancake.jpg"],
    ["Cinnamon", "Krispy Cream", 77.0, Colors.indigo, "lib/images/cinnamon_pancake.jpg"],
    ["Redvelvet", "Dunkin", 65.0, Colors.orange, "lib/images/redvelvet_pancake.jpg"],
  ];

  //
  PancakesTab({super.key, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: pancakesOnSale.length,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5
      ),
      itemBuilder: (context, index) {
        return DonutTile(
          donutFlavor: pancakesOnSale[index][0],
          donutStore: pancakesOnSale[index][1],
          donutPrice: pancakesOnSale[index][2],
          donutColor: pancakesOnSale[index][3],
          imageName: pancakesOnSale[index][4],
          onAddToCart: () => onAddToCart(pancakesOnSale[index][2]),
        );
      }
    );
  }
}