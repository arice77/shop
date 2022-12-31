import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:shop/Model/product_model.dart';
import 'package:shop/services/api_services.dart';

class ProductPage extends StatefulWidget {
  ProductPage({super.key});
  static String routeName = '/product-page';

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late String args;
  bool loading = false;
  Productss? prod;
  ApiService apiService = ApiService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  fetch() async {
    setState(() {
      loading = true;
    });
    await Future.delayed(
      Duration.zero,
      () async {
        args = ModalRoute.of(context)!.settings.arguments as String;
        prod = (await apiService.oneProduct(args))!;
        setState(() {
          loading = false;
        });
      },
    );
    print(args);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  apiService.oneProduct(
                      'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops');
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 7.0),
                  child: Text(
                    'Cart(0)',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ))
          ],
          title: Center(
            child: Text(
              'C A S A',
              style: GoogleFonts.viaodaLibre(
                  color: Colors.black, fontWeight: FontWeight.w900),
            ),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          elevation: 0,
          leading: Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(left: 13),
              child: TextButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: LineIcon.gripLines(
                    size: 35,
                    color: Colors.black,
                  )),
            );
          }),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
        ),
        body: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: height / 2,
                        child: Image.network(prod!.image!),
                      ),
                      Container(
                        child: Column(children: [
                          Row(
                            children: [
                              Text(prod!.title!),
                              Spacer(),
                              Text(prod!.price!.toString())
                            ],
                          ),
                          Text('Size'),
                          Container(
                            decoration: BoxDecoration(border: Border.all()),
                            child: TextButton(
                              child: Text('S'),
                              onPressed: () {},
                            ),
                          ),
                          Text(prod!.description!),
                          ElevatedButton(
                              onPressed: () {}, child: Text('Add to Cart'))
                        ]),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
