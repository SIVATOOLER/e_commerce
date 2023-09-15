import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nithitex/config/constants/colors/colors.dart';
import 'package:nithitex/config/constants/sizes/textsize.dart';
import 'package:nithitex/config/constants/sizes/widgetsize.dart';
import 'package:nithitex/features/categories/models/login_model.dart';
import 'package:nithitex/features/categories/repositories/login_call.dart';
import 'package:nithitex/features/categories/views/screens/favorite_page.dart';
import 'package:nithitex/features/categories/views/screens/home_page.dart';
import 'package:nithitex/features/categories/views/screens/login_page.dart';
import 'package:nithitex/features/categories/views/screens/mainscreen.dart';
import 'package:nithitex/features/categories/views/screens/signin_or_signup_page.dart';
import 'package:nithitex/features/categories/views/screens/user_profile_page.dart';
import 'package:nithitex/utils/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/order_list_provider.dart';
import '../../controllers/providers.dart';
import '../../controllers/wishlist_provider.dart';
import '../../models/wish_list_model.dart';
import '../../repositories/wish_list_call.dart';
import 'order_list_page.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List _list = [
      "Favorite",
      "Your Orders",
      "About",
      "Account",
    ];
    List _aboutButtonList = ["About", "Terms & conditions","Contacts"];
    List _accountButtonList = ["Log Out", "Manage Account","Details"];

    bool _LoginOrLogoutProvider = ref.watch(loginOrLogoutProvider);

    Future<String> nameFun() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      Object? token = prefs.get("token");
      final String _name = await prefs.getString("name") ?? "";
      return _name;
    }

    final _user = ref.watch(userDataProvider);

    return _LoginOrLogoutProvider
        ? SigninOrSignupPage()
        : SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 20, 8, 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => UserProfilePage())));
                    },
                    child: Row(
                      children: [
                        Text(
                          "Hello, ",
                          style: TextStyle(
                            color: AppColor.textColor,
                            fontSize: TextSize.titleSize + 5,
                          ),
                        ),
                        Text(
                          "${SharedPrefs.getUserName}".toUpperCase(),

                          style: TextStyle(

                              color: AppColor.textColor,
                              fontSize: TextSize.titleSize + 5,
                              fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        CircleAvatar(
                          // radius: WidgetSize.circularAvatarRadius,
                          backgroundColor: AppColor.buttonColor,

                          child: Icon(
                            Icons.person_2_outlined,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          colors: [
                        Colors.transparent,
                        Colors.white10,
                        AppColor.profileBottomBackgroundColor
                      ])),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 5 / 2,
                          crossAxisSpacing: 10,
                          ),
                      itemCount: _list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TextButton(
                          onPressed: () async {
                            if (index == 0) {

                              ref.refresh(wishListProvider);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => FavoritePage())));
                            }
                            if(index==1){
                              ref.read(orderListProvider("order/list"));

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => OrderListPage())));
                            }
                            if(index==3){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => UserProfilePage())));
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColor.boarderColor),
                                  color: AppColor.buttonColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Center(
                                  child: Text(
                                _list[index],
                                style: TextStyle(
                                    color: AppColor.textColor,
                                    fontSize: TextSize.boxSubTitleSize),
                              ))),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    tileColor: AppColor.buttonColor,
                    title: Text(_list[0],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                            color: AppColor.textColor,
                            fontSize: TextSize.boxTitleSize
                        )),
                    subtitle: Column(
                      children: [
                        Text("See your favorite items"),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColor.boarderColor),
                                color: AppColor.buttonColor,
                                borderRadius: BorderRadius.circular(12)),
                            height: WidgetSize.buttonHeight,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  backgroundColor: AppColor.buttonColor),
                              onPressed: () async {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                Object? data = prefs.get("token");
                                ref.refresh(wishListProvider);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            FavoritePage())));
                              },
                              child: Text(
                                "Visit Favorites",
                                style: TextStyle(
                                    color: AppColor.textColor,
                                fontSize: TextSize.boxSubTitleSize
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    tileColor: AppColor.buttonColor,
                    title: Text(_list[1],
                        style: TextStyle(
                            color: AppColor.textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: TextSize.boxTitleSize)),
                    subtitle: Column(
                      children: [
                        Text("Hi You have no recent orders"),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColor.boarderColor),
                                color: AppColor.buttonColor,
                                borderRadius: BorderRadius.circular(12)),
                            height: WidgetSize.buttonHeight,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  backgroundColor: AppColor.buttonColor),
                              onPressed: () {
                                ref.refresh(bottomAppbarProvider);
                              },
                              child: Text(
                                "Return to the Home Page",
                                style: TextStyle(color: AppColor.textColor,
                                fontSize: TextSize.boxSubTitleSize),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    tileColor: AppColor.buttonColor,
                    title: Text(_list[2],
                        style: TextStyle(
                            color: AppColor.textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: TextSize.boxTitleSize)),
                    subtitle: SizedBox(
                      height: WidgetSize.buttonHeight,
                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,

                                  childAspectRatio: 2 / 5,
                                  mainAxisSpacing: 20),
                          scrollDirection: Axis.horizontal,
                          itemCount: _aboutButtonList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColor.boarderColor),
                                  color: AppColor.buttonColor,
                                  borderRadius: BorderRadius.circular(12)),
                              //height: WidgetSize.buttonHeight,
                              // width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    backgroundColor: AppColor.buttonColor),
                                onPressed: () {

                                },
                                child: Text(
                                  _aboutButtonList[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColor.textColor,
                                    fontSize: TextSize.boxSubTitleSize
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                ListTile(
                  tileColor: AppColor.buttonColor,
                  title: Text(_list[3],
                      style: TextStyle(
                          color: AppColor.textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: TextSize.boxTitleSize)),
                  subtitle: SizedBox(
                    height: WidgetSize.buttonHeight,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 2 / 5,
                            mainAxisSpacing: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: _accountButtonList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColor.boarderColor),
                                color: AppColor.buttonColor,
                                borderRadius: BorderRadius.circular(12)),
                            //height: WidgetSize.buttonHeight,
                            // width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  backgroundColor: AppColor.buttonColor),
                              onPressed: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                index == 0
                                    ? {
                                        ref
                                            .read(
                                                loginOrLogoutProvider.notifier)
                                            .update((state) => true),
                                        await prefs.remove("token"),
                                        await prefs.remove("userName"),
                                      }
                                    : null;
                              },
                              child: Text(
                                _accountButtonList[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColor.textColor,
                                  fontSize: TextSize.boxSubTitleSize
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          );
  }
}
