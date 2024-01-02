import 'package:flutter/material.dart';

class CartItem {
  final int? productId;
  final String? productName;

  final double? productPrice;
  final int? quantity;

  final String? image;

  CartItem(
      {required this.productId,
        required this.productName,
        required this.productPrice,
        required this.quantity,
        required this.image});

  CartItem.fromMap(Map<dynamic, dynamic> res)
      : productId = res["productId"],
        productName = res["productName"],
        productPrice = res["productPrice"],
        quantity = res["quantity"],
        image = res["image"];

  Map<String, Object?> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
      'image': image,
    };
  }
}

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        // brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),

      ),
      body: cartItems.isEmpty
          ? Center(
        child: Text('Your cart is empty.'),
      )
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          CartItem item = cartItems[index];
          return ListTile(
            title: Text('\${item.productName}'),
            subtitle: Text('Quantity: ${item.quantity}'),
            trailing: Text('\$${item.productPrice! * item.quantity!}'),
          );
        },
      ),
    );
  }
}
