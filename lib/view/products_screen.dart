import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../controller/products_controller.dart';

class ProductScreen extends StatelessWidget {
  final  ProductController controller = Get.put(ProductController());
  var data;
  Future<void> fetchData ()async{
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if(response.statusCode == 200){
    data = jsonDecode(response.body.toString());
    print('Data : '+data.toString());
    }else {
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Api Data'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: fetchData(),
                builder: (context , snapshot){

                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: Text('Loading.....',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),);
                  }else {
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.circular(50),
                              ),
                                child:Container(
                                      height: 200,
                                      child: Row(
                                        children: [
                                         Container(
                                           child:Padding(
                                             padding: const EdgeInsets.all(8.0),
                                             child: Column(
                                               children: [
                                                 Expanded(child: Image.network(data[index]['image']),),
                                                 Text(data[index]['category'].toString()),
                                                 Padding(
                                                   padding: const EdgeInsets.all(8.0),
                                                   child: Row(
                                                     children: [
                                                       Text(data[index]['price'].toString()),
                                                       Text(data[index]['rating'].toString()),
                                                     ],
                                                   ),
                                                 ),
                                               ],
                                             ),
                                           ),
                                        ),
                                        ],
                                      ),
                                    ),
                                ),
                              );
                        });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

