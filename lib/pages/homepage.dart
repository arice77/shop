import 'package:flutter/material.dart';
import 'package:shop/Model/product_model.dart';
import 'package:shop/services/api_services.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  static String routeName = '/next';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  late List<Productss?> prod;

  getProds() async {
    prod = (await apiService.getProducts())!;
    print(prod[0]!.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Column(children: [Text(prod.length.toString())]),
    );
  }
}
