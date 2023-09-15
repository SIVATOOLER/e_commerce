import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nithitex/config/constants/sizes/widgetsize.dart';
import 'package:nithitex/features/categories/repositories/profile_uploader_call.dart';

import '../../../../config/constants/colors/colors.dart';
import '../../../../config/constants/sizes/textsize.dart';
import '../../controllers/providers.dart';

class UserProfilePage extends ConsumerWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    TextEditingController nController = TextEditingController();
    TextEditingController phController = TextEditingController();
    TextEditingController pcController = TextEditingController();
    TextEditingController dController = TextEditingController();
    TextEditingController strController = TextEditingController();
    TextEditingController cController = TextEditingController();
    TextEditingController SIdController = TextEditingController();
    TextEditingController sController = TextEditingController();

    changeFun() async {
      var hasChanged=await DataUploader(
        name: nController.text,phone:phController.text ,
        doorNo:dController .text,pincode: pcController.text,
        street: strController.text,city:cController.text ,
          state: sController.text, stateId: SIdController.text
      ).dataUploader();
      ScaffoldMessenger.of( context).showSnackBar(
           SnackBar(content: Text(hasChanged?"updated successfully":"failed to Update")));

      ref.refresh(profileDataApiDataProvider);
      ref.read(dataEditor.notifier).update((state) => false);
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
            contentPadding: EdgeInsets.symmetric(vertical: 2.0),
            filled: true,
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

            fillColor: AppColor.textFieldColor,
           prefixIcon: Icon(Icons.input),
            border: InputBorder.none,
            hintStyle: TextStyle(color: AppColor.textColor),
            hintText: hint),
      );
    }

    containerFun(data){
      return Container(
          decoration: BoxDecoration(
              border: Border.all(color:AppColor.boarderColor),
              color: AppColor.buttonColor,
              borderRadius: BorderRadius.circular(50)
          ),
          child: Center(child: Text(data,style: TextStyle(
              color: AppColor.textColor,fontSize: TextSize.boxSubTitleSize

          ),)));
    }

    final _UserData=ref.watch(profileDataApiDataProvider);
    final _Editor=ref.watch(isEditor);
    final _DataEditor=ref.watch(dataEditor);
    ImagePicker picker= ImagePicker();
    return  Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors:[ AppColor.topBackgroundColor,AppColor.bottomBackgroundColor])
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomSheet:_Editor ? BottomSheet(
            backgroundColor: Colors.grey,

            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
            builder: (BuildContext context) {
              return SizedBox(
                height: 80,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(color: Colors.white70,
                        child: IconButton(onPressed: ()  {
                          uploader( ImageSource.camera);

                        }, icon: Icon(Icons.camera_alt_outlined)),
                      ),
                    ),
                    Container(
                      color: Colors.white70,
                      child: IconButton(
                          onPressed: (){
                            uploader(ImageSource.gallery);
                          }, icon: Icon(Icons.photo)),
                    ),
                    Spacer(),
                    IconButton(onPressed: (){
                       ref.refresh(profileDataApiDataProvider);
                      ref.read(isEditor.notifier).update((state) => false);
                    }, icon: Icon(Icons.clear)),
                  ],
                ),
              );
            }, onClosing: () {

          },):null,
          appBar:AppBar(
            title: Text("Amazone"),
            backgroundColor: Colors.transparent,
          ) ,
          body:SingleChildScrollView(
            child: Stack(
              children: [
                _UserData.when(data: (list){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white60,
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        ref.read(isEditor.notifier).update((state) => true);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          backgroundColor:AppColor.textColor,
                                          radius:  MediaQuery.of(context).size.width*0.2 +5,
                                          child: CircleAvatar(
                                            backgroundColor: AppColor.boarderColor,
                                            radius: MediaQuery.of(context).size.width*0.2,
                                            backgroundImage:list.data!.userProfile![0].userImage==null ?null:
                                            NetworkImage(list.data!.userProfile![0].userImage),
                                            child: list.data!.userProfile![0].userImage==null ?Icon(Icons.person_2_outlined,size: 100 ,):null,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("User Id : ${list.data!.userProfile![0].userId}",
                                             style: TextStyle(
                                              color: AppColor.textColor,fontSize: TextSize.boxTitleSize
                                          ),),Text("${list.data!.userProfile![0].userName}"
                                            ,overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.textColor,fontSize: TextSize.boxTitleSize
                                          ),),Text("${list.data!.userProfile![0].email}",
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              color: AppColor.textColor,fontSize: TextSize.boxTitleSize
                                          ),),Text("${list.data!.userProfile![0].phone?? ""}",style: TextStyle(
                                              color: AppColor.textColor,fontSize: TextSize.boxTitleSize
                                          ),),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.topBackgroundColor,
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: IconButton(
                                      onPressed: (){
                                        ref.read(dataEditor.notifier).update((state) => true);
                                      },
                                      icon: Icon(Icons.edit),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height*0.57,
                          decoration: BoxDecoration(
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8,12,8,12),
                            child: GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 7/2,crossAxisSpacing:20,
                                mainAxisSpacing: 20
                                ,
                            ),children: [
                              containerFun("Area: ${list.data!.userProfile![0].doorNo ?? ""}" "${list.data!.userProfile![0].streetName?? ""} "),
                              containerFun("City :${list.data!.userProfile![0].city?? ""} "),
                              containerFun("State : ${list.data!.userProfile![0].state?? ""} "),
                              containerFun("StateId : ${list.data!.userProfile![0].stateId?? ""} "),
                              containerFun("Pincode : ${list.data!.userProfile![0].pincode?? ""} "),
                              containerFun("CouponName : ${list.data!.userProfile![0].couponName?? ""} "),
                              containerFun("CouponCode : ${list.data!.userProfile![0].couponCode?? ""} "),
                              containerFun("ReferralCode : ${list.data!.userProfile![0].referralCode?? ""} "),
                              containerFun("ShortName : ${list.data!.userProfile![0].shortName?? ""} "),
                              containerFun("ShippingCharge : ${list.data!.userProfile![0].shippingCharge?? ""} "),
                              containerFun("CodCharge : ${list.data!.userProfile![0].codCharge?? ""} "),
                              containerFun("ColorCode : ${list.data!.userProfile![0].colorCode?? ""} "),
                              containerFun("TotalPointsEarned : ${list.data!.userProfile![0].totalPointsEarned?? ""} "),
                              containerFun("TotalPointsReceived : ${list.data!.userProfile![0].totalPointsReceived?? ""} "),
                            ],

                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                    error: (error,err){return
                  Text("Error");
                    },
                    loading: ()=>Center(child: CircularProgressIndicator())),
                _DataEditor? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: AnimatedContainer(
                      curve: Curves.easeInExpo,
                      height: MediaQuery.of(context).size.height*0.5,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                      ),
                        duration: Duration(microseconds: 1000),
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
                              _TextField("PhoneNo", phController),
                              _TextField("PinCode", pcController),
                              _TextField("DoorNo", dController),
                              _TextField("Street", strController),
                              _TextField("City", cController),
                              _TextField("State", sController),
                              _TextField("StateId", SIdController),
                              ],

                            ),
                          ),
                        ),
                        ElevatedButton(onPressed: (){
                          changeFun();
                        },
                            style: ElevatedButton.styleFrom(

                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                backgroundColor: AppColor.boarderColor),
                            child: Text("Change",style: TextStyle(
                              color: AppColor.textColor
                            ),))
                      ],) ,
                    ),
                  ),
                ):Container()
              ],

            ),
          )
        ),
      ),
    );
  }
}
