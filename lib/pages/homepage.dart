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
  bool loading = false;
  ApiService apiService = ApiService();
  late List<Productss?> prod = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getProds();
  }

  fetchProd(String category) async {
    setState(() {
      loading = true;
    });
    prod = await apiService.fetchProducts(category);
    setState(() {
      loading = false;
      prod = prod;
    });
  }

  getProds() async {
    prod = (await apiService.getProducts())!;

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          prod = prod;
        }));
    return prod;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
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
      body: (prod == null || prod.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            )
          : Builder(builder: (context) {
              return Column(children: [
                TabBar(context),
                loading
                    ? const Expanded(
                        child: Center(
                          child:
                              CircularProgressIndicator(color: Colors.purple),
                        ),
                      )
                    : Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.50, crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return ProductCard(
                              tile: prod[index]!.title ?? '****',
                              image: prod[index]!.image ??
                                  'https://imgs.search.brave.com/nuIJMuYyFq_uENi8Cz4KUS9O-X8B7SfvVCByOXdtOJI/rs:fit:898:225:1/g:ce/aHR0cHM6Ly90c2Uy/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC4y/MDNPeUlRclpRY3ZQ/QXR0dHJ1a3NnSGFE/NiZwaWQ9QXBp',
                              price: prod[index]!.price.toString() +
                                  '-' +
                                  prod[index]!.id.toString(),
                              rating: prod[index]!.rating!.rate.toString(),
                            );
                          },
                          itemCount: prod.length,
                        ),
                      ),
              ]);
            }),
    );
  }

  // ignore: non_constant_identifier_names
  Container TabBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey, width: 1.5),
              top: BorderSide(color: Colors.grey, width: 1.5))),
      height: Scaffold.of(context).appBarMaxHeight,
      child: ListView(scrollDirection: Axis.horizontal, children: [
        TextButton(
            onPressed: () async {
              await apiService.oneProduct(
                  'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops');
            },
            child: Icon(
              Icons.search,
              size: 35,
              color: Colors.grey[600],
            )),
        GestureDetector(
          onTap: () {
            print('hi');
            fetchProd('electronics');
          },
          child: CategoryButton(
            categoryName: 'Electronics',
          ),
        ),
        GestureDetector(
            onTap: () {
              fetchProd('jewelery');
            },
            child: CategoryButton(categoryName: 'Jewelery')),
        GestureDetector(
            onTap: () => fetchProd("men's clothing"),
            child: CategoryButton(categoryName: "Men's clothing")),
        GestureDetector(
            onTap: () => fetchProd("women's clothing"),
            child: CategoryButton(categoryName: "Women's clothing")),
      ]),
    );
  }
}
