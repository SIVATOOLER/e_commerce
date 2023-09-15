import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nithitex/features/categories/controllers/search_provider.dart';
import 'package:nithitex/features/categories/models/all_products_model.dart';
import 'package:nithitex/features/categories/repositories/search_item_call.dart';
import 'package:nithitex/features/categories/views/screens/profile_page.dart';
import 'package:nithitex/features/categories/views/screens/search_page.dart';
import 'package:nithitex/utils/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import '../../../../config/constants/colors/colors.dart';
import '../../controllers/providers.dart';
import '../../models/login_model.dart';
import '../../repositories/cart_list_call.dart';
import '../../repositories/delete_cart_item_call.dart';
import '../../repositories/login_call.dart';
import 'cart_page.dart';
import 'home_page.dart';
import 'menu_page.dart';
import 'shop_page.dart';

final bottomAppbarProvider = StateProvider<int>((ref) => 0);

class MainScreen extends ConsumerWidget {
  MainScreen({super.key});

  TextEditingController searchControl = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var Inum = ref.watch(bottomAppbarProvider);

    var screenHeight = MediaQuery.of(context).size.height;

    pageMove(int num) {
      ref.read(bottomAppbarProvider.notifier).update((state) => num);
    }


    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          AppColor.topBackgroundColor,
          AppColor.bottomBackgroundColor
        ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: Inum != 1
              ? AppBar(
                  backgroundColor: Colors.transparent,
                  title: SizedBox(
                    height: screenHeight * 0.05,
                    child: TextFormField(
                        autofocus: false,
                      readOnly: true,
                      showCursor: false,
                      controller: searchControl,
                      onTap: ()  {


                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => SearchPage())));
                      
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 2.0),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search Amazone.in",
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                )
              : null,
          bottomNavigationBar: TitledBottomNavigationBar(
              indicatorColor: AppColor.bottomBarIconColor,
              indicatorHeight: 5,
              currentIndex: Inum,

              // Use this to update the Bar giving a position
              onTap: (index) async {
                pageMove(index);

                index == 1
                    ? SharedPrefs.getUserToken == null
                        ? ref
                            .read(loginOrLogoutProvider.notifier)
                            .update((state) => true)
                        : {
                            ref
                                .read(loginOrLogoutProvider.notifier)
                                .update((state) => false),
                          }
                    : null;

                index == 3 ? ref.refresh(cartListCallDataProvider) : null;
              },
              items: [
                TitledNavigationBarItem(
                    title: Text('Home'),
                    icon: Icon(
                      Icons.home_outlined,
                      color: AppColor.bottomBarIconColor,
                    )),
                TitledNavigationBarItem(
                    title: Text('Profile'),
                    icon: Icon(
                      Icons.person_2_outlined,
                      color: AppColor.bottomBarIconColor,
                    )),
                TitledNavigationBarItem(
                    title: Text('Shop'),
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      color: AppColor.bottomBarIconColor,
                    )),
                TitledNavigationBarItem(
                    title: Text('Cart'),
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: AppColor.bottomBarIconColor,
                    )),
                TitledNavigationBarItem(
                    title: Text('Menu'),
                    icon: Icon(
                      Icons.menu,
                      color: AppColor.bottomBarIconColor,
                    )),
              ]),
          body: Container(
            height: MediaQuery.of(context).size.height ,
            child: Stack(
              children: [
                SafeArea(
                    child: (Inum == 0)
                        ? HomePage()
                        : (Inum == 1)
                            ? ProfilePage()
                            : (Inum == 2)
                                ? OptionPage()
                                : (Inum == 3)
                                    ? CartPage()
                                    : MenuPage()),
              ],
            ),
          ),
        ));
  }
}
