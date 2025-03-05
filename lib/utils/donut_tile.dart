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
   return Padding(
     padding: const EdgeInsets.all(12.0),
     child: Container(
         decoration: BoxDecoration(
          color: donutColor[50],
          borderRadius: BorderRadius.circular(24)),
        child: Column(
          children: [
            //PriceTag
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: donutColor[100],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      topRight: Radius.circular(24), //Para que ese borde este redondeado y no con un grado de 90°
                    )),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                    child: Text('\$$donutPrice',  //Si no se usa dos $$ solo sale el número pero no el símbolo
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: donutColor[800]),
                    ),
                )
              ],
            ),

           //Donut picture
            Padding(
              padding: 
                const EdgeInsets.symmetric(horizontal: 24.0, vertical:12), //Para evitar que salga grande del contenedor
              child: Image.asset(imageName),
            ),

            //Donut flavor text

            //Love icon + add button
          ],

        ),
          ),
   );
 }
}