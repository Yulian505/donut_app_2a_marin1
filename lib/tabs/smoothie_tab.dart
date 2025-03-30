import 'package:flutter/material.dart';
import '../utils/donut_tile.dart';

class SmoothieTab extends StatelessWidget {
  final Function(double) onAddToCart;

  SmoothieTab({super.key, required this.onAddToCart});

  // Lista de smoothies en venta
  final List<List<dynamic>> smoothiesOnSale = [
    ["Strawberry", "Jamba Juice", 65.0, Colors.pink, "lib/images/strawberry_smoothie.jpg"],
    ["Blueberry", "Smoothie King", 70.0, Colors.indigo, "lib/images/blueberry_smoothie.jpg"],
    ["Mango", "Jamba Juice", 75.0, Colors.orange, "lib/images/mango_smoothie.png"],
    ["Banana", "Smoothie King", 60.0, Colors.yellow, "lib/images/banana_smoothie.jpg"],
    ["Green", "Jamba Juice", 80.0, Colors.green, "lib/images/green_smoothie.png"],
    ["Berry", "Smoothie King", 70.0, Colors.purple, "lib/images/berry_smoothie.jpg"],
    ["Tropical", "Jamba Juice", 75.0, Colors.teal, "lib/images/tropical_smoothie.jpg"],
    ["Chocolate", "Smoothie King", 65.0, Colors.brown, "lib/images/chocolate_smoothie.jpg"],
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: smoothiesOnSale.length,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        return DonutTile(
          donutFlavor: smoothiesOnSale[index][0],
          donutStore: smoothiesOnSale[index][1],
          donutPrice: smoothiesOnSale[index][2],
          donutColor: smoothiesOnSale[index][3],
          imageName: smoothiesOnSale[index][4],
          onAddToCart: () => onAddToCart(smoothiesOnSale[index][2]),
        );
      },
    );
  }
}