import 'dart:convert';

import 'package:example_four/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModels> productList = [];
  Future<List<ProductModels>> ProductApi() async {
    var response = await http.get(
        Uri.parse("https://webhook.site/b376952d-2946-496e-97e5-0f8c5d1582b9"));
    var data = jsonDecode(response.body.toUpperCase());
    if (response.statusCode == 200) {
      productList.clear();
      for (Map i in data) {
        productList.add(ProductModels.fromJson(i));
      }
      return productList;
    } else {
      return productList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest Apies"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: ProductApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading");
                } else {
                  return ListView.builder(
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Text(productList[index].id.toString()),
                          ],
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
