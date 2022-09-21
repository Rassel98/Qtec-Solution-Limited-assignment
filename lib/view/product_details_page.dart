import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qtec_assignment/controller/product_provider.dart';

class ProductDetailsPage extends StatelessWidget {
  static const String routeName = '/details';
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final slug = ModalRoute.of(context)!.settings.arguments as String;
    Provider.of<ProductProvider>(context,listen: false).getDetails(slug);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) =>provider.productDetailsModel!=null? ListView(
          children: [
            Text('data')
          ],
        ):const Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}
