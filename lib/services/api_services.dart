import 'package:http/http.dart' as http;
import 'package:shop/Model/product_model.dart';

class ApiService {
  Future<List<Productss>?> getProducts() async {
    try {
      var url = Uri.parse('https://api.escuelajs.co/api/v1/products');
      var response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<Productss> model = welcomeFromJson(response.body);
        print(model.length);
        return model;
      }
    } catch (e) {}
    return [];
  }
}
