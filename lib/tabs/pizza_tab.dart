import 'package:flutter/material.dart';

import '../utils/donut_tile.dart';

class PizzaTab extends StatelessWidget {

  //lista de donas
  final List donutsOnSale = [
      // [ donutFlavor, donutStore, donutPrice, donutColor, imageName ]
   ["Ice Cream", "Krispy Cream", "36", Colors.blue, "lib/images/icecream_donut.png"],
   ["Strawberry", "Dunkin Donuts", "45", Colors.red, "lib/images/strawberry_donut.png"],
   ["Grape Ape", "Krispy Cream", "84", Colors.purple, "lib/images/grape_donut.png"],
   ["Choco", "Dunkin Donuts", "95", Colors.brown, "lib/images/chocolate_donut.png"],
   ["Ice Cream", "Krispy Cream", "36", Colors.blue, "lib/images/icecream_donut.png"],
   ["Strawberry", "Dunkin Donuts", "45", Colors.red, "lib/images/strawberry_donut.png"],
   ["Grape Ape", "Krispy Cream", "84", Colors.purple, "lib/images/grape_donut.png"],
   ["Choco", "Dunkin Donuts", "95", Colors.brown, "lib/images/chocolate_donut.png"],

  ];
  PizzaTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      //Cuantos elementos tiene
      itemCount: donutsOnSale.length,
      padding: const EdgeInsets.all(12),
      //Encargado de organizar la cuadrícula
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //Widget desplazable y eficiente para listar y encabezados

        //Determinar el número de columnas
        crossAxisCount: 2,
        //Relación de aspecto
        childAspectRatio: 1 / 1.5),
      itemBuilder: (context, index){
        return DonutTile(
          //Elemento individual de la cuadrícula
          donutFlavor: donutsOnSale[index][0],
          donutStore: donutsOnSale[index][1],
          donutPrice: donutsOnSale[index][2],
          donutColor: donutsOnSale[index][3],
          imageName: donutsOnSale[index][4],
        );
      });
    
  }
}