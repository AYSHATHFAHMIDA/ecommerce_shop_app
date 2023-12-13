import 'package:flutter/material.dart';
import '../shared/appstyle.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "this is Profile",style: appStyle(40, Colors.black, FontWeight.bold),
        ),
      ),
    );
  }
}
