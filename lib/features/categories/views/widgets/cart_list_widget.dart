import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nithitex/config/constants/colors/colors.dart';
import 'package:nithitex/features/categories/models/del_cart_List_item-model.dart';
import 'package:nithitex/features/categories/models/wish_list_model.dart';
import 'package:nithitex/features/categories/repositories/delete_cart_item_call.dart';
import 'package:nithitex/features/categories/views/screens/favorite_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/constants/sizes/textsize.dart';
import '../../controllers/product_detail_provider.dart';
import '../../controllers/providers.dart';
import '../../models/add_wish-list.dart';
import '../../repositories/add_cart_list_call.dart';
import '../../repositories/add_wish_list_call.dart';
import '../../repositories/checkout_call.dart';
import '../../repositories/wish_list_call.dart';
import '../screens/product_detail_page.dart';
import 'list_widget.dart';

class CartListWidget extends ConsumerWidget {
  CartListWidget({
    super.key,
  });

  AddWishListModel? favfav;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataCart = ref.watch(cartListCallDataProvider);
    final _noOfItems=ref.watch(cartNoItemsProvider);
    final _DataEditor=ref.watch(dataEditor);

    TextEditingController nController = TextEditingController();
    TextEditingController phController = TextEditingController();
    TextEditingController pcController = TextEditingController();
    TextEditingController dController = TextEditingController();
    TextEditingController strController = TextEditingController();
    TextEditingController cController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController sController = TextEditingController();
    TextEditingController aPhController = TextEditingController();


    changeFun() async {

    }


    _TextField(String hint,TextEditingController controller){
      return  TextFormField(
        controller: controller,
        validator: (value) {

          if (value == null || value!.trim().isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
           prefixText: "  ",
           contentPadding: EdgeInsets.symmetric(vertical: 10.0),

            filled: true,
            // errorBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(10.0),
            // ),
            // enabledBorder: UnderlineInputBorder(
            // borderSide: BorderSide.none,
            //   borderRadius: new BorderRadius.circular(10.0),
            // ),
            // focusedBorder: OutlineInputBorder(
            //   borderSide:BorderSide.none,
            //   borderRadius: BorderRadius.circular(10.0),
            // ),

            fillColor: AppColor.textFieldColor,
            hintStyle: TextStyle(color: AppColor.textColor,
            fontSize: TextSize.boxTitleSize),
            hintText: "${hint}"),
      );
    }
    return SingleChildScrollView(
      child: dataCart.when(
          data: (data) {
            return Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height*0.74,
                      child: ListView.builder(
                          itemCount: data.data!.cart!.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Ink(
                                color: Colors.white70,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      var _productId = data
                                          .data.cart[index]!.productId
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
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height * 0.15,
                                        width:
                                        MediaQuery.of(context).size.height * 0.15,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    data.data.cart[index].image),
                                                fit: BoxFit.contain),
                                            color: AppColor.boarderColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    //direction: Axis.vertical,
                                    children: [
                                      Text(
                                        data.data.cart[index].name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: TextSize.boxTitleSize),
                                      ),
                                      Text(
                                        "Avl.qty : ${data.data.cart[index].availableQuantity}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: TextSize.boxSubTitleSize),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 8, 8, 8.0),
                                            child: Text(
                                              "₹${data.data.cart[index].productDiscount}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Text(
                                            "₹${data.data.cart[index].productPrice}",
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                        child: Flex(
                                          direction: Axis.horizontal,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                var _cartId = data.data.cart[index].cartId;
                                                var _cart= await  AddCartListCall().getAddCartListCall("decrease/$_cartId", _noOfItems-1);
                                                ref.refresh(cartListCallDataProvider);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                    content:
                                                    Text("${_cart.msg??_cart.error}")));
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
                                                      data.data.cart[index].qty ,textAlign: TextAlign.center,
                                                    ),
                                                  )),
                                            ),
                                            InkWell(
                                             onTap: () async {
                                               var _cartId = data.data.cart[index].cartId;
                                               var _cart= await  AddCartListCall().getAddCartListCall("increase/$_cartId", _noOfItems+1);
                                               ref.refresh(cartListCallDataProvider);
                                               ScaffoldMessenger.of(context)
                                                   .showSnackBar(SnackBar(
                                                   content:
                                                   Text("${_cart.msg??_cart.error}")));

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
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () async {
                                        var cartId = data.data.cart[index].cartId
                                            .toString();
                                        var productId = data
                                            .data.cart[index].productId
                                            .toString();

                                        // var _UpdatedCartList= ref.read(productIdCartList.notifier).update((state) => localCartList);

                                        final _cartDel = await DelCartListCall()
                                            .getDelCartListCall(cartId);
                                        var _IsDel = _cartDel;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text("${_cartDel.message}")));

                                        ref.refresh(cartListCallDataProvider);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: AppColor.textButtonColor,
                                      ))
                                ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Container(
                      color: Colors.transparent,
                      height:  MediaQuery.of(context).size.height*0.07
                      ,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: RichText(
                                text: TextSpan(
                                    text: "Qty: ",style: TextStyle(
                                    color: AppColor.textColor
                                ),
                                    children: [
                                      TextSpan(
                                          text:  "${data.quantity}",style: TextStyle(
                                          color: AppColor.textButtonColor,
                                          fontWeight: FontWeight.w500
                                      )
                                      )
                                    ]
                                )
                            ),
                          ) , RichText(
                              text: TextSpan(
                                  text: "Total:₹ ",style: TextStyle(
                                  color: AppColor.textColor
                              ),
                                  children: [
                                    TextSpan(
                                        text: "${data.total}",style: TextStyle(
                                        color: AppColor.textButtonColor,
                                        fontWeight: FontWeight.w500
                                    )
                                    )
                                  ]
                              )
                          ) ,
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateColor.resolveWith((states) =>
                                  data.data.cart.isEmpty?AppColor.boarderColor:Colors.red),
                                ),
                                onPressed: (){
                                  data.data.cart.isEmpty?null:  ref.read(dataEditor.notifier).update((state) => true);
                                //  CheckoutCall().getData("place/order/v1");
                                },
                                child: Text("Checkout",
                                  style: TextStyle(
                                      color:AppColor.buttonColor,
                                      fontSize: TextSize.boxTitleSize
                                  ),)
                            ),
                          ),
                        ],),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: AnimatedContainer(
                      height:  _DataEditor?MediaQuery.of(context).size.height*0.5:0,
                      curve: Curves.linear,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      duration: Duration(microseconds:500),
                      child:Column(children: [
                        Row(

                          children: [
                            Text("  Enter Your Data",style:
                            TextStyle(color: AppColor.textColor,
                                fontWeight: FontWeight.bold),),

                            Spacer(),IconButton(onPressed: (){
                              ref.refresh(profileDataApiDataProvider);
                              ref.read(dataEditor.notifier).update((state) => false);
                            }, icon: Icon(Icons.clear)),
                          ],),
                        Container(
                          height: MediaQuery.of(context).size.height*0.37,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8,12,8,12),
                            child: GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 7/2,crossAxisSpacing:20,
                              mainAxisSpacing: 20
                              ,
                            ),children: [
                              _TextField("Your Name", nController),
                              _TextField("E-mail", emailController),
                              _TextField("PhoneNo", phController),
                              _TextField("PinCode", pcController),
                              _TextField("DoorNo", dController),
                              _TextField("Street", strController),
                              _TextField("City", cController),
                              _TextField("State", sController),
                              _TextField("AlternatePh No", aPhController),




                            ],

                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                          var hasChanged=await CheckoutCall().getData(
                              "place/order/v1", dController.text, strController.text, cController.text,
                              sController.text, nController.text
                              , emailController.text, phController.text
                              , pcController.text,
                              aPhController.text,data.total);
                          ScaffoldMessenger.of( context).showSnackBar(
                              SnackBar(content: Text("${hasChanged.message??hasChanged.error!.errorInfo![2].toString()}")));
                          ref.refresh(cartListCallDataProvider);
                          ref.read(dataEditor.notifier).update((state) => false);
                        },
                            style: ElevatedButton.styleFrom(

                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                backgroundColor: AppColor.boarderColor),
                            child: Text("Place order",style: TextStyle(
                                color: AppColor.textColor
                            ),))
                      ],) ,
                    ),
                  ),
                )
              ],
            );
          },
          error: (error, err) {
            return Text("dataerror");
          },
          loading: () => CircularProgressIndicator()),
    );
  }
}
