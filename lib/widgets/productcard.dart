import 'package:flutter/material.dart';
import 'package:shop/Model/product_model.dart';
import 'package:shop/pages/productpage.dart';
import 'package:shop/services/api_services.dart';

class ProductCard extends StatelessWidget {
  String image, tile, price, rating;
  ProductCard(
      {super.key,
      required this.tile,
      required this.image,
      required this.price,
      required this.rating});
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ProductPage.routeName, arguments: tile);
      },
      child: Card(
        child: Container(
          height: 50,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                image,
                fit: BoxFit.fitHeight,
              ),
              const Spacer(),
              Expanded(
                child: Text(
                  tile,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Text(
                    '\$ ' + price,
                    overflow: TextOverflow.clip,
                  ),
                  Spacer(),
                  Text(rating),
                  Icon(Icons.star)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
