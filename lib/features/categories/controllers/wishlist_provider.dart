import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nithitex/features/categories/repositories/add_wish_list_call.dart';
import 'package:nithitex/features/categories/repositories/wish_list_call.dart';

import '../models/add_wish-list.dart';

final wishListProvider =
    FutureProvider((ref) async => await WishListCall().getWishListCall());

final addRemoveWishlistProvider =
    FutureProvider.family<AddWishListModel, String>(
  (ref, productId) async =>
      await AddWishListCall().getAddWishListCall(productId),
);
