import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/components/my_button.dart';
import 'package:flutter_food_delivery_app/components/my_cart_tile.dart';
import 'package:flutter_food_delivery_app/models/restaurant.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(builder: (context, restaurant, child) {
      // cart
      final userCart = restaurant.cart;

      // scaffold UI
      return Scaffold(
        appBar: AppBar(
          title: const Text("Cart"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            // clear cart button
            if(userCart.isNotEmpty)
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text(
                              'Are you sure you want to clear the cart?'),
                          actions: [
                            // cancel button
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancle'),
                            ),

                            // yes button
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                restaurant.clearCart();
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        ));
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: Column(
          children: [
            userCart.isEmpty
                ? const Expanded(child: Center(child: Text("Cart is Empty...")))
                : Expanded(
                  child: Column(
                    children: [
                      Expanded(
                       
                          child: ListView.builder(
                              itemCount: userCart.length,
                              itemBuilder: (context, index) {
                                // get individual cart item
                                final cartItem = userCart[index];
                      
                                // return cart tile UI
                                return MyCartTile(cartItem: cartItem);
                              }),
                        ),
                  
                        // button to pay
                        const MyButton(text: 'Checkout'),

                        const SizedBox(height: 25),
                    ],
                  ),
                ),
          ],
        ),
      );
    });
  }
}
