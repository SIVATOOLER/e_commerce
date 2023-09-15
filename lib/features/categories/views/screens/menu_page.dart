import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nithitex/features/categories/models/categories_model.dart';
import '../../../../config/constants/colors/colors.dart';
import '../../../../config/constants/sizes/textsize.dart';
import '../../controllers/providers.dart';
import '../../controllers/search_provider.dart';
import '../widgets/category_frame_view.dart';



class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
  var data = ref.watch(searchlistProvider('saree'));
    var _data =ref.watch(categoryDataProvider);
    return _data.when(
        data: (list){
          return FutureBuilder<Categories>(
              future: list,
              builder: (context,snapshot){
                 if(snapshot.hasData){
                  return CategoryFrameView(list: snapshot.requireData);
            }else if (snapshot.hasError){
                  return Center(child: Text("Error"));
                }
                 return Center(child: CircularProgressIndicator());
          });
        },
        error:(err, nono) {
          return
            Text("error");
        },
        loading: () {
          return Center(child: const CircularProgressIndicator());
        });
  }
}
