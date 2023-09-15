import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nithitex/features/categories/controllers/providers.dart';
import 'package:nithitex/features/categories/views/screens/product_detail_page.dart';

import '../../../../config/constants/colors/colors.dart';
import '../../../../config/constants/sizes/textsize.dart';
import '../../../../config/constants/sizes/widgetsize.dart';
import '../../controllers/order_list_provider.dart';
import '../../controllers/product_detail_provider.dart';
import '../../models/order_detail_model.dart';

class OrderDetailsPage extends ConsumerWidget {
   OrderDetailsPage({super.key , required this.data});
   Data? data;
  @override
  Widget build(BuildContext context,WidgetRef ref) {
   var _zoomBottomSheet =ref.watch(zoomBottomSheet);



  containerFun(hint,data,index){
    return   Align(
      alignment:index%2==0? Alignment.topRight:Alignment.topLeft,
      child: Container(
        height: MediaQuery.of(context).size.height*0.05,
        width: MediaQuery.of(context).size.width*0.5,
        decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: RichText(
              text: TextSpan(
                  text: "$hint : ",style: TextStyle(
                  color: AppColor.textColor
              ),
                  children: [
                    TextSpan(
                        text: "$data",style: TextStyle(
                        color: AppColor.textButtonColor,
                        fontWeight: FontWeight.w500
                    )
                    )
                  ]
              )
          ),
        ),
      ),
    );
  }
    return  Scaffold(
      bottomSheet:
      BottomSheet(onClosing: () {  },
        showDragHandle: true,
       onDragStart: (d){
      !_zoomBottomSheet? ref.read(zoomBottomSheet.notifier).update((state) => true):
       ref.read(zoomBottomSheet.notifier).update((state) => false);
       },

        builder: (BuildContext context) {
        return
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: AnimatedContainer(

            // curve: Curves.easeIn,
               height:_zoomBottomSheet? MediaQuery.of(context).size.height*0.3:0,
               duration: Duration(milliseconds: 0),
              child: GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio:5/3,


                  ),
                  itemCount: data!.ordersDetail!.length,
                  itemBuilder: (BuildContext context,index){
                    return InkWell(
                      onTap: () async {
                        var _productId = data!.ordersDetail![index].productId.toString();
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

                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage("${data!.ordersDetail![index].productImage}"),
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

                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${data!.ordersDetail![index].productName}",
                                                style: TextStyle(

                                                    fontSize: TextSize
                                                        .boxSubTitleSize),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Qty:${data!.ordersDetail![index].qty}",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w300,
                                                    fontSize: TextSize
                                                        .boxTitleSize-3,
                                                    overflow: TextOverflow
                                                        .ellipsis),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                 "₹${data!.ordersDetail![index].productPrice}",
                                                  style: TextStyle(
                                                      fontSize: TextSize.boxSubTitleSize,
                                                      fontWeight:
                                                      FontWeight
                                                          .w500),
                                                ),
                                                Text(
                                                  "",
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
            ),
          );
        },

      ),
        backgroundColor: AppColor.bottomBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Order Details"),
        ),
        body:Padding(
          padding:  EdgeInsets.only(bottom:_zoomBottomSheet? 250:50),
          child: GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 2.5/0.3,

          ),
            children: [
              containerFun("No of items",data!.ordersDetail!.length,1),
              containerFun("Delivery status",data!.orders![0].status,0),
              containerFun("Name",data!.orders![0].name,1),
              containerFun("Phone",data!.orders![0].phone,2),
              containerFun("Pincode ",data!.orders![0].pinCode,3),
              containerFun("Order number",data!.orders![0].orderNumber,4),
              containerFun("Order date",data!.orders![0].orderDate,5),
              containerFun("Payment type",data!.orders![0].paymentType,6),
              containerFun("payment Status",data!.orders![0].paymentStatus,7),
              containerFun("Amount",data!.orders![0].amount,8),
              containerFun("Shipping charge",data!.orders![0].shippingCharge,9),
              containerFun("Sub total",data!.orders![0].subTotal,10),
              containerFun("Margin amount",data!.orders![0].marginAmount,11),
              containerFun("Coupon discount",data!.orders![0].couponDiscount,12),
              containerFun("Referral discount",data!.orders![0].referralDiscount,13),
              containerFun("Transaction id",data!.orders![0].transactionId??"-",14),
              containerFun("Alternate phno",data!.orders![0].alternativeNumber,15),
              containerFun("Is cancelled",data!.orders![0].isCancelled=="0"?"No":"Yes",16),
              containerFun("Cancel date",data!.orders![0].cancelDate??"-",17),
              containerFun("Is returned",data!.orders![0].isReturned=="0"?"No":"Yes",18),
              containerFun("Return date",data!.orders![0].returnDate??"",19),
              containerFun("Return reason",data!.orders![0].returnReason??"",20),


            ],
          ),
        )
    );
  }

}
