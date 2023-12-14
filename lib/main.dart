import 'package:ecommerce_shop_app/controllers/mainscreen_provider.dart';
import 'package:ecommerce_shop_app/controllers/product_provider.dart';
import 'package:ecommerce_shop_app/views/ui/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=>MainScreenNotifier()),
    ChangeNotifierProvider(create: (context)=>ProductNotifier()),
  ],
  child: const MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce App ',
      // initialRoute: '/home',
      // routes: {
      //   '/home': (context) => HomePage(),
      //   // Add more routes as needed
      // },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:   MainScreen()
    );
  }
}

