import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  String image, tile, price;
  ProductCard(
      {super.key,
      required this.tile,
      required this.image,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(image),
            const Spacer(),
            Expanded(
              child: Text(
                tile,
                overflow: TextOverflow.clip,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              '\$ ' + price,
              overflow: TextOverflow.clip,
            )
          ],
        ),
      ),
    );
  }
}
