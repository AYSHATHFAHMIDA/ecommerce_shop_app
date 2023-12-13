import 'package:ecommerce_shop_app/views/shared/custom_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../models/sneakers_model.dart';
import '../../services/helper.dart';
import '../shared/appstyle.dart';
import '../shared/category_btn.dart';
import '../shared/latest_shoes.dart';

class ProductByCat extends StatefulWidget {
  const ProductByCat({Key? key, required this.tabIndex}) : super(key: key);
  final int tabIndex;
  @override
  State<ProductByCat> createState() => _ProductByCatState();
}

class _ProductByCatState extends State<ProductByCat>with TickerProviderStateMixin {
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
  List<String>brand=[
    'assets/images/adidas.png',
    'assets/images/gucci.png',
    'assets/images/jordan.png',
    'assets/images/nike.png',
  ];
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
                      padding: const EdgeInsets.fromLTRB(6, 12, 16, 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: const Icon(AntDesign.close,color: Colors.white,),
                        ),
                        GestureDetector(
                          onTap: (){
                            filter();
                          },
                          child: const Icon(FontAwesome.sliders,color: Colors.white,),
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
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.180,left: 16,right: 12),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: TabBarView(
                    controller: _tabController,
                    children: [
                      // LatestShoes(male: _male),
                      // LatestShoes(male: _female),
                      // LatestShoes(male: _kids),
                      if (widget.tabIndex == 0) LatestShoes(male: _male),
                      if (widget.tabIndex == 1) LatestShoes(male: _female),
                      if (widget.tabIndex == 2) LatestShoes(male: _kids),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<dynamic>filter(){
    double _value=100;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white54,
        builder: (context)=>Container(
          height: MediaQuery.of(context).size.height*0.82,
          decoration: const BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25)
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 5,
                width: 40,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.8,
                child: Column(
                  children: [
                   const CustomSpacer(),
                    Text('Filter',style: appStyle(40, Colors.black, FontWeight.bold),),
                    const CustomSpacer(),
                    Text('Gender',style: appStyle(20, Colors.black, FontWeight.bold),),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: const [
                        CategoryBtn(buttonClr: Colors.black, label: 'Men'),
                        CategoryBtn(buttonClr: Colors.grey, label: 'Women'),
                        CategoryBtn(buttonClr: Colors.grey, label: 'Kids'),
                        CustomSpacer(),
                      ],
                    ),
                    const CustomSpacer(),
                    Text('Category',style: appStyle(20, Colors.black,FontWeight.w600),),
                    const SizedBox(height: 15,),
                    Row(
                      children: const [
                        CategoryBtn(buttonClr: Colors.black, label: 'Shoes'),
                        CategoryBtn(buttonClr: Colors.grey, label: 'Apparrels'),
                        CategoryBtn(buttonClr: Colors.grey, label: 'Accessories'),
                      ],
                    ),
                    const CustomSpacer(),
                    Text('Price',style: appStyle(20, Colors.black, FontWeight.bold),),
                    const CustomSpacer(),
                    Slider(
                        value: _value,
                        activeColor: Colors.black,
                        inactiveColor: Colors.grey,
                        thumbColor: Colors.black,
                        max: 500,
                        divisions: 50,
                        label: _value.toString(),
                        secondaryTrackValue: 200,
                        onChanged: (double value){
                        }),
                    const CustomSpacer(),
                    Text('Brands',style: appStyle(20, Colors.black, FontWeight.bold),),
                    const SizedBox(height: 15,),
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: 80,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: brand.length,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                ),
                                child: Image.asset(brand[index],height: 60,width: 80,color: Colors.black,),
                              ),
                            );
                      }),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }


}


