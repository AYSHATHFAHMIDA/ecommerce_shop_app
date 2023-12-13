import 'package:ecommerce_shop_app/views/shared/staggered_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../models/sneakers_model.dart';
import '../../services/helper.dart';
import '../shared/appstyle.dart';
import '../shared/latest_shoes.dart';
class ProductNyCat extends StatefulWidget {
  const ProductNyCat({Key? key}) : super(key: key);

  @override
  State<ProductNyCat> createState() => _ProductNyCatState();
}

class _ProductNyCatState extends State<ProductNyCat>with TickerProviderStateMixin {
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
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.175,left: 16,right: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: TabBarView(
                    controller: _tabController,
                    children: [
                      LatestShoes(male: _male),
                      LatestShoes(male: _female),
                      LatestShoes(male: _kids),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


