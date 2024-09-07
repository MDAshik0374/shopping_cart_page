import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: GlobalKey<ScaffoldMessengerState>(),
      home: ShoppingCart(),
    );
  }
}

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List productName = ["Nike Air", "Nike Carter", "NIke Jordan"];
  final Map<String, Map<String, dynamic>> myMap = {
    "nike_air": {
      "name": "Nike Air",
      "image": "assets/images/nike_air.png",
      "color": "white",
      "size": "L",
      "price": 30,
      "quantity": 1,
    },
    "nike_carter": {
      "name": "Nike Carter",
      "image": "assets/images/nike_carter.png",
      "color": "white",
      "size": "M",
      "price": 35,
      "quantity": 1,
    },
    "nike_jordan": {
      "name": "Nike Jordan",
      "image": "assets/images/nike_jordan1.png",
      "color": "red",
      "size": "L",
      "price": 40,
      "quantity": 1,
    }
  };

  int totalAmount = 0;

  @override
  void initState() {
    super.initState();
    _calculateTotalAmount();
  }

  void _calculateTotalAmount() {
    int sum = 0;
    myMap.forEach((key, value) {
      int price = value["price"] as int; // Explicitly cast price as int
      int quantity =
          value["quantity"] as int; // Explicitly cast quantity as int
      sum += price * quantity;
    });
    setState(() {
      totalAmount = sum;
    });
  }

  void _incrementQuantity(String key) {
    setState(() {
      myMap[key]!["quantity"] += 1;
      _calculateTotalAmount();
    });
  }

  void _decrementQuantity(String key) {
    setState(() {
      if (myMap[key]!["quantity"] > 1) {
        myMap[key]!["quantity"] -= 1;
        _calculateTotalAmount();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // scaffoldMessengerKey: GlobalKey<ScaffoldMessengerState>(),
      home: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("My Bag", style: TextStyle(fontSize: 30)),
                    ListView.builder(
                        itemCount: myMap.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          String key = myMap.keys.elementAt(index);
                          String name = myMap[key]!["name"];
                          String image = myMap[key]!["image"];
                          String color = myMap[key]!["color"];
                          String size = myMap[key]!["size"];
                          int price = myMap[key]!["price"];
                          int quantity = myMap[key]!["quantity"];
                          return Container(
                            height: 130,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.2),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  )
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    image,
                                    height: 90,
                                    width: 120,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(name),
                                    Row(
                                      //mainAxisAlignment:
                                      //  MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Color: $color"),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("Size: $size")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(.2),
                                                  spreadRadius: 2,
                                                  blurRadius: 6,
                                                  offset: Offset(0, 5),
                                                )
                                              ]),
                                          child: IconButton(
                                            icon: Icon(Icons.add),
                                            color: Colors.black,
                                            onPressed: () {
                                              _incrementQuantity(key);
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text("$quantity"),
                                        SizedBox(width: 10),
                                        Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(.2),
                                                  spreadRadius: 2,
                                                  blurRadius: 10,
                                                  offset: Offset(0, 5),
                                                )
                                              ]),
                                          child: IconButton(
                                            icon: Icon(Icons.remove),
                                            color: Colors.black,
                                            onPressed: () {
                                              _decrementQuantity(key);
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.more_vert),
                                    Text(
                                      "\$${price * quantity}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
              //Spacer(),
              SizedBox(height: 120),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Amount:"),
                        Text("\$$totalAmount"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Congrats!"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Text(
                          "CHECK OUT",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
