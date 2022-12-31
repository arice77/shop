import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  String categoryName;
  CategoryButton({Key? key, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: null,
      child: Text(
        categoryName,
        style: TextStyle(fontSize: 17, color: Colors.grey[600]),
      ),
    );
  }
}
