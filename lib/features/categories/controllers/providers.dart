import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nithitex/features/categories/models/Profile_data_model.dart';
import 'package:nithitex/features/categories/models/add_wish-list.dart';
import 'package:nithitex/features/categories/models/all_products_model.dart';
import 'package:nithitex/features/categories/models/cart_list_model.dart';
import 'package:nithitex/features/categories/models/categories_model.dart';
import 'package:nithitex/features/categories/models/wish_list_model.dart';
import 'package:nithitex/features/categories/repositories/add_wish_list_call.dart';
import 'package:nithitex/features/categories/repositories/cart_list_call.dart';
import 'package:nithitex/features/categories/repositories/delete_cart_item_call.dart';
import 'package:nithitex/features/categories/repositories/wish_list_call.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_model.dart';
import '../repositories/add_cart_list_call.dart';
import '../repositories/all_product_call.dart';
import '../repositories/categories_call.dart';
import '../repositories/categories_call.dart';
import '../repositories/login_call.dart';
import '../repositories/profile_data_call.dart';
import '../views/screens/login_page.dart';
final loginOrLogoutProvider =StateProvider<bool>((ref) => true);
final moveToProfilePage =StateProvider<bool>((ref) => false);
final registerPageCheckbox =StateProvider<bool>((ref) => false);
final isFavorite =StateProvider<bool>((ref) => true);
final isEditor =StateProvider<bool>((ref) => false);
final dataEditor =StateProvider<bool>((ref) => false);
final totListProvider =StateProvider<List>((ref) => []);

final zoomImage =StateProvider<bool>((ref) => false);
final zoomBottomSheet =StateProvider<bool>((ref) => false);
final cartNoItemsProvider =StateProvider<int>((ref) => 1);


final userProvider= Provider<ApiServices>((ref)=>ApiServices());
final userDataProvider  = FutureProvider<Future<LoginModel>>((ref) async {
return ref.watch(userProvider).loginUser(contUserName.text, contPassword.text);});


final categoryProvider= Provider<ApiServicesCatagories>((ref)=>ApiServicesCatagories());
final categoryDataProvider  = FutureProvider<Future<Categories>>((ref) async {
  return ref.watch(categoryProvider).categoryData();});



final allProductProviderOne= Provider<AllProductApiServices>((ref)=>AllProductApiServices());
 final allProductDataProviderOne  = FutureProvider<AllProductModel>((ref) async {
   return ref.watch(allProductProviderOne).getAllProductList(0);});


final allProductProviderTwo= Provider<AllProductApiServices>((ref)=>AllProductApiServices());
 final allProductDataProviderTwo  = FutureProvider<AllProductModel>((ref) async {
   return ref.watch(allProductProviderTwo).getAllProductList(1);});


final allProductProviderThree= Provider<AllProductApiServices>((ref)=>AllProductApiServices());
 final allProductDataProviderThree  = FutureProvider<AllProductModel>((ref) async {
   return ref.watch(allProductProviderThree).getAllProductList(2);});


final allProductProviderFour= Provider<AllProductApiServices>((ref)=>AllProductApiServices());
 final allProductDataProviderFour  = FutureProvider<AllProductModel>((ref) async {
   return ref.watch(allProductProviderFour).getAllProductList(3);});


final allProductProviderFive= Provider<AllProductApiServices>((ref)=>AllProductApiServices());
 final allProductDataProviderFive  = FutureProvider<AllProductModel>((ref) async {
   return ref.watch(allProductProviderFive).getAllProductList(4);});

final addWishListCallProvider= Provider<AddWishListCall>((ref)=>AddWishListCall());
 // final addWishListCallDataProvider = FutureProvider<AddWishListModel>((ref) async {
 //   return ref.watch(addWishListCallProvider).getAddWishListCall(null, token);});

final addCartListCallProvider= Provider<AddCartListCall>((ref)=>AddCartListCall());
 // final addWishListCallDataProvider = FutureProvider<AddWishListModel>((ref) async {
 //   return ref.watch(addWishListCallProvider).getAddWishListCall(null, token);});

// final wishListCallProvider= Provider<WishListCall>((ref)=>WishListCall());
//  final wishListCallDataProvider  = FutureProvider<WishListModel>((ref) async {
//    WidgetsFlutterBinding.ensureInitialized();
//    final SharedPreferences prefs =await SharedPreferences.getInstance() ;
//    Object? data =prefs.get("token");
//    return ref.watch(wishListCallProvider).getWishListCall( data);});


final profileDataApiProvider= Provider<ProfileDataApi>((ref)=>ProfileDataApi());
 final profileDataApiDataProvider  = FutureProvider<UserProfileModel>((ref) async {
   WidgetsFlutterBinding.ensureInitialized();
   final SharedPreferences prefs =await SharedPreferences.getInstance() ;
   Object? data =prefs.get("token");
   return ref.watch(profileDataApiProvider).keepLoginUser(data);});


final cartListCallProvider= Provider<CartListCall>((ref)=>CartListCall());
 final cartListCallDataProvider  = FutureProvider<CartListModel>((ref) async {
   WidgetsFlutterBinding.ensureInitialized();
   final SharedPreferences prefs =await SharedPreferences.getInstance() ;
   Object? data =prefs.get("token");
   return ref.watch(cartListCallProvider).getCartListCall();});



final cartDelListCallProvider= Provider<DelCartListCall>((ref)=>DelCartListCall());

