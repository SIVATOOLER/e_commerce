import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nithitex/config/constants/colors/colors.dart';
import 'package:nithitex/config/constants/sizes/textsize.dart';
import 'package:nithitex/features/categories/models/categories_model.dart';
import 'package:nithitex/features/categories/views/screens/list_widget_page.dart';

import '../../controllers/search_provider.dart';
import '../../models/all_products_model.dart';
import '../screens/search_page.dart';

class CategoryFrameView extends ConsumerWidget {
  CategoryFrameView({super.key, required this.list});
  Categories list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2 / 2.5),
        itemCount: list.data!.category.length,
        itemBuilder: (BuildContext context, int index) {
          return TextButton(
            onPressed: () async {
              var _categoryId = list.data.category[index].id;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => ListWidgetPage(id:_categoryId))));

            final AllProductModel _search = await ref.read(searchlistProvider.call("productsbycategory/${_categoryId}?page=1").future) ;
            ref.refresh(searchlistProvider("productsbycategory/${_categoryId}?page=1"));
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Ink(
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  list.data!.category[index]
                                      .categoryImage,
                                ),
                                fit: BoxFit.cover),
                            color: Colors.white,
                            border:
                                Border.all(color: AppColor.boarderColor),
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    Text(
                      list.data!.category[index].categoryName,
                      style: TextStyle(
                          color: AppColor.textButtonColor,
                          fontSize: TextSize.boxTitleSize,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
