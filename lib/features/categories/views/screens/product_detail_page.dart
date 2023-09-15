import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nithitex/config/constants/sizes/widgetsize.dart';
import 'package:nithitex/features/categories/controllers/add_cart_provider.dart';
import 'package:nithitex/features/categories/controllers/product_detail_provider.dart';
import 'package:nithitex/features/categories/controllers/providers.dart';
import 'package:nithitex/features/categories/controllers/wishlist_provider.dart';
import 'package:nithitex/features/categories/models/product_detail_model.dart';
import 'package:nithitex/features/categories/repositories/cart_list_call.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/constants/colors/colors.dart';
import '../../../../config/constants/sizes/textsize.dart';
import '../../repositories/add_cart_list_call.dart';
import '../../repositories/add_wish_list_call.dart';

class ProductDetailPage extends ConsumerWidget {
   ProductDetailPage({super.key, required  this.productId});
  var productId;
int noOfItems=1;

@override
  Widget build(BuildContext context,WidgetRef ref) {

  final _noOfItems=ref.watch(cartNoItemsProvider);
    var _zoom= ref.watch(zoomImage);
    final productDetail =  ref.watch(
        productDetailProvider
            .call(productId)
            );
    return productDetail.when(
        data: (list){
           return  Container(
             color: AppColor.topBackgroundColor,
             child: Scaffold(
               backgroundColor: Colors.white54,
               bottomSheet: BottomSheet(
                 backgroundColor: Colors.white,
                 shape: RoundedRectangleBorder(borderRadius:
                 BorderRadius.circular(12)
                 ),
                 onClosing: () {  },
                 builder: (BuildContext context) {
                   return  SizedBox(
                     height: 60,
                     child: Padding(
                       padding: const EdgeInsets.only(left: 8.0),
                       child: Flex(

                         direction: Axis.horizontal,
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: ElevatedButton(
                                 style: ButtonStyle(
                                   backgroundColor: MaterialStateColor.resolveWith((states) =>  Colors.red),
                                 ),
                                 onPressed: (){},
                                 child:const Text("Buy",
                                   style: TextStyle(
                                       color: AppColor.buttonColor,
                                       fontSize: TextSize.boxTitleSize
                                   ),)
                             ),
                           ),
                           InkWell(
                               onTap: (){
                                 _noOfItems>0 ?ref.watch(cartNoItemsProvider.notifier).update((state) => _noOfItems-1):null;
                               },
                               child: Container(

                                   decoration: const BoxDecoration(
                                       color: AppColor
                                           .textButtonColor,
                                       borderRadius:
                                       BorderRadius.all(
                                           Radius.circular(
                                               5))),
                                   child: const Icon(
                                     Icons.horizontal_rule,
                                     color: AppColor.buttonColor,
                                   ))),
                           Padding(
                             padding: const EdgeInsets.only(
                                 left: 8.0, right: 8),
                             child: Container(
                              width: 25,
                                 decoration: BoxDecoration(
                                     color: AppColor.boarderColor,
                                     borderRadius:
                                     BorderRadius.all(
                                         Radius.circular(5))),
                                 child: Padding(
                                   padding:
                                   const EdgeInsets.all(4),
                                   child: Text(
                                     "${_noOfItems}",textAlign: TextAlign.center,
                                   ),
                                 )),
                           ),
                           InkWell(
                             onTap: (){
                             ref.watch(cartNoItemsProvider.notifier).update((state) => _noOfItems+1);
                             },

                               child: Container(
                                   decoration: BoxDecoration(
                                       color: AppColor
                                           .textButtonColor,
                                       borderRadius:
                                       BorderRadius.all(
                                           Radius.circular(
                                               5))),
                                   child: Icon(
                                     Icons.add,
                                     color: AppColor.buttonColor,
                                   ))),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: ElevatedButton(
                                 style: ButtonStyle(
                                   backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red),
                                 ),
                                 onPressed: () async {
                                   var _productId = list.data.product[0].id.toString();
                                    var _cart= await  AddCartListCall().getAddCartListCall(_productId, _noOfItems);
                                   final _refresh= ref.refresh(productDetailProvider(_productId).future);

                                 },
                                 child:Text( list.data.product[0].cart?"Added to cart":"Add to Cart",
                                   style: TextStyle(
                                       color: AppColor.buttonColor,
                                       fontSize: TextSize.boxTitleSize
                                   ),)
                             ),
                           )
                         ],
                       ),
                     ),
                   );
                 },

               ),
               body: SafeArea(
                 child: Padding(
                   padding: const EdgeInsets.fromLTRB(8,8,8,30),
                   child: SingleChildScrollView(

                     child: Stack(
                       children: [
                         Column(
                           children: [
                             InkWell(
                               onDoubleTap: (){
                                 _zoom?ref.read(zoomImage.notifier).update((state) => false):
                                 ref.read(zoomImage.notifier).update((state) => true);
                               },
                               child: Center(
                                 child: AnimatedContainer(
                                   height:_zoom?MediaQuery.of(context).size.height*0.8: MediaQuery.of(context).size.width,
                                   width:_zoom?MediaQuery.of(context).size.width: MediaQuery.of(context).size.width*0.7,
                                   duration: Duration(seconds:1),
                                   curve:Curves.fastOutSlowIn,

                                   child: Container(

                                     decoration: BoxDecoration(
                                         image: DecorationImage(

                                             image: NetworkImage(list.data.product[0].productImage,),
                                             fit: BoxFit.cover),

                                         borderRadius: BorderRadius.all(Radius.circular(12))
                                     ),


                                   ),
                                 ),
                               ),
                             ),


                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Container(
                                 width: MediaQuery.of(context).size.width*0.1,
                                 height: 5,
                                 decoration: BoxDecoration(
                                     color:AppColor.boarderColor,
                                     borderRadius: BorderRadius.circular(20)
                                 ),
                               ),
                             ),
                             Ink(
                               decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.circular(20)
                               ),
                               child: Padding(
                                 padding: const EdgeInsets.all(15.0),
                                 child: Column(
                                   children: [
                                     Row(
                                       children: [
                                         Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Text(list.data.product[0].productName, style: TextStyle(fontWeight: FontWeight.w500
                                                 ,fontSize: TextSize.boxTitleSize),),
                                             Text(list.data.product[0].categoryName, style: TextStyle(fontWeight: FontWeight.w300
                                                 ,fontSize: TextSize.boxSubTitleSize
                                             ),),


                                           ],
                                         ), Spacer(),
                                         Padding(
                                           padding: const EdgeInsets.all(8.0),
                                           child: IconButton(
                                              onPressed: ()  async {
                                                 var _productId=list.data.product[0].id.toString();
                                                var _fav=await AddWishListCall().getAddWishListCall(_productId);
                                                 var _msg =_fav.message;
                                                final _refresh= ref.refresh(productDetailProvider(_productId).future);
                                                _refresh;
                                                 // ScaffoldMessenger.of( context).showSnackBar(
                                                 //     SnackBar(content: Container(
                                                 //         child: Text(
                                                 //             " ${_msg}"))));
                                                 // print(list.data.product[0].isFavourite);

                                               },
                                               icon:
                                               Icon(list.data.product[0].isFavourite==1?
                                               Icons.favorite:Icons.favorite_border_outlined,
                                                 color: Colors.red,
                                               )
                                           ),
                                         ),
                                       ],
                                     ),
                                     Row(
                                       children: [
                                         Padding(
                                           padding: const EdgeInsets.fromLTRB(0,8,8,8.0),
                                           child: Text("₹${list.data.product[0].productDiscount}",
                                             style: TextStyle(fontWeight: FontWeight.w500 ),
                                           ),
                                         ),
                                         Text("₹${list.data.product[0].productPrice}",style: TextStyle(
                                             decoration: TextDecoration.lineThrough,
                                             color: Colors.grey
                                         ),),
                                       ],
                                     ),
                                     Row(children: [
                                       Padding(
                                         padding: const EdgeInsets.fromLTRB(0,8,8,0),
                                         child: Text("Discount",
                                           style: TextStyle(fontWeight: FontWeight.w500 ),
                                         ),

                                       ),Spacer(),
                                       Padding(
                                         padding: const EdgeInsets.fromLTRB(0,8,8,0),
                                         child: Text("Color",
                                           style: TextStyle(fontWeight: FontWeight.w500 ),
                                         ),
                                       ),
                                     ],),
                                     Padding(
                                       padding: const EdgeInsets.only(left: 8.0,right: 8),
                                       child: Row(
                                         children: [
                                           Text("${list.data.product[0].discountPercentage} %", style: TextStyle(
                                               fontSize: TextSize.boxTitleSize),),
                                           Spacer(),
                                           Text("${list.data.product[0].colorName ??"-"}")




                                         ],
                                       ),
                                     ),
                                     Row(children: [
                                       Padding(
                                         padding: const EdgeInsets.fromLTRB(0,8,8,0),
                                         child: Text("productSku",
                                           style: TextStyle(fontWeight: FontWeight.w500 ),
                                         ),

                                       ),Spacer(),
                                       Padding(
                                         padding: const EdgeInsets.fromLTRB(0,8,8,0),
                                         child: Text("Avilable Stock",
                                           style: TextStyle(fontWeight: FontWeight.w500 ),
                                         ),
                                       ),
                                     ],),
                                     Padding(
                                       padding: const EdgeInsets.only(left: 8.0,right: 30),
                                       child: Row(
                                         children: [
                                           Text("${list.data.product[0].productSku}", style: TextStyle(
                                               fontSize: TextSize.boxTitleSize),),
                                           Spacer(),
                                           CircleAvatar(
                                             radius: 13,
                                               backgroundColor: AppColor.boarderColor,
                                               child: Text("${list.data.product[0].currentStock??""}",
                                                 style: TextStyle(
                                                     fontSize: TextSize.boxTitleSize),)
                                           )
                                         ],
                                       ),
                                     ),
                                     Align(
                                       alignment: Alignment.centerLeft,
                                       child: Text("Description :",
                                         style: TextStyle(fontWeight: FontWeight.w500 ),
                                       ),
                                     ),
                                     Text(list.data.product[0].shortDescription, style: TextStyle(fontWeight: FontWeight.w300
                                         ,fontSize: TextSize.boxSubTitleSize
                                     ),),
                                   ],
                                 ),
                               ),
                             ),
                           ],
                         ),
                         Ink(
                           child: IconButton(onPressed: (){
                             ref.watch(cartNoItemsProvider.notifier).update((state) => 1);
                             Navigator.pop(context);
                           }, icon: Icon(Icons.arrow_back)),
                         )
                       ],
                     ),
                   ),
                 ),
               ),
             ),
           );
        },
        error: (error,err){
          return
          Text("Something went wrong");
        },
        loading: (){
          return CircularProgressIndicator();
        });


  }
}
