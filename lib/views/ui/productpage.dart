import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_shop_app/controllers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import '../../models/sneakers_model.dart';
import '../../services/helper.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.id, required this.category}) : super(key: key);
  final String id;
  final String category;
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final pageController=PageController();
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

  @override
  void initState() {
    super.initState();
    getShoes();
  }
  @override
  Widget build(BuildContext context) {
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
                              onTap: null,
                              child: const Icon(AntDesign.close),
                            ),
                            GestureDetector(
                              onTap: null,
                              child: const Icon(Ionicons.ellipsis_horizontal),
                            )
                          ],
                        ),
                      ),

                      pinned: true,
                      snap: false,
                      floating: true,
                      backgroundColor: Colors.transparent,
                      expandedHeight: MediaQuery
                          .of(context)
                          .size
                          .height,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.5,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
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
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.39,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          color: Colors.grey.shade300,
                                          child: CachedNetworkImage(
                                            imageUrl: sneaker.imageUrl[index],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Positioned(
                                            top: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 09,
                                            right: 20,
                                            child: const Icon(AntDesign.hearto,
                                              color: Colors.grey,)),
                                        Positioned(
                                            bottom: 0,
                                            right: 0,
                                            left: 0,
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.3,
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                children: List<Widget>.generate(
                                                    sneaker.imageUrl.length, (index) =>
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 4),
                                                      child: CircleAvatar(
                                                        radius: 5,
                                                        backgroundColor: productNotifier
                                                            .activePage != index
                                                            ? Colors.grey
                                                            : Colors.black,
                                                      ),))
                                            ))
                                      ],
                                    );
                                  }),
                            )
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
