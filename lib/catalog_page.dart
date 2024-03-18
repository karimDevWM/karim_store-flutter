import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:karimstore/models/product.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:karimstore/oneProduct_page.dart';

class Catalog extends StatefulWidget {
  const Catalog({super.key});

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  // variable to call and store future list of posts
  Future<List<Product>> productsFuture = getProducts();
  
  // function to fetch data from api and return future list of posts
  static Future<List<Product>> getProducts() async {
    // if(Platform.isAndroid) {
    //   // await dotenv.load(fileName: '.env');
    //   var url = Uri.parse("http://10.0.2.2:7017/api/Produit/GetProductsDTO");
    //   final response = await http.get(url, headers: {"Content-Type": "application/json"});
    //   final List body = json.decode(response.body);
    //   return body.map((e) => Product.fromJson(e)).toList();
    // }

     var url = Uri.parse("https://karimeshop.azurewebsites.net/api/Produit/GetProductsDTO");
     final response = await http.get(url, headers: {"Content-Type": "application/json"});
     final List body = json.decode(response.body);
     return body.map((e) => Product.fromJson(e)).toList();
  }
  // build function
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Karim Store')),
      body: Center(
        // FutureBuilder
        child: FutureBuilder<List<Product>>(
          future: productsFuture,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              // until data is fetched, show loader
              return const CircularProgressIndicator();
            } else if(snapshot.hasData) {
              // once data is fetched, display it on screen (call buildProducts)
              final products = snapshot.data!;
              return buildProducts(products);
            } else {
              //if no data, show simple Text
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }

  // function to display fetched data on screen
  Widget buildProducts(List<Product> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Image.asset('images/${products[index].produitImage}.jpeg'),
              ListTile(
                title: Text(products[index].productTitle!),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(products[index].productDescription!,
                style: TextStyle(color: Colors.black.withOpacity(1.0)),
                ),
              ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                   TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {
                      Navigator
                        .of(context)
                        .push(
                          MaterialPageRoute(
                            builder: (context)=>OneProduct(product: products[index],)
                          ),
                        );
                    },
                    child: Text("voir"),
                   ),
                  ],
                ),
            ]),
        );
      }
      );
    
    
    
    
    
    
    
    // // ListView Builder to show data is a list
    // return ListView.builder(
    //   itemCount: products.length,
    //   itemBuilder: (context, index) {
    //     return Card(
    //       child: ListTile(
    //         title: Text(products[index].productTitle!),
    //         // leading: SizedBox(
    //         //   width: 50,
    //         //   height: 50,
    //         //   child: Image.network(src),
    //         // ),
    //         onTap: () {
    //           Navigator
    //             .of(context)
    //             .push(
    //               MaterialPageRoute(
    //                 builder: (context)=>OneProduct(product: products[index],)
    //               )
    //             );
    //         },
    //       ),
    //     );
    //   },
    // );
  }
}

//       String url = "http://localhost:7017/api/Produit/GetProductsDTO";

