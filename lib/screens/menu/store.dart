
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SparePartsStoreApp extends StatelessWidget {
  final List<Map<String, dynamic>> spareParts = [
    {'name': 'Brake Pad', 'price': 20.0, 'image': 'assets/brake_pad.png'},
    {'name': 'Oil Filter', 'price': 15.0, 'image': 'assets/oil_filter.png'},
    {'name': 'Air Filter', 'price': 18.0, 'image': 'assets/air_filter.png'},
    {'name': 'Spark Plug', 'price': 5.0, 'image': 'assets/spark_plug.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spare Parts Store'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Handle cart action
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: spareParts.length,
        itemBuilder: (context, index) {
          return SparePartCard(
            name: spareParts[index]['name'],
            price: spareParts[index]['price'],
            image: spareParts[index]['image'],
          );
        },
      ),
    );
  }
}

class SparePartCard extends StatelessWidget {
  final String name;
  final double price;
  final String image;

  const SparePartCard({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '\$$price',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    // Handle add to cart
                  },
                  child: Text('Add to Cart'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}