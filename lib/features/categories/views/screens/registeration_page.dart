import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nithitex/features/categories/controllers/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nithitex/config/constants/sizes/textsize.dart';
import 'package:nithitex/config/constants/sizes/widgetsize.dart';
import 'package:nithitex/features/categories/views/screens/login_page.dart';
import 'package:nithitex/features/categories/views/screens/mainscreen.dart';
import '../../../../config/constants/colors/colors.dart';
import '../../repositories/register_call.dart';

//final SharedPreferences prefs =await SharedPreferences.getInstance() ;
class RegisterationPage extends ConsumerWidget {
   RegisterationPage({super.key});


  final _formKey1 = GlobalKey<FormState>();

  TextEditingController _controller1 = TextEditingController();

  TextEditingController _controller2 = TextEditingController();

  TextEditingController _controller3 = TextEditingController();

  TextEditingController _controller4 = TextEditingController();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    var _RegCheckBox=ref.watch(registerPageCheckbox);
    return GestureDetector(
      onTap:()=> FocusScope.of(context).unfocus(),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors:[ AppColor.topBackgroundColor,AppColor.bottomBackgroundColor])
        ),
        child: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: Text("Amazone"),
              ),
              body: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Form(
                  key: _formKey1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "Create your account",
                          style: TextStyle(
                              color: AppColor.textColor,
                              fontSize: TextSize.titleSize+5,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(" Full Name",style: TextStyle(color: AppColor.textColor),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(12)),
                          child: TextFormField(
                            controller: _controller1,
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
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                filled: true,
                                fillColor:AppColor.textFieldColor,
                                prefixIcon: Icon(Icons.person_2_outlined,color: AppColor.textColor,),
                                border: InputBorder.none,

                                hintStyle: TextStyle(color: AppColor.textColor),
                                hintText: " Enter Your Name"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(" E-mail",style: TextStyle(color: AppColor.textColor)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(12)),
                          child: TextFormField(
                            controller: _controller2,
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
                                prefixIcon: Icon(Icons.email_outlined,color: AppColor.textColor),
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: AppColor.textColor),
                                hintText: " Enter Your E-mail Here"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(" Mobile Number",style: TextStyle(color: AppColor.textColor)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(12)),
                          child: TextFormField(
                            controller: _controller3,
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
                        child: Text(" Password",style: TextStyle(color: AppColor.textColor)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(12)),
                          child: TextFormField(
                            controller: _controller4,

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
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Checkbox(
                              fillColor: MaterialStateProperty.all(AppColor.textButtonColor),
                              value: _RegCheckBox,
                              onChanged: (value) {
                              _RegCheckBox?ref.read(registerPageCheckbox.notifier).update((state) => false):
                              ref.read(registerPageCheckbox.notifier).update((state) => true);
                              },
                            ),
                            Expanded(
                              child: Text(
                                "By countinuing you accept our Private Policy and  Term of use",
                                style: TextStyle(color: AppColor.textColor),
                              ),
                            )
                          ],
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: WidgetSize.buttonHeight,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: _RegCheckBox ? 10:1,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  backgroundColor: _RegCheckBox?AppColor.buttonColor:Colors.transparent),
                              onPressed: () async {
                               if(_RegCheckBox) {
                                  if (_formKey1.currentState!.validate()) {
                                    var registerData = await registerUser(
                                        _controller1.text,
                                        _controller2.text,
                                        _controller3.text,
                                        _controller4.text);

                                    if (registerData.status) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Successfully Registered")));
                                      print('Registration success');
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Failed to Registered")));
                                      print('Registration failed');
                                    }
                                  }
                                }
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
                      Center(child: Text("or",style: TextStyle(
                        color: AppColor.titleColor,
                      ),)),
                      Center(child: TextButton(

                          onPressed: (){

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => LoginPage())));

                          }, child: Text("If Already Have An Account? Click Here",
                        style: TextStyle(
                            color: AppColor.textButtonColor
                        ),)))

                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
