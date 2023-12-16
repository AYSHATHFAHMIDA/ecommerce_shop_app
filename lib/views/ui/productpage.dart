import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_shop_app/controllers/product_provider.dart';
import 'package:ecommerce_shop_app/views/shared/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../models/sneakers_model.dart';
import '../../services/helper.dart';
import '../shared/addtocart_btn.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.id, required this.category}) : super(key: key);
  final String id;
  final String category;
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  final pageController=PageController();
  final _cartBox=Hive.box('cart_box');

  late Future<Sneakers> _sneakers;

  void getShoes(){
    if(widget.category=="Men's Running"){
      _sneakers=Helper().getMaleSneakersById(widget.id);
    }
    else if(widget.category=="Women's Running"){
      _sneakers=Helper().getFemaleSneakersById(widget.id);
    }
    else if(widget.category=="Kids' Running"){
      _sneakers=Helper().getKidsSneakersById(widget.id);
    }
  }

  Future <void> _createCart(Map<String,dynamic>newCart)async{
    await _cartBox.add(newCart);
  }

  @override
  void initState() {
    super.initState();
    getShoes();
  }
  @override
  Widget build(BuildContext context) {
    var productNotifier=Provider.of<ProductNotifier>(context);
    return Scaffold(
      body:FutureBuilder<Sneakers>(
        future:_sneakers,
        builder: ( context,snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          else if (snapshot.hasError) {
            return Text('Error ${snapshot.error}');
          } else {
            final sneaker = snapshot.data;
            return Consumer<ProductNotifier>(
              builder: (context, productNotifier, child) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leadingWidth: 0,
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                                // productNotifier.shoeSizes.clear();
                              },
                              child: const Icon(AntDesign.close,color: Colors.black,),
                            ),
                            GestureDetector(
                              onTap: (){

                            },
                              child: const Icon(Ionicons.ellipsis_horizontal,color: Colors.black,),
                            )
                          ],
                        ),
                      ),

                      pinned: true,
                      snap: false,
                      floating: true,
                      backgroundColor: Colors.transparent,
                      expandedHeight: MediaQuery.of(context).size.height,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width,
                              child: PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: sneaker!.imageUrl.length,
                                  controller: pageController,
                                  onPageChanged: (page) {
                                    productNotifier.activePage = page;
                                  },
                                  itemBuilder: (context, int index) {
                                    return Stack(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context).size.height * 0.39,
                                          width: MediaQuery.of(context).size.width,
                                          color: Colors.grey.shade300,
                                          child: CachedNetworkImage(
                                            imageUrl: sneaker.imageUrl[index],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Positioned(
                                            top: MediaQuery.of(context).size.height *0.1,
                                            right: 20,
                                            child: const Icon(AntDesign.hearto,
                                              color: Colors.grey,)),
                                        Positioned(
                                            bottom: 0,
                                            right: 0,
                                            left: 0,
                                            height: MediaQuery.of(context).size.height * 0.3,
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: List<Widget>.generate(
                                                    sneaker.imageUrl.length, (index) =>
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                                      child: CircleAvatar(
                                                        radius: 5,
                                                        backgroundColor: productNotifier.activePage != index ? Colors.grey : Colors.black,
                                                      ),))
                                            )),
                                      ],
                                    );
                                  }),
                            ),
                            Positioned(
                                bottom: 30,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height*0.642,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                                child: Text(
                                                  sneaker.name,
                                                  style: appStyle(35, Colors.black, FontWeight.bold),)),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(sneaker.category,style: appStyle(20, Colors.grey.shade500, FontWeight.w400),),
                                                RatingBar.builder(
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  // allowHalfRating: true,
                                                  itemSize: 22,
                                                  initialRating: 4,
                                                  itemCount: 5,
                                                  itemPadding: const EdgeInsets.symmetric(horizontal: 1),
                                                  itemBuilder: ((context,_)=>const Icon(Icons.star,size: 15,color: Colors.black,)),
                                                  onRatingUpdate: (rating){

                                                  },
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("\$${sneaker.price}",style: appStyle(25, Colors.black, FontWeight.bold),),
                                                Row(
                                                  children: [
                                                    Text('Colors',style: appStyle(20, Colors.black, FontWeight.w500),),
                                                    SizedBox(width: 5,),
                                                    CircleAvatar(
                                                      radius: 7,
                                                      backgroundColor: Colors.black,
                                                    ),
                                                    SizedBox(width: 5,),
                                                    CircleAvatar(
                                                      radius: 7,
                                                      backgroundColor: Colors.red,
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('select size',style: appStyle(20, Colors.black, FontWeight.w600),),
                                                    SizedBox(width: 20,),
                                                    Text('view size Guide',style: appStyle(20, Colors.grey, FontWeight.w600),)

                                                  ],

                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                  child: ListView.builder(
                                                      itemCount: productNotifier.shoeSizes.length,
                                                      scrollDirection: Axis.horizontal,
                                                      padding:EdgeInsets.zero,
                                                      itemBuilder: (context,index){
                                                        final sizes=productNotifier.shoeSizes[index];
                                                        return Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                                          child: ChoiceChip(
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(60),
                                                                side: BorderSide(
                                                                  color: Colors.black,
                                                                  width: 1,
                                                                  style: BorderStyle.solid,
                                                                ),
                                                              ),
                                                              disabledColor: Colors.white,
                                                              label: Text(
                                                                sizes['size'],
                                                                style: appStyle(18,sizes['isSelected']? Colors.white:Colors.black, FontWeight.w500),
                                                              ),
                                                            selectedColor: Colors.black,
                                                            padding: EdgeInsets.symmetric(vertical: 8),
                                                            selected: sizes['isSelected'],
                                                            onSelected: (newState){
                                                                if(productNotifier.sizes.contains(sizes['size'])){
                                                                  productNotifier.sizes.remove(sizes['size']);
                                                                }else{
                                                                  productNotifier.sizes.add(sizes['size']);
                                                                }
                                                                print(productNotifier.sizes);
                                                                productNotifier.toggleCheck(index);
                                                            },
                                                          ),
                                                        );
                                                      }),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            const Divider(
                                              indent: 10,
                                              endIndent: 10,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.8,
                                              child: Text(
                                                sneaker.title,
                                                style: appStyle(26, Colors.black, FontWeight.w700),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              sneaker.description,
                                              textAlign: TextAlign.justify,
                                              // maxLines: 4,
                                              style: appStyle(14, Colors.grey, FontWeight.normal),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Padding(
                                                padding: EdgeInsets.only(top: 12),
                                                child: addToCartBtn(label: 'Add To Cart',onTap: (){

                                                },),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          }
        })
    );
  }
}

