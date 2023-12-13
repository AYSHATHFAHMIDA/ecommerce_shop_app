// import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_shop_app/services/helper.dart';
import 'package:ecommerce_shop_app/views/shared/appstyle.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../models/sneakers_model.dart';
import '../shared/home_widget.dart';
// import '../shared/new_shoes.dart';
// import '../shared/productcard.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  late final TabController _tabController=TabController(length: 3, vsync: this);
  late Future<List<Sneakers>> _male;
  late Future<List<Sneakers>> _female;
  late Future<List<Sneakers>> _kids;



  getMale(){
    _male=Helper().getMaleSneakers();
  }

  getFemale(){
    _female=Helper().getFemaleSneakers();
  }


  getKids(){
    _kids=Helper().getKidsSneakers();
  }

  @override
  void initState(){
    super.initState();
    getMale();
    getFemale();
    getKids();
  }
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
              child: Container(
                padding: const EdgeInsets.only(left: 8,bottom:15 ),
                width: MediaQuery.of(context).size.width,
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Athletics Shoes',style: appStykeWithHt(40, Colors.white, FontWeight.bold, 1.5)),
                    Text('Collection',style: appStykeWithHt(40, Colors.white, FontWeight.bold, 1.2)),
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
            ),

            Padding(
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.260),
              child: Container(
                padding: const EdgeInsets.only(left: 12),
                child: TabBarView(
                  controller: _tabController,
                    children: [
                      HomeWidget(male: _male),
                      HomeWidget(male: _female),
                      HomeWidget(male: _kids),


                    ]),
              ),
            )
          ],
        ),
      )
    );
  }

  // Future<dynamic>filter(){
  //   return showModalBottomSheet(
  //       context: context,
  //       isScrollControlled: true,
  //       backgroundColor: Colors.transparent,
  //       barrierColor: Colors.white,
  //       builder: (context)=>Container(
  //         height: MediaQuery.of(context).size.height*0.82,
  //         decoration: BoxDecoration(
  //           color:Colors.white,
  //
  //         ),
  //       ));
  // }
}




