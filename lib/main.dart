import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart.dart';
import 'sandwich.dart';
import 'extra.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Cart(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BOM HAMBURGUER',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MenuScreen(),
    );
  }
}

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          ...sandwiches.map((sandwich) {
            return ListTile(
              title: Text(sandwich.name),
              subtitle: Text('\$${sandwich.price.toStringAsFixed(2)}'),
              onTap: () {
                try {
                  cart.addSandwich(sandwich);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${sandwich.name} added to cart'),
                  ));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(e.toString()),
                  ));
                }
              },
            );
          }).toList(),
          ...extras.map((extra) {
            return ListTile(
              title: Text(extra.name),
              subtitle: Text('\$${extra.price.toStringAsFixed(2)}'),
              onTap: () {
                try {
                  if (extra.name == "Fries") {
                    cart.addFries(extra);
                  } else {
                    cart.addSoftDrink(extra);
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${extra.name} added to cart'),
                  ));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(e.toString()),
                  ));
                }
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (cart.sandwich != null)
              Text('Sandwich: ${cart.sandwich!.name} - \$${cart.sandwich!.price.toStringAsFixed(2)}'),
            if (cart.fries != null)
              Text('Fries - \$${cart.fries!.price.toStringAsFixed(2)}'),
            if (cart.softDrink != null)
              Text('Soft Drink - \$${cart.softDrink!.price.toStringAsFixed(2)}'),
            SizedBox(height: 20),
            Text(
              'Total: \$${cart.total.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            TextField(
              decoration: InputDecoration(labelText: 'Customer Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Simulate payment process
                cart.clearCart();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Order placed successfully!'),
                ));
                Navigator.pop(context);
              },
              child: Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }
}
