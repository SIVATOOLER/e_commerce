import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nithitex/config/constants/colors/colors.dart';
import 'package:nithitex/config/constants/sizes/textsize.dart';
import 'package:nithitex/features/categories/controllers/order_list_provider.dart';
import 'package:nithitex/features/categories/controllers/providers.dart';
import 'package:nithitex/features/categories/views/screens/order_detail_page.dart';

import '../../models/order_detail_model.dart';
import '../../repositories/order_detail_call.dart';


class OrderListPage extends ConsumerWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
   final _data= ref.watch(orderListProvider("order/list"));
   final _zoom= ref.watch(zoomImage);
    return  Scaffold(
      backgroundColor: AppColor.bottomBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Your Order"),
      ),
      body: _data.when(data: (list){
      return  Stack(
        children: [
          GridView.builder(
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 5 / 2.5,
                  crossAxisSpacing: 10
                ),
                itemCount: list.data!.orders!.length,
                itemBuilder: (BuildContext context, int index) {
                 return InkWell(
                   onTap: () async {
                        var _orderId=list.data!.orders![index].orderId;

                        final orderDataProvider =
                        FutureProvider.family<OrderDetailModel, String>(
                              (ref, search) async =>
                          await OrderDetailCall().getData("order/details/$_orderId"),

                        );
                        final  _data=await ref.read(orderDataProvider("order/details/$_orderId").future);

                        Navigator.push(
                         context,
                         MaterialPageRoute(
                             builder: ((context) => OrderDetailsPage(data: _data.data))));
                   },
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                     decoration:  BoxDecoration(

                           color: Colors.white,

                           borderRadius:
                           BorderRadius.circular(
                               15)),

                       child:Stack(
                         children: [
                           ListTile(
                             trailing:CircleAvatar(

                                 child: Text(list.data!.orders![index].qty.toString(),)) ,
                             title: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text("Order no: ${list.data!.orders![index].orderId.toString()}"
                                 ,style: TextStyle(
                                     fontSize: TextSize.boxTitleSize,
                                     color: AppColor.textColor
                                   ),
                                 ),
                                 Text("Order no: ${list.data!.orders![index].orderNumber.toString()}",
                              style: TextStyle(
                              fontSize: TextSize.boxTitleSize,
                              color: AppColor.textColor
                              ),),
                                 Text("Status: ${list.data!.orders![index].status.toString()}",
                                   style: TextStyle(
                                       fontSize: TextSize.boxTitleSize,
                                       color: AppColor.textColor
                                   ),
                                 ),
                                 Text("paymentStatus: ${list.data!.orders![index].paymentStatus.toString()}",
                                   style: TextStyle(
                                       fontSize: TextSize.boxTitleSize,
                                       color: AppColor.textColor
                                   ),
                                 ),
                               ],
                             ),

                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Align(
                                 alignment: Alignment.topRight,
                                 child: Text(" ${list.data!.orders![index].orderDate.toString()}",

                                   style: TextStyle(
                                       fontSize: TextSize.boxTitleSize,
                                       color: AppColor.textColor
                                   ),)),
                           ), Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Align(
                                 alignment: Alignment.bottomRight,
                                 child: Text(" ${list.data!.orders![index].paymentType.toString()}",
                                   style: TextStyle(
                                       fontSize: TextSize.boxTitleSize,
                                       color: AppColor.textColor
                                   ),
                                 )),
                           )
                         ],
                       )
                     ),
                   ),
                 ) ;
                }
            ),
          _zoom?  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(

              children: [
                Container(
                  
                  height: MediaQuery.of(context).size.height*0.8,
                  width: MediaQuery.of(context).size.height*0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                  ),
                  child: RichText(
                      text: TextSpan(
                          text: "order date: ",style: TextStyle(
                          color: AppColor.textColor
                      ),
                          children: [
                            TextSpan(
                                text:  "${"data"}",style: TextStyle(
                                color: AppColor.textButtonColor,
                                fontWeight: FontWeight.w500
                            )
                            )
                          ]
                      )
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: (){
                        ref.read(zoomImage.notifier).update((state) => false);
                      },
                      icon: Icon(Icons.clear)),
                ),
              ],
            ),
          ):Container()
        ],
      );
      },
          error: (error,err){
            Center(child: Text("Something went wrong"));
          },
          loading: (){
            return Center(child: CircularProgressIndicator());
          })

    );
  }
}
