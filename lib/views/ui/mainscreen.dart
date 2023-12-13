import 'package:ecommerce_shop_app/controllers/mainscreen_provider.dart';
import 'package:ecommerce_shop_app/views/ui/productby_cat.dart';
import 'package:ecommerce_shop_app/views/ui/profilepage.dart';
import 'package:ecommerce_shop_app/views/ui/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/bottomnavbar.dart';
import 'cartpage.dart';
import 'homepage.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  List<Widget> pageList = const[
    HomePage(),
    SearchPage(),
    ProductNyCat(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // int pageIndex = 4;
    return Consumer<MainScreenNotifier>(
        builder: (context,mainScreenNotifier,child){
          return Scaffold(
            backgroundColor:const Color(0xFFE2E2E2),
            // backgroundColor: const Color(0xffffffff),
            body:pageList[mainScreenNotifier.pageIndex],
            bottomNavigationBar:const  BottomNavBar(),
          );
    });
    }
  }



