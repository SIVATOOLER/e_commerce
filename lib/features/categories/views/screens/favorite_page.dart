import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nithitex/features/categories/views/screens/profile_page.dart';
import 'package:nithitex/features/categories/views/widgets/fav_list_widget.dart';

import '../../../../config/constants/colors/colors.dart';
import '../../controllers/providers.dart';
import '../../models/wish_list_model.dart';

class FavoritePage extends ConsumerWidget {
   FavoritePage({super.key,});


  @override
  Widget build(BuildContext context,WidgetRef ref) {

  //  final  _data= ref.watch(wishListCallDataProvider);
    print("_data call");
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors:[ AppColor.topBackgroundColor,AppColor.bottomBackgroundColor])
      ),
      child: Scaffold(
         backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Favorites"),
        ),
        body: FavListWidget(),
      ),
    );


  }
}
