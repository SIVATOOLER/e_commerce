import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nithitex/features/categories/views/screens/login_page.dart';
import 'package:nithitex/features/categories/views/screens/registeration_page.dart';

import '../../../../config/constants/colors/colors.dart';
import '../../../../config/constants/sizes/textsize.dart';
import '../../../../config/constants/sizes/widgetsize.dart';

class SigninOrSignupPage extends ConsumerWidget {
  const SigninOrSignupPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    return  Ink(
      color: Colors.white30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    "Welcome to Amazone",
                    style: TextStyle(
                        color: AppColor.textColor,
                        fontSize: TextSize.titleSize+5,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: const Center(
                    child: Text(
                      " Please login or Register to continue",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.textColor,
                        fontSize: TextSize.titleSize,

                      ),
                    ),
                  ),
                ),const Center(
                  child: Text(
                    " &\nDiscover new items",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: TextSize.titleSize,

                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8,8,8,8),
            child: Container(
              height: WidgetSize.buttonHeight,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation:  10,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      backgroundColor: AppColor.buttonColor),
                  onPressed: () {
                     {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => LoginPage())));
                    } ;
                  },
                  child: Row(
                    children: [
                      Spacer(),
                      Text("    Log In",style: TextStyle(color: AppColor.titleColor),),
                      Spacer(),
                      Icon(Icons.arrow_forward,color: AppColor.titleColor,)
                    ],
                  )),

            ),
          ),
          Text("or"),
          Padding(
            padding: const EdgeInsets.fromLTRB(8,8,8,8),
            child: Container(
              height: WidgetSize.buttonHeight,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation:  10,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      backgroundColor: AppColor.buttonColor),
                  onPressed: () {
                     {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => RegisterationPage())));
                    } ;
                  },
                  child: Row(
                    children: [
                      Spacer(),
                      Text("    Register",style: TextStyle(color: AppColor.titleColor),),
                      Spacer(),
                      Icon(Icons.arrow_forward,color: AppColor.titleColor,)
                    ],
                  )),

            ),
          ),
        ],
      ),
    );
  }
}
