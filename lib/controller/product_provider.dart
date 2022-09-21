

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../db/db_hepler.dart';
import '../model/product.dart';

class ProductProvider extends ChangeNotifier {

  ProductsModel? productsModel;
  // Product? product;
  // getData() async {
  //   var response = await DBHelper.getSearchData('/product/search-suggestions/?limit=10&offset=10&search=rice')
  //       .catchError((err) {});
  //   if (response == null) return;
  //   debugPrint('successful:');
  //
  //   productsModel=productsModelFromJson(response);
  //   //product=Product.fromJson(response);
  //
  //
  //
  //   //users = userFromJson(response);
  //
  //   debugPrint('Product count: ${productsModel!.data!.products!.results!.length}');
  //   //debugPrint('Product count: ${product!.data!.products!.count}');
  //   notifyListeners();
  // }
  //
get data=>productsModel!=null;

 void getCurrentData(String value)async {
    final uri=Uri.parse('https://panel.supplyline.network/api/product/search-suggestions/?limit=10&offset=10&search=$value');
    try{
      print('calling api');

      final response= await get(uri);
      final map=jsonDecode(response.body);
      print('get map api');
      if(response.statusCode==200){
        print('response ok api');
        productsModel=ProductsModel.fromJson(map);
        print('Total Products  ${productsModel!.data!.products!.results!.length} ');
        notifyListeners();
      }
      else{
        print(map['message']);
      }

    }catch(err){
      rethrow;
    }

  }


}