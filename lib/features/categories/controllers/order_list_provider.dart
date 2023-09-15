import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nithitex/features/categories/models/order_list_model.dart';
import 'package:nithitex/features/categories/repositories/order_detail_call.dart';
import 'package:nithitex/features/categories/repositories/order_list_call.dart';

import '../models/order_detail_model.dart';

final orderListProvider =
FutureProvider.family<OrderListModel, String>(
      (ref, search) async =>
  await OrderListCall().getData("order/list"),

);
