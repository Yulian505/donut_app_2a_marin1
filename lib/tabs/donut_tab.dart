import 'package:flutter/material.dart';
import '../utils/donut_tile.dart';

class DonutTab extends StatelessWidget {
  final Function(double) onAddToCart;

  final List donutsOnSale = [
    ["Ice Cream", "Krispy Cream", 36.0, Colors.blue, "lib/images/icecream_donut.png"],
    ["Strawberry", "Dunkin Donuts", 45.0, Colors.red, "lib/images/strawberry_donut.png"],
    ["Grape Ape", "Krispy Cream", 84.0, Colors.purple, "lib/images/grape_donut.png"],
    ["Choco", "Dunkin Donuts", 95.0, Colors.brown, "lib/images/chocolate_donut.png"],
    ["Vanilla", "Krispy Cream", 42.0, Colors.white, "lib/images/vanilla_donut.png"],
    ["Caramel", "Dunkin Donuts", 55.0, Colors.amber, "lib/images/caramel_donut.jpg"],
    ["Blueberry", "Krispy Cream", 77.0, Colors.indigo, "lib/images/blueberry_donut.jpg"],
    ["Maple", "Dunkin Donuts", 65.0, Colors.orange, "lib/images/maple_donut.png"],
  ];

  //
  DonutTab({super.key, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: donutsOnSale.length,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5
      ),
      itemBuilder: (context, index) {
        return DonutTile(
          donutFlavor: donutsOnSale[index][0],
          donutStore: donutsOnSale[index][1],
          donutPrice: donutsOnSale[index][2],
          donutColor: donutsOnSale[index][3],
          imageName: donutsOnSale[index][4],
          onAddToCart: () => onAddToCart(donutsOnSale[index][2]),
        );
      }
    );
  }
}