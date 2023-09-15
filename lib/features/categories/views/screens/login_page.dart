


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nithitex/config/constants/sizes/textsize.dart';
import 'package:nithitex/config/constants/sizes/widgetsize.dart';
import 'package:nithitex/features/categories/views/screens/mainscreen.dart';
import 'package:nithitex/features/categories/views/screens/registeration_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../config/constants/colors/colors.dart';
import '../../controllers/providers.dart';
import '../../models/login_model.dart';
import '../../repositories/login_call.dart';
TextEditingController contUserName = TextEditingController();

TextEditingController contPassword = TextEditingController();
final _formKey = GlobalKey<FormState>();
class LoginPage extends ConsumerWidget {
   LoginPage({super.key});

  bool value = false;





  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final _data= ref.watch(userDataProvider);
    final _MoveToProfilePage= ref.watch(moveToProfilePage);
    return GestureDetector(
      onTap:()=> FocusScope.of(context).unfocus(),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors:[ AppColor.topBackgroundColor,AppColor.bottomBackgroundColor])
        ),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text("Amazone"),
            ),
          backgroundColor: Colors.transparent,

            body: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                 SizedBox(
                   height: MediaQuery.of(context).size.height*0.1,
                 ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              "Welcome Back",
                              style: TextStyle(
                                  color: AppColor.textColor,
                                  fontSize: TextSize.titleSize+5,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),const Center(
                            child: Text(
                              " please login to continue",
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
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(" Mobile Number",style: TextStyle(color: AppColor.textColor))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(12)),
                        child: TextFormField(
                          onChanged: (jhh){
                            ref
                                .read(moveToProfilePage.notifier)
                                .update((state) => false);
                          },
                          controller: contUserName,
                          validator: (value) {
                            if (value == null || value!.trim().isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(25.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              filled: true,
                              fillColor: AppColor.textFieldColor,
                              prefixIcon: Icon(Icons.phone_android_outlined,color: AppColor.textColor),
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: AppColor.textColor),
                              hintText: " Place Your Mobile Number Here"),
                        ),
                      ),
                    ),Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(" Password",style: TextStyle(color: AppColor.textColor))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(12)),
                        child: TextFormField(
                         // obscureText: true,
                          onChanged:(jhh){
                            ref
                                .read(moveToProfilePage.notifier)
                                .update((state) => false);
                          },
                          controller: contPassword,
                          validator: (value) {
                            if (value == null || value!.trim().isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(25.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              filled: true,
                              fillColor: AppColor.textFieldColor,
                              prefixIcon: Icon(Icons.lock_outline,color: AppColor.textColor),
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: AppColor.textColor),
                              hintText: " Place Your Password Here"),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(onPressed: (){},
                          child:Text("Forgot Password?",style: TextStyle(
                              color: AppColor.textButtonColor
                          ),)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Checkbox(
                            fillColor: MaterialStateProperty.all(AppColor.textButtonColor),
                            value:_MoveToProfilePage ,
                            onChanged: (value) {
                                _MoveToProfilePage?
                                {ApiServices().loginUser(contUserName.text, contPassword.text),
                                      ref
                                          .read(moveToProfilePage.notifier)
                                          .update((state) => false)
                                    }
                                  :
                                ref.read(moveToProfilePage.notifier).update((state) => true);
                              ApiServices().loginUser(contUserName.text, contPassword.text);
                            },
                          ),
                          Expanded(
                            child: Text(
                              "Click the Check Box after entering the data",
                              style: TextStyle(color: AppColor.textColor),
                            ),
                          )
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
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                WidgetsFlutterBinding.ensureInitialized();
                                final SharedPreferences prefs =await SharedPreferences.getInstance() ;
                                Object? data =prefs.get("token");

                                data==null?ScaffoldMessenger.of( context).showSnackBar(
                                    const SnackBar(content: Text("login failed"))) :{
                                  ref.read(loginOrLogoutProvider.notifier)
                                      .update((state) => false),
                                  Navigator.pop(context)
                                };




                              }
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

                    Center(child: Text("or",style: TextStyle(
                      color: AppColor.titleColor,
                    ),)),
                    Center(child: TextButton(

                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => RegisterationPage())));

                        }, child: Text("Click Here to Create an Account",
                      style: TextStyle(
                      color: AppColor.textButtonColor
                    ),))),


                  ],
                ),
              ),
            )),
      ),
    );
  }
}


