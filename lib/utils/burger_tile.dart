import 'package:flutter/material.dart';

class BurgerTile extends StatelessWidget {
  final String burgerName;
  final String burgerStore;
  final String burgerPrice;
  final Color burgerColor;
  final String imageName;

  const BurgerTile({
    super.key,
    required this.burgerName,
    required this.burgerStore,
    required this.burgerPrice,
    required this.burgerColor,
    required this.imageName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: burgerColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Imagen de la hamburguesa
            Image.asset(
              imageName,
              height: 100,
            ),

            // Nombre de la hamburguesa
            Text(
              burgerName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            // Nombre del restaurante
            Text(
              burgerStore,
              style: TextStyle(color: Colors.grey[700]),
            ),

            // Precio
            Text(
              "\$$burgerPrice",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            // Botón de compra
            ElevatedButton(
              onPressed: () {
                // Aquí puedes agregar la funcionalidad para agregar al carrito
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: burgerColor,
                foregroundColor: Colors.white,
              ),
              child: const Text("Ordenar"),
            ),
          ],
        ),
      ),
    );
  }
}

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