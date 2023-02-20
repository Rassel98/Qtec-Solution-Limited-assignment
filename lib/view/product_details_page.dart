import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:qtec_assignment/controller/product_provider.dart';

import '../utils/constraint.dart';

class ProductDetailsPage extends StatelessWidget {
  static const String routeName = '/details';
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final slug = ModalRoute.of(context)!.settings.arguments as String;
    Provider.of<ProductProvider>(context, listen: false).getDetails(slug);
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      extendBody: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Product Details',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Consumer<ProductProvider>(builder: (context, provider, child) {
        final model = provider.productDetailsModel;
        return provider.productDetailsModel != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                      items: provider.productDetailsModel!.images!
                          .map((e) => Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    e.image.toString(),
                                  ))))
                          .toList(),
                      options: CarouselOptions(
                        height: 310,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.65,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {},
                        scrollDirection: Axis.horizontal,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      model!.productName.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'ব্রান্ডঃ ',
                              style: TextStyle(
                                  color: Color(0xff646464),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              model.brand!.name!,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'ডিস্ট্রিবিউটরঃ ',
                              style: TextStyle(
                                  color: Color(0xff646464),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'মোঃ মোবারাক হোসেন',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Stack(
                      children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 116,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('ক্রয়মূল্যঃ'),
                                      Text(
                                          '$currencySymbols ${model.charge!.currentCharge}'),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('বিক্রয়মূল্যঃ'),
                                      Text(
                                          '$currencySymbols ${model.charge!.sellingPrice}'),
                                    ],
                                  ),
                                  Divider(color: Colors.grey, indent: 2),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('লাভঃ '),
                                      Text(
                                          '$currencySymbols ${(model.charge!.sellingPrice! - model.charge!.currentCharge!).toString()}'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                'বিস্তারিত',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                            Html(
                              data: provider.productDetailsModel!.description,
                            ),
                          ],
                        ),
                        Positioned(
                            left: 158,
                            right: 0,
                            top: 90,
                            child: InkWell(
                              onTap: () {
                                print('purchase product');
                              },
                              child: Stack(
                                children: [
                                  Container(
                                      child: Image.asset(
                                    'assets/images/polygon.png',
                                    height: 80,
                                    width: 80,
                                  )),
                                  const Positioned(
                                      top: 30,
                                      left: 8,
                                      right: 0,
                                      child: Text(
                                        'এটি কিনুন',
                                        style: TextStyle(color: Colors.white),
                                      ))
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      }),
    );
  }
}
