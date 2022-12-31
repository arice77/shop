import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop/Model/product_model.dart';

import 'dart:convert';

class Product {
  final String name;
  final double price;
  final String imageUrl;

  Product(this.name, this.price, this.imageUrl);
}

class ApiService {
  List<Productss>? prod;
  Future<List<Productss>?> getProducts() async {
    try {
      var url = Uri.parse('https://fakestoreapi.com/products');
      var response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        prod = welcomeFromJson(response.body);
        print(prod!.length);
        return prod;
      }
    } catch (e) {}
    return [];
  }

  Future<List<Productss>> fetchProducts(String category) async {
    var url = Uri.parse('https://fakestoreapi.com/products/category/$category');
    var response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<Productss> model = welcomeFromJson(response.body);
      print(model.length);
      return model;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Productss>? oneProduct(String title) async {
    prod = await getProducts();
    print(title);
    Iterable<Productss> oneProd =
        prod!.where((element) => element.title!.trim() == title.trim());
    print(prod!.length);
    print(oneProd.first.price);
    return oneProd.first;
  }
}
