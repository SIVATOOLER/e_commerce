import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nithitex/features/categories/models/add_cart_list_model.dart';
import 'package:nithitex/features/categories/repositories/add_cart_list_call.dart';

import '../models/add_wish-list.dart';
import '../repositories/cart_list_call.dart';


final cartListProvider =
FutureProvider((ref) async => await CartListCall().getCartListCall());



final addCartProvider =
FutureProvider.family<AddCartListModel,dynamic>(
      (ref ,productId) async =>
  await AddCartListCall().getAddCartListCall(productId,1),
);
