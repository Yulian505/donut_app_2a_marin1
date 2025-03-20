import 'package:flutter/material.dart';

class DonutTile extends StatelessWidget {
final String donutFlavor;
final String donutStore;
  final String imageName;
final String donutPrice;
final dynamic donutColor;  //dynamic porque será de tipo Color y también usará []



const DonutTile({
   super.key,
   required this.donutFlavor,
   required this.donutPrice,
   required this.donutColor,
   required this.imageName,
   required this.donutStore,
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
          Row(mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: donutColor [100],
                borderRadius:  const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  topRight: Radius.circular(24))),
              padding: 
              const EdgeInsets.symmetric(vertical: 8, horizontal: 18 ),
              child: Text("\$$donutPrice", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: donutColor[800])),)
          ],
          ),
          //Donut picture
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Image.asset(imageName),
          ),
          //Donut flavor text
          Text(donutFlavor, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          //Espacio entre textos
          const SizedBox(
            height: 4,
          ),
          Text(donutStore),
          // Love icon + add
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {
                  // Handle favorite action
                },
              ),
              TextButton(
                child: Text("Add"),
                onPressed: () {
                  // Handle add action
                },
              ),
            ],
          ),

          ],
        ),

        ),
   );
}
}