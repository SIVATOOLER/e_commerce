import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nithitex/features/categories/controllers/providers.dart';
import 'package:nithitex/features/categories/models/all_products_model.dart';
import 'package:nithitex/features/categories/views/screens/product_detail_page.dart';
import 'package:nithitex/features/categories/views/widgets/list_widget.dart';
import 'package:pagination_view/pagination_view.dart';

import '../../../../config/constants/colors/colors.dart';
import '../../../../config/constants/sizes/textsize.dart';
import '../../../../config/constants/sizes/widgetsize.dart';
import '../../controllers/product_detail_provider.dart';
import '../../repositories/all_product_call.dart';





class OptionPage extends ConsumerWidget {
   OptionPage({super.key});
ScrollController _scrollController=ScrollController();
List<ProductList> totList =[];
   int i=1;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    List _totdata=ref.watch(totListProvider);
    var _data1=ref.watch(allProductDataProviderOne);
    var _data2=ref.watch(allProductDataProviderTwo);
    var _data3=ref.watch(allProductDataProviderThree);
    var _data4=ref.watch(allProductDataProviderFour);
    var _data5=ref.watch(allProductDataProviderFive);



    totList.addAll(_data1.value!.data.productList)

    ;
    _scrollListener() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {


          i==1? {
            totList.addAll(_data2.value!.data.productList),
          ref.read(totListProvider.notifier).update((state) =>  totList)
            , i=2
          }
            :null;
          i==2?{
            totList.addAll(_data3.value!.data.productList),
      ref.read(totListProvider.notifier).update((state) =>  totList),
          i=3
      }:null;
              i==3?{
                totList.addAll(_data4.value!.data.productList),
                ref.read(totListProvider.notifier).update((state) =>  totList),
      i=4
              }:null;
                  i==4?{
                    totList.addAll(_data5.value!.data.productList),
                    ref.read(totListProvider.notifier).update((state) =>  totList)
                  }:null;






          print("reach the bottom");
          print(i);

                  print(totList.length);
      }
      if (_scrollController.offset <= _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
   print( "reach the top");
   i=1;

      }
    }
    _scrollController.addListener(_scrollListener);
    return
      GridView.builder(
        controller: _scrollController,
        scrollDirection: Axis.vertical,

        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
             mainAxisSpacing: 20,
          childAspectRatio: 10/14.21,
        ),

        itemCount: totList.length,
        itemBuilder: (BuildContext context, int index) {

          return
         InkWell(
          onTap: () async {
            var _productId = totList[index].productId.toString();
            final productDetail = await ref.refresh(
                productDetailProvider
                    .call(_productId)
                    .future);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) =>
                        ProductDetailPage(
                            productId: _productId))));
          },
          child: Padding(
            padding:
            const EdgeInsets.only(left: 8.0, right: 8),
            child: Container(


              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment:
                    MainAxisAlignment.end,
                    children: [
                      Expanded(
                        flex:3,
                        child: Container(
                          height:
                          WidgetSize.containerHeight *
                              0.76,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:NetworkImage(totList[index].productImage),
                                  fit: BoxFit.cover),
                              color: Colors.white,
                              border: Border.all(
                                  color: AppColor
                                      .boarderColor),
                              borderRadius:
                              BorderRadius.circular(
                                  15)),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0),
                          child: SizedBox(
                            height:
                            WidgetSize.containerHeight *
                                0.24,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  totList[index].productName,
                                  style: TextStyle(

                                      fontSize: TextSize
                                          .boxSubTitleSize),
                                ),
                                Text(
                                  totList[index].categoryName
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight.w300,
                                      fontSize: TextSize
                                          .boxTitleSize-3,
                                      overflow: TextOverflow
                                          .ellipsis),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "₹${totList[index].productDiscount}  ",
                                      style: TextStyle(
                                          fontSize: TextSize.boxSubTitleSize,
                                          fontWeight:
                                          FontWeight
                                              .w500),
                                    ),
                                    Text(
                                      "₹${totList[index].productPrice}",
                                      style: TextStyle(
                                          fontSize: TextSize.boxSubTitleSize,
                                          decoration:
                                          TextDecoration
                                              .lineThrough,
                                          color:
                                          Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),



        ); },
      );
  //     PaginationView(
  //     shrinkWrap: true,
  //     scrollDirection: Axis.vertical,
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 2,
  //           childAspectRatio: 10/14.21,
  //       crossAxisSpacing: 0, mainAxisSpacing: 20,
  //
  //     ),
  //     itemBuilder: (BuildContext context,  user, int index) =>
  //         InkWell(
  //          onTap: () async {
  //            var _productId = user.productId.toString();
  //            final productDetail = await ref.refresh(
  //                productDetailProvider
  //                    .call(_productId)
  //                    .future);
  //
  //            Navigator.push(
  //                context,
  //                MaterialPageRoute(
  //                    builder: ((context) =>
  //                        ProductDetailPage(
  //                            productId: _productId))));
  //          },
  //          child: Padding(
  //            padding:
  //            const EdgeInsets.only(left: 8.0, right: 8),
  //            child: Container(
  //
  //
  //              decoration: BoxDecoration(
  //                  color: Colors.white,
  //                  borderRadius: BorderRadius.circular(15)),
  //              child: Stack(
  //                children: [
  //                  Column(
  //                    mainAxisAlignment:
  //                    MainAxisAlignment.end,
  //                    children: [
  //                      Expanded(
  //                        flex:3,
  //                        child: Container(
  //                          height:
  //                          WidgetSize.containerHeight *
  //                              0.76,
  //                          decoration: BoxDecoration(
  //                              image: DecorationImage(
  //                                  image:NetworkImage(user.productImage),
  //                                  fit: BoxFit.cover),
  //                              color: Colors.white,
  //                              border: Border.all(
  //                                  color: AppColor
  //                                      .boarderColor),
  //                              borderRadius:
  //                              BorderRadius.circular(
  //                                  15)),
  //                        ),
  //                      ),
  //                      Expanded(
  //                        flex: 1,
  //                        child: Padding(
  //                          padding: const EdgeInsets.only(
  //                              left: 8.0),
  //                          child: SizedBox(
  //                            height:
  //                            WidgetSize.containerHeight *
  //                                0.24,
  //                            child: Column(
  //                              crossAxisAlignment:
  //                              CrossAxisAlignment.start,
  //                              children: [
  //                                Text(
  //                                 user.productName,
  //                                  style: TextStyle(
  //
  //                                      fontSize: TextSize
  //                                          .boxSubTitleSize),
  //                                ),
  //                                Text(
  //                                  user.categoryName
  //                                      .toString(),
  //                                  style: TextStyle(
  //                                      fontWeight:
  //                                      FontWeight.w300,
  //                                      fontSize: TextSize
  //                                          .boxTitleSize-3,
  //                                      overflow: TextOverflow
  //                                          .ellipsis),
  //                                ),
  //                                Row(
  //                                  children: [
  //                                    Text(
  //                                      "₹${user.productDiscount}  ",
  //                                      style: TextStyle(
  //                                          fontSize: TextSize.boxSubTitleSize,
  //                                          fontWeight:
  //                                          FontWeight
  //                                              .w500),
  //                                    ),
  //                                    Text(
  //                                      "₹${user.productPrice}",
  //                                      style: TextStyle(
  //                                          fontSize: TextSize.boxSubTitleSize,
  //                                          decoration:
  //                                          TextDecoration
  //                                              .lineThrough,
  //                                          color:
  //                                          Colors.grey),
  //                                    ),
  //                                  ],
  //                                ),
  //                              ],
  //                            ),
  //                          ),
  //                        ),
  //                      ),
  //                    ],
  //                  ),
  //
  //                ],
  //              ),
  //            ),
  //          ),
  //
  //
  //
  //     ),
  //    paginationViewType: PaginationViewType.gridView ,// optional
  //
  //     onError: (dynamic error) => Center(
  //       child: Text('Some error occured'),
  //     ),
  //     onEmpty: Center(
  //       child: Text('Sorry! This is empty'),
  //     ),
  //     bottomLoader: Center( // optional
  //       child: CircularProgressIndicator(),
  //     ),
  //     initialLoader: Center( // optional
  //       child: CircularProgressIndicator(),
  //     ),
  //     pageFetch: (int currentListSize) async {
  //       print(currentListSize);
  //   //   if(currentListSize.)
  //     AllProductModel toList = await AllProductApiServices().getAllProductList(0);
  // print(currentListSize);
  //       return toList.data.productList;
  //   },
  //
  //   );
     }

}



