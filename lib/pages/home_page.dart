import 'package:donut_app_2a_marin1/tabs/burger_tab.dart';
import 'package:donut_app_2a_marin1/tabs/donut_tab.dart';
import 'package:donut_app_2a_marin1/tabs/pancakes_tab.dart';
import 'package:donut_app_2a_marin1/tabs/pizza_tab.dart';
import 'package:donut_app_2a_marin1/tabs/smoothie_tab.dart';
import 'package:donut_app_2a_marin1/utils/my_tab.dart';
import 'package:flutter/material.dart';
 
class HomePage extends StatefulWidget {
  const HomePage({super.key});
 
  @override
  State<HomePage> createState() => _HomePageState();
}
 
class _HomePageState extends State<HomePage> {
  // Add cart state with more detailed information
  List<Map<String, dynamic>> cartItems = [];
  double totalPrice = 0;

  // Function to add items to cart with more details
  void addToCart(String itemName, String flavor, double price) {
    setState(() {
      cartItems.add({
        'name': itemName,
        'flavor': flavor,
        'price': price,
      });
      totalPrice += price;
    });
  }

  List<Widget> myTabs = [
    //Donut tab
    const MyTab(iconPath: 'lib/icons/donut.png'),
    //Burger tab
    const MyTab(iconPath: 'lib/icons/burger.png'),
    //Smoothie tab
    const MyTab(iconPath: 'lib/icons/smoothie.png'),
    //Pancake tab
    const MyTab(iconPath: 'lib/icons/pancakes.png'),
    //Pizza tab
    const MyTab(iconPath: 'lib/icons/pizza.png'),
  ];
   
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      //Este widget sirve para gestionar las pestañas
      child: Scaffold(
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
        body: Column(
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
            ),
            //Tap bar (Pestañas)
            TabBar(tabs: myTabs),
      
            //Tab bar View(Contenido de pestañas)
            Expanded(
              child: TabBarView(children: [
                // Pass the addToCart function to each tab with flavor parameter
                DonutTab(onAddToCart: (price) => addToCart("Donut", "Various", price)),
                BurgerTab(onAddToCart: (flavor, price) => addToCart("Burger", flavor, price)),
                SmoothieTab(onAddToCart: (price) => addToCart("Smoothie", "Various", price)),
                PancakesTab(onAddToCart: (price) => addToCart("Pancake", "Various", price)),
                PizzaTab(onAddToCart: (price) => addToCart("Pizza", "Various", price)),
              ],)
            ),
            //Carrito
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Padding(
                  padding: EdgeInsets.only(left: 28),
                  child: Column (
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${cartItems.length} Items | \$${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Delivery Charges Included', 
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                 ElevatedButton(
                        onPressed: () {
                          // Show cart items in a dialog or navigate to cart page
                          if (cartItems.isNotEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Your Cart'),
                                content: Container(
                                  width: double.maxFinite,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: cartItems.length,
                                    itemBuilder: (context, index) {
                                      final item = cartItems[index];
                                      return ListTile(
                                        title: Text('${item['name']}'),
                                        subtitle: Text('${item['flavor']}'),
                                        trailing: Text('\$${item['price'].toStringAsFixed(2)}'),
                                      );
                                    },
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Close'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Checkout logic would go here
                                      Navigator.pop(context);
                                    },
                                    child: Text('Checkout'),
                                  ),
                                ],
                              ),
                            );
                          }
                        }, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255,218,113,148),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12)),
                        child: const Text(
                          "View Cart", style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              )
          ],
       )),
    );
  }
}