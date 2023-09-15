import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nithitex/config/constants/sizes/widgetsize.dart';
import 'package:nithitex/features/categories/controllers/wishlist_provider.dart';
import 'package:nithitex/features/categories/repositories/all_product_call.dart';
import 'package:nithitex/features/categories/views/widgets/list_widget.dart';

import '../../controllers/providers.dart';
import '../../models/all_products_model.dart';

class HomePage extends ConsumerWidget {
   HomePage({super.key});
  List _list = [
    "New Arrivals",
    "Featured Products",
    "Best Selling",
    "Offer Products",
    "Other Product"
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    var _1data = ref.watch(allProductDataProviderOne);
    var _2data = ref.watch(allProductDataProviderTwo);
    var _3data = ref.watch(allProductDataProviderThree);
    var _4data = ref.watch(allProductDataProviderFour);
    var _5data = ref.watch(allProductDataProviderFive);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.refresh(allProductDataProviderOne);
          await ref.refresh(allProductDataProviderTwo);
          await ref.refresh(allProductDataProviderThree);
          await ref.refresh(allProductDataProviderFour);
          await ref.refresh(allProductDataProviderFive);

        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.38,
                child: _1data.when(data: (list) {
                  return ListWidget(
                    header: _list[0],
                    data: list,
                    scrollDirection: Axis.horizontal,
                    aspectRatio: 14.21 / 9.5,
                    crossAxisCount: 1,
                    gridBoxSize: WidgetSize.containerHeight,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 0,
                  );
                }, error: (err, nono) {
                  return Center(child: Text("Something went Wrong"));
                }, loading: () {
                  return Center(child: const CircularProgressIndicator());
                }),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.38,
                child: _2data.when(data: (list) {
                  return ListWidget(
                    header: _list[1],
                    data: list,
                    scrollDirection: Axis.horizontal,
                    aspectRatio: 14.21 / 9.5,
                    crossAxisCount: 1,
                    gridBoxSize: WidgetSize.containerHeight,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 0,
                  );
                }, error: (err, nono) {
                  return Center(child: Text("Something went Wrong"));
                }, loading: () {
                  return Center(child: const CircularProgressIndicator());
                }),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.38,
                child: _3data.when(data: (list) {
                  return ListWidget(
                    header: _list[2],
                    data: list,
                    scrollDirection: Axis.horizontal,
                    aspectRatio: 14.21 / 9.5,
                    crossAxisCount: 1,
                    gridBoxSize: WidgetSize.containerHeight,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 0,
                  );
                }, error: (err, nono) {
                  return Center(child: Text("Something went Wrong"));
                }, loading: () {
                  return Center(child: const CircularProgressIndicator());
                }),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.38,
                child: _4data.when(data: (list) {
                  return ListWidget(
                    header: _list[3],
                    data: list,
                    scrollDirection: Axis.horizontal,
                    aspectRatio: 14.21 / 9.5,
                    crossAxisCount: 1,
                    gridBoxSize: WidgetSize.containerHeight,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 0,
                  );
                }, error: (err, nono) {
                  return Text("Something went Wrong");
                }, loading: () {
                  return Center(child: const CircularProgressIndicator());
                }),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.38,
                child: _5data.when(data: (list) {
                  return ListWidget(
                    header: _list[4],
                    data: list,
                    scrollDirection: Axis.horizontal,
                    aspectRatio: 14.21 / 9.5,
                    crossAxisCount: 1,
                    gridBoxSize: WidgetSize.containerHeight,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 0,
                  );
                }, error: (err, nono) {
                  return Center(child: Text("Something went Wrong"));
                }, loading: () {
                  return Center(child: const CircularProgressIndicator());
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
