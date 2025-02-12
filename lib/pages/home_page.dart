import 'package:flutter/material.dart';
 
class HomePage extends StatefulWidget {
  const HomePage({super.key});
 
  @override
  State<HomePage> createState() => _HomePageState();
}
 
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        //Ícono de la Izquierda
        leading: Icon(
          Icons.menu,
          color: Colors.grey[800],
        ),
        actions: [Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: Icon(Icons.person),
        )
        ],
      ),
      body: const Column(
        children: [
          //Texto "I want to Eat"
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 36, vertical: 18),
            child: Row(
              children: [
                Text("I want to ",
                style: TextStyle(fontSize: 32)),
                Text("Eat",
                style: TextStyle(
                  //Tamaño de letra
                  fontSize: 32,
                  //Negritas
                  fontWeight: FontWeight.bold,
                  //Subrayado
                  decoration: TextDecoration.underline)
                ),
              ],
            ),
          )
          //Tap bar
 
          //Tab bar View
 
          //Carrito
        ],)
    );
  }
}