import 'package:ecommerce_shop_app/views/shared/appstyle.dart';
import 'package:flutter/material.dart';

class CategoryBtn extends StatelessWidget {
  const CategoryBtn({Key? key, this.onPressed, required this.buttonClr, required this.label}) : super(key: key);
  final void Function()? onPressed;
  final Color buttonClr;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPressed,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width*0.250,
        decoration: BoxDecoration(
          border: Border.all(
              width: 1,color: buttonClr,style: BorderStyle.solid
          ),
             borderRadius: const BorderRadius.all(Radius.circular(9)),
        ),
    child: Center(
      child: Text(
      label,
      style: appStyle(20, buttonClr, FontWeight.w600),
      ),
    ),
      ),
    );
  }
}
