import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/models/food.dart';
import 'package:intl/intl.dart';

import 'cart_item.dart';

class Restaurant extends ChangeNotifier {
  // list of food menu
  final List<Food> _menu = [
    // burgers
    Food(
      name: 'Classic CheeseBurger',
      description: 'A juicy beef patty with melted cheddar, lettuce and tomato',
      imagePath: 'images/burgers/burger.jpg',
      price: 0.99,
      category: FoodCategory.Burgers,
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 0.99),
        Addon(name: 'Avocado', price: 1.99),
      ],
    ),

    // drinks
    Food(
      name: 'Classic CheeseBurger',
      description: 'A juicy beef patty with melted cheddar, lettuce and tomato',
      imagePath: 'images/burgers/burger.jpg',
      price: 0.99,
      category: FoodCategory.Burgers,
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 0.99),
        Addon(name: 'Avocado', price: 1.99),
      ],
    ),

    // Salads
    Food(
      name: 'Classic CheeseBurger',
      description: 'A juicy beef patty with melted cheddar, lettuce and tomato',
      imagePath: 'images/burgers/burger.jpg',
      price: 0.99,
      category: FoodCategory.Burgers,
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 0.99),
        Addon(name: 'Avocado', price: 1.99),
      ],
    ),

    // Sides
    Food(
      name: 'Classic CheeseBurger',
      description: 'A juicy beef patty with melted cheddar, lettuce and tomato',
      imagePath: 'images/burgers/burger.jpg',
      price: 0.99,
      category: FoodCategory.Burgers,
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 0.99),
        Addon(name: 'Avocado', price: 1.99),
      ],
    ),

    // Desserts
    Food(
      name: 'Classic CheeseBurger',
      description: 'A juicy beef patty with melted cheddar, lettuce and tomato',
      imagePath: 'images/burgers/burger.jpg',
      price: 0.99,
      category: FoodCategory.Burgers,
      availableAddons: [
        Addon(name: 'Extra Cheese', price: 0.99),
        Addon(name: 'Avocado', price: 1.99),
      ],
    ),
  ];

  /*
  Getters 
  */

  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;

  /*
  Opetations 
  */

  // user cart
  final List<CartItem> _cart = [];

  // add to cart
  void addToCart(Food food, List<Addon> selectedAddons) {
    // see if there is a cart item already with the same food and selected addons
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      // check if the food items are the same
      bool isSameFood = item.food == food;

      // check if the list of selected addons are the same
      bool isSameAddons =
          ListEquality().equals(item.selectedAddons, selectedAddons);

      return isSameAddons && isSameFood;
    });

    // if ite already exists, increase it's quantity
    if (cartItem != null) {
      cartItem.quantity++;
    }

    // otherwise, add a new cart item to the cart
    else {
      _cart.add(CartItem(food: food, selectedAddons: selectedAddons));
    }

    notifyListeners();
  }

  // remove from cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartItem != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

  // get total price of cart
  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;

      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }

      total += itemTotal * cartItem.quantity;
    }

    return total;
  }

  // get total number of items in cart
  int getTotalItemCount() {
    int totalItemCount = 0;

    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }

    return totalItemCount;
  }

  // clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  /*
  Helpers 
  */

  // generate a receipt
  String displayCardReceipt() {
    final receipt = StringBuffer();
    receipt.writeln('Here\'s your receipt.');
    receipt.writeln();

    // format the date to include up to seconds only
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln('---------------');

    for (final cartItem in _cart) {
      receipt.writeln(
          "${cartItem.quantity} * ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}");
      if (cartItem.selectedAddons.isNotEmpty) {
        receipt.writeln(" Add-ons: ${_formatAddons(cartItem.selectedAddons)}");
      }
      receipt.writeln();
    }

    receipt.writeln("------------------");
    receipt.writeln();
    receipt.writeln("Total Items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");

    return receipt.toString();
  }

  // format double value into menoy
  String _formatPrice(double price) {
    return "\$${price.toStringAsFixed(2)}";
  }

  // format list of addons into a string summary
  String _formatAddons(List<Addon> addons) {
    return addons
        .map((addon) => '${addon.name} (${_formatPrice(addon.price)})')
        .join(", ");
  }
}
