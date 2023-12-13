import 'package:ecommerce_shop_app/controllers/mainscreen_provider.dart';
import 'package:ecommerce_shop_app/views/ui/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=>MainScreenNotifier())
  ],
  child: const MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce App ',
      // initialRoute: '/home',
      // routes: {
      //   '/home': (context) => HomePage(),
      //   // Add more routes as needed
      // },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:   MainScreen()
    );
  }
}
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: TextButton(onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) =>  MainScreen()),
//           );
//         }, child:Text('sample'),)
//       ),
//     );
//   }
// }
