import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nithitex/config/constants/colors/colors.dart';
import 'package:nithitex/features/categories/models/wish_list_model.dart';
import 'package:nithitex/features/categories/views/screens/favorite_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/constants/sizes/textsize.dart';
import '../../controllers/product_detail_provider.dart';
import '../../controllers/providers.dart';
import '../../controllers/wishlist_provider.dart';
import '../../models/add_wish-list.dart';
import '../../repositories/add_wish_list_call.dart';
import '../../repositories/wish_list_call.dart';
import '../screens/product_detail_page.dart';
import 'list_widget.dart';


class FavListWidget extends ConsumerWidget {
   FavListWidget({super.key,
   });


   AddWishListModel? favfav;
  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final dataFav = ref.watch(wishListProvider);
    final _isfavorite =ref.watch(isFavorite);
    bool _currentIndex =false;


    return dataFav.when(data: (data){
      return Container(

        child: ListView.builder(
            itemCount: data.data.productList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context,int index){
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
                  padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                  child: Ink(
                    color: Colors.white70,
                    child: InkWell(

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  height: MediaQuery.of(context).size.height*0.15,
                                  width:  MediaQuery.of(context).size.height*0.15,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(data.data.productList[index].productImage),
                                          fit: BoxFit.contain),
                                      color: AppColor.boarderColor,
                                      borderRadius: BorderRadius.all(Radius.circular(12))
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //direction: Axis.vertical,
                                children: [
                                  Text(data.data.productList[index].productName, style: TextStyle(fontWeight: FontWeight.bold
                                      ,fontSize: TextSize.boxTitleSize),),
                                  Text(data.data.productList[index].categoryName, style: TextStyle(fontWeight: FontWeight.w300
                                      ,fontSize: TextSize.boxSubTitleSize
                                  ),),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0,8,8,8.0),
                                        child: Text("₹${data.data.productList[index].productDiscount}",
                                          style: TextStyle(fontWeight: FontWeight.bold ),
                                        ),
                                      ),
                                      Text("₹${data.data.productList[index].productPrice}",style: TextStyle(
                                          decoration: TextDecoration.lineThrough,
                                          color: Colors.grey
                                      ),),
                                    ],
                                  ),
                                ],

                              ),Spacer(),
                              IconButton(
                                  onPressed: () async {

                                var productId=data.data.productList[index].productId.toString();
                               final  favfav=await AddWishListCall().getAddWishListCall(productId);
                                ScaffoldMessenger.of( context).showSnackBar(
                                     SnackBar(content: Text(
                                        "${favfav.message}"))) ;
                                _currentIndex;

                                ref.refresh(wishListProvider);

                              },isSelected:_currentIndex=true,
                                  icon:
                                  Icon(Icons.favorite,
                                    color: Colors.red,
                                  )
                              )

                            ],

                          ),
                        )
                    ),
                  ),
                ),
              );
            }),
      );
    },
        error: (error,err){
      return Center(child: Text("No Favorites Found "));
        },
        loading:() => CircularProgressIndicator());
  }
}