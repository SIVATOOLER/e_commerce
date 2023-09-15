import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nithitex/features/categories/models/product_detail_model.dart';
import 'package:nithitex/features/categories/repositories/post_method.dart';


final productDetailProvider =
FutureProvider.family<ProductDetailModel, String>(
      (ref, link) async =>
  await PostMethodCall().getData(link),
);
