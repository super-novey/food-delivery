import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/cart_item.dart';
import 'package:food_delivery/models/food.dart';

class Restaurant extends ChangeNotifier {
  // list of food menu
  final List<Food> _menu = [
    // burgers
    Food(
        name: "Classic Chessesburger",
        description:
            "A juicy beef patty with melted cheddar, lettuce, tomato, and a hint of onion and pickle.",
        imagePath: "lib/images/image1.png",
        price: 0.99,
        category: FoodCategory.burgers,
        avaiableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99)
        ]),

    Food(
        name: "Classic Chessesburger 1",
        description:
            "A juicy beef patty with melted cheddar, lettuce, tomato, and a hint of onion and pickle.",
        imagePath: "lib/images/image2.png",
        price: 0.99,
        category: FoodCategory.burgers,
        avaiableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99)
        ]),

    Food(
        name: "Classic Chessesburger 2",
        description:
            "A juicy beef patty with melted cheddar, lettuce, tomato, and a hint of onion and pickle.",
        imagePath: "lib/images/image5.png",
        price: 0.99,
        category: FoodCategory.burgers,
        avaiableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99)
        ]),
    // salads

    Food(
        name: "Salad 1",
        description:
            "A juicy beef patty with melted cheddar, lettuce, tomato, and a hint of onion and pickle.",
        imagePath: "lib/images/image1.png",
        price: 0.99,
        category: FoodCategory.salads,
        avaiableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99)
        ]),

    Food(
        name: "Salad 2",
        description:
            "A juicy beef patty with melted cheddar, lettuce, tomato, and a hint of onion and pickle.",
        imagePath: "lib/images/image1.png",
        price: 0.99,
        category: FoodCategory.salads,
        avaiableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99)
        ]),

    // sides

    Food(
        name: "Side 1",
        description:
            "A juicy beef patty with melted cheddar, lettuce, tomato, and a hint of onion and pickle.",
        imagePath: "lib/images/image1.png",
        price: 0.99,
        category: FoodCategory.sides,
        avaiableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99)
        ]),

    Food(
        name: "Side 2",
        description:
            "A juicy beef patty with melted cheddar, lettuce, tomato, and a hint of onion and pickle.",
        imagePath: "lib/images/image2.png",
        price: 0.99,
        category: FoodCategory.sides,
        avaiableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99)
        ]),

    // desserts

    Food(
        name: "Dessert 1",
        description:
            "A juicy beef patty with melted cheddar, lettuce, tomato, and a hint of onion and pickle.",
        imagePath: "lib/images/image4.png",
        price: 0.99,
        category: FoodCategory.desserts,
        avaiableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99)
        ]),

    // drinks
    Food(
        name: "Drink 1",
        description:
            "A juicy beef patty with melted cheddar, lettuce, tomato, and a hint of onion and pickle.",
        imagePath: "lib/images/image5.png",
        price: 0.99,
        category: FoodCategory.drinks,
        avaiableAddons: [
          Addon(name: "Extra cheese", price: 0.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Avocado", price: 2.99)
        ]),
  ];

  // G E T T E R S

  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;

  // O P E R A T I O N S

  // user cart

  List<CartItem> _cart = [];

  
  // add to cart
  void addToCart(Food food, List<Addon> selectedAddons) {
    // see if there is a cart item already with the same food and selected addons

    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      // check if the food items are the same
      bool isSameFood = item.food == food;
      // check if the list of selected addons are the same

      bool isSameAddons =
          ListEquality().equals(item.selectedAddons, selectedAddons);

      return isSameAddons && isSameAddons;
    });

    if (cartItem != null) {
      // if item already exists, increase it's quantity
      cartItem.quantity++;
    }

    //otherwise, add a new cart item to the cart
    else {
      _cart.add(CartItem(food: food, selectedAddons: selectedAddons));
    }
    notifyListeners();
  }

  // remove from cart

  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

  // get toal price of cart

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
  H E L P E R S    
*/
}
