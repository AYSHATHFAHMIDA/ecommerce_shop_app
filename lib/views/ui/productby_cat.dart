import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../shared/appstyle.dart';
class ProductNyCat extends StatefulWidget {
  const ProductNyCat({Key? key}) : super(key: key);

  @override
  State<ProductNyCat> createState() => _ProductNyCatState();
}

class _ProductNyCatState extends State<ProductNyCat>with TickerProviderStateMixin {
  late final TabController _tabController=TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFFE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
              // width: double.infinity,
              height: MediaQuery.of(context).size.height*0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/top_image.png"),fit: BoxFit.fill),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(6, 12, 16, 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(AntDesign.close,color: Colors.white,),
                        ),
                        GestureDetector(
                          onTap: (){

                          },
                          child: Icon(FontAwesome.sliders,color: Colors.white,),
                        )
                      ],
                    ),
                  ),
                  TabBar(
                      padding: EdgeInsets.zero,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.transparent,
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: Colors.white,
                      labelStyle: appStyle(24, Colors.white, FontWeight.bold),
                      unselectedLabelColor: Colors.grey.withOpacity(0.3),
                      tabs:
                      const[
                        Tab(text: 'Mens shoes',),
                        Tab(text: 'womens shoes',),
                        Tab(text: 'kids shoes',),
                      ]),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.2,left: 16,right: 12),
              child: TabBarView(
                  controller: _tabController,
                  children: [
                Container(
                  height: 500,
                  width: 300,
                  color: Colors.red,
                ),
                Container(
                  height: 500,
                  width: 300,
                  color: Colors.blue,
                ),
                Container(
                  height: 500,
                  width: 300,
                  color: Colors.green,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
