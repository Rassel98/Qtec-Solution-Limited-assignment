import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qtec_assignment/utils/constraint.dart';
import '../controller/product_provider.dart';
import 'product_details_page.dart';

class SearchPage extends StatelessWidget {
  static const String routeName = '/search';
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final txtController = TextEditingController();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 60,
            ),
            Container(
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: txtController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                clipBehavior: Clip.antiAlias,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search with keyword..',
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (txtController.text.isEmpty) return;

                      Provider.of<ProductProvider>(context, listen: false)
                          .getCurrentData(txtController.text);
                      // txtController.clear();
                      FocusScope.of(context).unfocus();
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Color(0xFFA7A7A7),
                    ),
                  ),
                  disabledBorder: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide:
                          BorderSide(color: Colors.purpleAccent, width: 2),
                      gapPadding: 4.0),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide.none,
                      gapPadding: 4.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Consumer<ProductProvider>(
                builder: (context, provider, child) => provider.data
                    ? SmartRefresher(
                        controller: provider.refreshController,
                        enablePullUp: true,
                        onLoading: () async {
                          final status =
                              await provider.getCurrentData(txtController.text);
                          if (status) {
                            provider.refreshController.loadComplete();
                          } else {
                            provider.refreshController.loadFailed();
                          }
                        },
                        onRefresh: () async {
                          final status = await provider.getCurrentData(
                              txtController.text,
                              isRefresh: true);
                          if (status) {
                            provider.refreshController.refreshCompleted();
                          } else {
                            provider.refreshController.refreshFailed();
                          }
                        },
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.65,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 4),

                            // scrollDirection: Axis.horizontal,
                            itemCount: provider.allResult.length,
                            itemBuilder: (context, index) {
                              final product = provider.allResult[index];
                              return InkWell(
                                onTap: () {
                                  print(product.slug);
                                  Navigator.pushNamed(
                                      context, ProductDetailsPage.routeName,
                                      arguments: product.slug);
                                },
                                child: Stack(
                                  children: [
                                    Card(
                                      color: Colors.white,
                                      shape: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Image.network(
                                            product.image!,
                                            height: 120,
                                            width: 115,
                                            fit: BoxFit.cover,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Flexible(
                                                    child: Text(
                                                  product.productName
                                                      .toString(),
                                                  maxLines: 3,
                                                  style: const TextStyle(
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                )),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text('ক্রয়'),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      '$currencySymbols ${product.charge!.currentCharge}',
                                                      style: const TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                    const SizedBox(
                                                      width: 35,
                                                    ),
                                                    Text(
                                                      product.charge!
                                                                  .discountCharge !=
                                                              null
                                                          ? '$currencySymbols ${product.charge!.discountCharge} '
                                                          : '$currencySymbols 0',
                                                      style: const TextStyle(
                                                        overflow: TextOverflow.ellipsis,
                                                          decoration: TextDecoration.lineThrough,
                                                          fontSize: 10),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text('বিক্রয়'),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        '$currencySymbols ${product.charge!.sellingPrice}',
                                                        style: const TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 35,
                                                    ),
                                                    Text(
                                                      '$currencySymbols ${product.charge!.profit}',
                                                      style: const TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    if (product.stock == null)
                                      Positioned(
                                          top: 6,
                                          right: height / 42.15,
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 25,
                                            width: 70,
                                            decoration: BoxDecoration(
                                                color:
                                                    Colors.red.withOpacity(.1),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(width / 82.2),
                                                )),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Text(
                                                  'Stock Nei',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              ],
                                            ),
                                          )),
                                  ],
                                ),
                              );
                            }),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
