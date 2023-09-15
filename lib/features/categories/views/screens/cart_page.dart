import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nithitex/config/constants/colors/colors.dart';
import 'package:nithitex/features/categories/views/widgets/fav_list_widget.dart';

import '../../../../config/constants/sizes/textsize.dart';
import '../widgets/cart_list_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CartListWidget();
  }
}




