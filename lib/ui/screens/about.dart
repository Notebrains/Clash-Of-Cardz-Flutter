
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trump_card_game/helper/constantvalues/constants.dart';
import 'package:trump_card_game/helper/exten_fun/base_application_fun.dart';
import 'package:trump_card_game/ui/widgets/libraries/flip_panel.dart';

class AboutScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AboutScreenState();
  }
}

class _AboutScreenState extends State<AboutScreen>{

  @override
  void initState() {
    setScreenOrientationToLandscape();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     home: Scaffold(
       body: Container(
         decoration: new BoxDecoration(
           image: new DecorationImage(
             image: new AssetImage("assets/images/bg_img11.png"),
             fit: BoxFit.cover,
           ),
         ),
         child: Stack(
           children: [
             Container(
               padding: EdgeInsets.all(16),
               child: SingleChildScrollView(
                 child: Column(
                   children: [
                     Text(Constants.appNameText, style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),),
                     SizedBox(height: 16),
                     Text(Constants.aboutGameText1, style: TextStyle(color: Colors.black87, fontSize: 16)),
                     SizedBox(height: 16),
                     Text(Constants.aboutGameText2Header, style: TextStyle(color: Colors.black, fontSize: 24)),
                     SizedBox(height: 8),
                     Text(Constants.aboutGameText3, style: TextStyle(color: Colors.black87, fontSize: 16)),
                     SizedBox(height: 8),
                     Text(Constants.aboutGameText4, style: TextStyle(color: Colors.black87, fontSize: 16)),
                     SizedBox(height: 16),
                     Text(Constants.aboutGameText5Header, style: TextStyle(color: Colors.black, fontSize: 24)),
                     SizedBox(height: 8),
                     Text(Constants.aboutGameText6, style: TextStyle(color: Colors.black87, fontSize: 16)),
                     SizedBox(height: 16),
                     Text(Constants.aboutGameText7Header, style: TextStyle(color: Colors.black, fontSize: 24)),
                     SizedBox(height: 8),
                     Text(Constants.aboutGameText8, style: TextStyle(color: Colors.black87, fontSize: 16)),
                     SizedBox(height: 8),
                     Text(Constants.aboutGameText9, style: TextStyle(color: Colors.black87, fontSize: 16)),
                     SizedBox(height: 8),
                   ],
                 ),
               ),
             ),

               Container(
                 margin: EdgeInsets.fromLTRB(0, 0, 16, 16),
                 child: Align(
                   alignment: AlignmentDirectional.bottomEnd,
                   child: FloatingActionButton(
                     tooltip: 'Back to previous screen',
                     backgroundColor: Colors.grey[400],
                     child: Icon(
                       Icons.arrow_back,
                       color: Colors.black,
                     ),
                     onPressed: () {
                       Navigator.pop(context);
                     },
                   ),
                 ),
               ),
             ],
           ),
         ),
       ),
     );
  }

}