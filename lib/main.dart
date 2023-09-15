import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nithitex/features/categories/views/screens/mainscreen.dart';
import 'package:nithitex/utils/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/categories/controllers/providers.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.initialize();
 runApp(
     const ProviderScope(child: MyApp())
 );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amazone',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home:  MainScreen(),
    );
  }
}
