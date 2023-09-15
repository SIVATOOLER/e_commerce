import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nithitex/config/constants/sizes/textsize.dart';
import 'package:nithitex/features/categories/models/all_products_model.dart';
import 'package:nithitex/features/categories/views/screens/product_detail_page.dart';
import 'package:pagination_view/pagination_view.dart';

import '../../../../config/constants/colors/colors.dart';
import '../../../../config/constants/sizes/widgetsize.dart';
import '../../controllers/product_detail_provider.dart';
import '../../controllers/search_provider.dart';

class ListWidgetPage extends ConsumerWidget {
   ListWidgetPage({super.key,required this.id});
var id;
   ScrollController _scrollController=ScrollController();
   List<ProductList> totList =[];
   int i=0;

   @override
   Widget build(BuildContext context,WidgetRef ref) {
     final _data= ref.watch(searchlistProvider("productsbycategory/${id}?page=$i"));

     return
       Scaffold(
         backgroundColor: AppColor.bottomBackgroundColor,

         body: _data.when(

             data:(l) {

               totList.addAll(_data.value!.data.productList)

               ;
               _scrollListener() async {
                 if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
                     !_scrollController.position.outOfRange) {


                   var _dataList;
                   i<_data.value!.lastPage? {i = i + 1,
                     _dataList=await ref.watch(searchlistProvider("productsbycategory/${id}?page=$i")),
                     totList.addAll(_dataList.value!.data.productList)
                   } :null;



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

           return    Scaffold(
             backgroundColor: Colors.transparent,
             appBar: AppBar(
             backgroundColor: Colors.transparent,
             title: Text(_data.value!.data.productList[0].categoryName),
           ),
             body: GridView.builder(
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
                 ),
           );
             },
             error: (error,err){
               Text("Something went wrong");
             },
             loading: (){
               return Center(child: CircularProgressIndicator());
             })
       );
  }
}
