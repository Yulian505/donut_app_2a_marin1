import 'package:flutter/material.dart';
 
class DonutTile extends StatelessWidget {
 final String donutFlavor;
 final String donutPrice;
 final dynamic donutColor;  //dynamic porque será de tipo Color y también usará []
 final String imageName;
 
 const DonutTile({
   super.key,
   required this.donutFlavor,
   required this.donutPrice,
   required this.donutColor,
   required this.imageName,
 });
                 
 @override
 Widget build(BuildContext context) {
   return Container(
       decoration: BoxDecoration(
     color: donutColor[50],
   ));
 }
}