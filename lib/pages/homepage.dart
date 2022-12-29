import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/Model/product_model.dart';
import 'package:shop/services/api_services.dart';
import 'package:line_icons/line_icon.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop/widgets/productcard.dart';

import '../widgets/categorybutton.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  static String routeName = '/next';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  late List<Productss?> prod = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getProds();
  }

  getProds() async {
    print('h');
    prod = (await apiService.getProducts())!;

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          prod = prod;
        }));
    print(prod[0]!.title);
    return prod;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {},
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
      body: (prod == null || prod.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Builder(builder: (context) {
              return Column(children: [
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1.5),
                          top: BorderSide(color: Colors.grey, width: 1.5))),
                  height: Scaffold.of(context).appBarMaxHeight,
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    TextButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.search,
                          size: 35,
                          color: Colors.grey[600],
                        )),
                    CategoryButton(
                      categoryName: 'Shop',
                    ),
                    CategoryButton(categoryName: 'New Arrivals'),
                    CategoryButton(categoryName: 'Sneakers'),
                    CategoryButton(categoryName: 'Fashion'),
                    CategoryButton(categoryName: 'Trending')
                  ]),
                ),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.90, crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return ProductCard(
                          tile: prod[index]!.title ?? '****',
                          image: prod[index]!.images![0],
                          price: prod[index]!.price.toString());
                    },
                    itemCount: prod.length,
                  ),
                ),
              ]);
            }),
    );
  }
}
