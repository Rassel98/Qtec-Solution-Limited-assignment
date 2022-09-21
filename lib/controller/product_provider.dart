import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:qtec_assignment/model/product_details.dart';

import '../db/db_hepler.dart';
import '../model/product.dart';

class ProductProvider extends ChangeNotifier {
  ProductsModel? productsModel;

  ProductDetailsModel? productDetailsModel;
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
  get data => productsModel != null;

  void getCurrentData(String value) async {
    try {
      print('calling api      ');
      var response = await DBHelper.getSearchData(
          '/product/search-suggestions/?limit=10&offset=10&search=$value');
      final map = jsonDecode(response);
      print('get map api');

      print('response ok api');
      productsModel = ProductsModel.fromJson(map);
      print(
          'Total Products  ${productsModel!.data!.products!.results!.length} ');
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

 void getDetails(String api) async {
    try {
      print('calling api      ');
      var response = await DBHelper.getSearchData(
          '/product-details/-0vl5/');
      final map = jsonDecode(response);
      print('get map api');

      print('response ok api');
      productDetailsModel = ProductDetailsModel.fromJson(map);
      print(
          'Total Products  ${productDetailsModel!.data!.description} ');
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }
}
