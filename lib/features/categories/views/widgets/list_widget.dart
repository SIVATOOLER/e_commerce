import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:nithitex/config/constants/colors/colors.dart';
import 'package:nithitex/config/constants/sizes/textsize.dart';
import 'package:nithitex/config/constants/sizes/widgetsize.dart';
import 'package:nithitex/features/categories/controllers/product_detail_provider.dart';
import 'package:nithitex/features/categories/repositories/wish_list_call.dart';
import 'package:nithitex/features/categories/views/screens/product_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/providers.dart';
import '../../controllers/wishlist_provider.dart';
import '../../models/add_wish-list.dart';
import '../../models/all_products_model.dart';
import '../../models/cart_list_model.dart';
import '../../models/wish_list_model.dart';
import '../../repositories/add_cart_list_call.dart';
import '../../repositories/add_wish_list_call.dart';

class ListWidget extends ConsumerWidget {
  ListWidget({
    super.key,
    required this.header,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
    required this.gridBoxSize,
    required this.scrollDirection,
    required this.aspectRatio,
    required this.crossAxisCount,
    required this.data,
  });
  var header;
  AllProductModel data;
  Axis scrollDirection;
  var aspectRatio;
  var crossAxisCount;
  var gridBoxSize;
  double crossAxisSpacing;
  double mainAxisSpacing;


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final _isfavorite = ref.watch(isFavorite);

    return SingleChildScrollView(
      child: Container(
        height: (crossAxisCount == 1)
            ? MediaQuery.of(context).size.height * 0.38
            : null,
        width: (crossAxisCount == 1) ? MediaQuery.of(context).size.width : null,
        child: Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
            ),
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      crossAxisCount == 1
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8,),
                              child: Row(
                                children: [
                                  Text(
                                    header,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: TextSize.boxTitleSize),
                                  ),
                                  Spacer(),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "view all >",
                                        style: TextStyle(
                                          fontSize: TextSize.boxTitleSize,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.textButtonColor),
                                      ))
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: gridBoxSize,
                        child: GridView.builder(
                            shrinkWrap: true,
                            scrollDirection: scrollDirection,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    childAspectRatio: aspectRatio,
                                    crossAxisSpacing: crossAxisSpacing,
                                    mainAxisSpacing: mainAxisSpacing),
                            itemCount: data.data.productList.length??0,
                            itemBuilder: (BuildContext context, int index) {
                              var msg;
                              NetworkImage _networkImage = NetworkImage(
                                  data.data.productList![index].productImage??"");
                              return InkWell(
                                onTap: () async {
                                  var _productId = data
                                      .data.productList![index].productId
                                      .toString();
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
                                                        image: _networkImage,
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
                                                        data
                                                            .data
                                                            .productList![index]
                                                            .productName,
                                                        style: TextStyle(

                                                            fontSize: TextSize
                                                                .boxSubTitleSize),
                                                      ),
                                                      Text(
                                                        data
                                                            .data
                                                            .productList![index]
                                                            .categoryName
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
                                                            "₹${data.data.productList![index].productDiscount}  ",
                                                            style: TextStyle(
                                                              fontSize: TextSize.boxSubTitleSize,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Text(
                                                            "₹${data.data.productList![index].productPrice}",
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
                              );
                            }),
                      )
                    ],
                  ),
                  //
                ),
              ],
            )),
      ),
    );
  }
}
