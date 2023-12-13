import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_shop_app/views/shared/appstyle.dart';
import 'package:flutter/material.dart';

class StaggeredTiles extends StatefulWidget {
  const StaggeredTiles({Key? key, required this.imageUrl, required this.name, required this.price}) : super(key: key);
  final String imageUrl;
  final String name;
  final String price;

  @override
  State<StaggeredTiles> createState() => _StaggeredTileStates();
}

class _StaggeredTileStates extends State<StaggeredTiles> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(imageUrl: widget.imageUrl,fit: BoxFit.fill,),
            Container(
              padding: const EdgeInsets.only(top: 12),
              height: 75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name,style: appStykeWithHt(20, Colors.black, FontWeight.w700,1),),
                  Text(widget.price,style: appStykeWithHt(20, Colors.black, FontWeight.w500,1),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
