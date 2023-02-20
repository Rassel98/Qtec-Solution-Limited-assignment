import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../model/product.dart';

class ProductProvider extends ChangeNotifier {

  ProductModel? productDetailsModel;
  List<ProductModel> allResult = [];
  get data => allResult != [];
  late List<ProductModel> limitList = [];
  final refreshController = RefreshController(initialRefresh: false);
  var currentPage = 10;

  Future<bool> getCurrentData(String value, {bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 10;
    }
    try {
      final url = Uri.parse(
          'https://panel.supplyline.network/api/product/search-suggestions/?format=json&limit=$currentPage&offset=10&search=$value');

      http.Response response =
          await http.get(url, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final responseJson = json.decode(utf8.decode(response.bodyBytes));
        print(responseJson['data']['products']['results']);

        limitList = responseJson['data']['products']['results']
            .map<ProductModel>((item) => ProductModel.fromJson(item))
            .toList();
        print('Total Products resultList ${limitList.length}');

        if (isRefresh) {
          allResult = limitList;
        } else {
          if (limitList.isEmpty) {
            refreshController.loadNoData();
          }
          allResult.addAll(limitList);
        }
        currentPage+=10;
        notifyListeners();
        return true;
      }
    } catch (err) {
      rethrow;
    }
    return false;

  }

  void getDetails(String slug) async {
    print(slug);
    try {
      final url = Uri.parse(
          'https://panel.supplyline.network/api/product-details/$slug/');

      http.Response response =
          await http.get(url, headers: {'Content-Type': 'application/json'});
      if(response.statusCode==200){
        final responseJson = json.decode(utf8.decode(response.bodyBytes));
        print(responseJson['data']);
        productDetailsModel = ProductModel.fromJson(responseJson['data']);
      }

      notifyListeners();
    } catch (err) {
      rethrow;
    }

  }
}
