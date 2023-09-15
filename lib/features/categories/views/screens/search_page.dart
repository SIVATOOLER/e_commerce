

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nithitex/config/constants/colors/colors.dart';
import 'package:nithitex/features/categories/models/all_products_model.dart';

import '../../controllers/search_provider.dart';
import '../widgets/list_widget.dart';

class SearchPage extends ConsumerWidget {
   SearchPage({super.key,});
   TextEditingController searchControl=TextEditingController();
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    FocusNode focusNode=FocusNode();

   Future<AllProductModel> searchFun()  async {
      final AllProductModel _search = await ref.read(searchlistProvider.call("search/${searchControl.text}").future) ;
          return _search;
    }
    final _search=ref.watch(searchlistProvider("search/${searchControl.text}"));

    return   Scaffold(
      backgroundColor: AppColor.bottomBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          child: TextFormField(
            focusNode: focusNode,
            autofocus: true,
            controller: searchControl,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(focusNode);
            },
            onChanged: (k) async {
              final AllProductModel _search = await ref.read(searchlistProvider.call("search/${searchControl.text}").future) ;
              ref.refresh(searchlistProvider("search/${searchControl.text}"));


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
        actions: [
          IconButton(onPressed: (){
            searchControl.clear();
          }, icon: Icon(Icons.clear))
        ],
      ),
      body:_search.when(
          data: (list){
            return ListWidget(
              data:list,header: "header",
              scrollDirection: Axis.vertical, crossAxisCount: 2,
              aspectRatio: 10/14.21, gridBoxSize: MediaQuery.of(context).size.height*0.88,
              crossAxisSpacing: 0, mainAxisSpacing: 20,
            );
          },
          error: (error,err){
            return Center(child: Text("No results found"));
          },
          loading: (){
            Center(child: CircularProgressIndicator());
          })
    );

    }}