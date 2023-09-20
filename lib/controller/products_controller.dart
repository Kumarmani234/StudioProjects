
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  var data;
  Future<void> fetchData ()async{
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if(response.statusCode == 200){
      data = jsonDecode(response.body.toString());
    }else {
    }
  }
}

