import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qtec_assignment/controller/product_provider.dart';
import 'view/product_details_page.dart';
import 'view/search_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: const Color(0xFFE5E5E5),

      ),
      initialRoute: SearchPage.routeName,
      routes: {
        ProductDetailsPage.routeName:(context) => ProductDetailsPage(),
        SearchPage.routeName:(context) => SearchPage()
      },
    );
  }
}
