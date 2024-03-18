import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:karimstore/models/product.dart';
import 'package:http/http.dart' as http;


class OneProduct extends StatefulWidget {
  final Product product;
  const OneProduct({super.key, required this.product});

  @override
  State<OneProduct> createState() => _OneProductState();
}

class _OneProductState extends State<OneProduct> {
  Product? product;

  @override
  void initState() {
    super.initState();
    _getProduct();
  }

  Future<void> _getProduct() async {
    // if(Platform.isAndroid) {
    //   // await dotenv.load(fileName: '.env');
    //   var url = Uri.parse("http://10.0.2.2:7017/api/Produit/GetProductsDTO");
    //   final response = await http.get(url, headers: {"Content-Type": "application/json"});
    //   final List body = json.decode(response.body);
    //   return body.map((e) => Product.fromJson(e)).toList();
    // }

     var url = Uri.parse('https://karimeshop.azurewebsites.net/api/Produit/GetProductById?produitId=${widget.product.productId}');
     final response = await http.get(url, headers: {"Content-Type": "application/json"});
     if(response.statusCode == 200) {
      setState(() {
        product = Product.fromJson(jsonDecode(response.body));
      });
     } else {
      const Text("No data available");
     }
  }
  @override
  Widget build(BuildContext context) {
    if(product == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: Text(product!.productTitle.toString())),
      body: Center(child: Text(product!.productDescription.toString()),
      ),
    );
  }
}