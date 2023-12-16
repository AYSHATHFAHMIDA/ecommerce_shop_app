import 'package:flutter/material.dart';

import 'appstyle.dart';
class addToCartBtn extends StatelessWidget {
  const addToCartBtn({
    super.key, this.onTap, required this.label,
  });
  final void Function()? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12)
          ),
          height: 50,
          width: MediaQuery.of(context).size.width*0.9,
          child: Center(child: Text(label,style: appStyle(20,Colors.white, FontWeight.bold),)),
        ),
      ),
    );
  }
}
