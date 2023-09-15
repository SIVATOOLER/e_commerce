import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nithitex/features/categories/repositories/search_item_call.dart';

import '../models/all_products_model.dart';


final searchlistProvider =
FutureProvider.family<AllProductModel, String>(
      (ref, search) async =>
  await SearchCall().getSearchProductList(search),

);
