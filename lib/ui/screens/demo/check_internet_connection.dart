import 'package:flutter/material.dart';
import 'package:clash_of_cardz_flutter/ui/widgets/custom/check_internet_connection.dart';

class InternetConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Connection status"),
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              child: checkNetConWidget(),
            ),
            Container(
              width: 200,
              height: 200,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
