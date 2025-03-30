import 'package:flutter/material.dart';
import '../utils/donut_tile.dart';

class BurgerTab extends StatelessWidget {
  // Change this to include the flavor parameter
  final Function(String, double) onAddToCart;

  BurgerTab({super.key, required this.onAddToCart});

  // Lista de hamburguesas en venta
  final List<List<dynamic>> burgersOnSale = [
    ["Classic", "Burger King", 75.0, Colors.brown, "lib/images/classic_burger.jpg"],
    ["Cheese", "McDonald's", 85.0, Colors.amber, "lib/images/cheese_burger.webp"],
    ["Double", "Wendy's", 95.0, Colors.deepOrange, "lib/images/double_burger.png"],
    ["Bacon", "Burger King", 105.0, Colors.redAccent, "lib/images/bacon_burger.png"],
    ["Veggie", "McDonald's", 80.0, Colors.green, "lib/images/veggie_burger.jpg"],
    ["Chicken", "Wendy's", 90.0, Colors.orange, "lib/images/chicken_burger.webp"],
    ["Fish", "Burger King", 85.0, Colors.blue, "lib/images/spicy_burger.png"],
    ["BBQ", "McDonald's", 100.0, Colors.brown, "lib/images/bbq_burger.png"],
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: burgersOnSale.length,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        return DonutTile(
          donutFlavor: burgersOnSale[index][0],
          donutStore: burgersOnSale[index][1],
          donutPrice: burgersOnSale[index][2],
          donutColor: burgersOnSale[index][3],
          imageName: burgersOnSale[index][4],
          // Pass both flavor and price to onAddToCart
          onAddToCart: () => onAddToCart(burgersOnSale[index][0], burgersOnSale[index][2]),
        );
      },
    );
  }
}