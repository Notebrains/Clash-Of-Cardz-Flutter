import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _first = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedPhysicalModel(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              elevation: _first ? 0 : 6.0,
              shape: BoxShape.rectangle,
              shadowColor: Colors.cyanAccent,
              color: Colors.white,
              borderRadius: _first
                  ? const BorderRadius.all(Radius.circular(0))
                  : const BorderRadius.all(Radius.circular(10)),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    _first = !_first;
                  });
                },
                child: SizedBox(
                  height: 120.0,
                  width: 120.0,
                  child: FlutterLogo(
                    size: 60,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

/*  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Center(
              child: Image.network(
                'https://lh3.googleusercontent.com/proxy/RlwZq2Ff8Ad2RJhWSxaMKsFBtYM9_z-unxOscJ1tnodTAY2oqlnlPFf_0sdXweniRH3bi_sZWPb7N0QZqvAhuea_GBDVhHDqOF3lOfI',
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: Image.network(
                'https://lh3.googleusercontent.com/proxy/RlwZq2Ff8Ad2RJhWSxaMKsFBtYM9_z-unxOscJ1tnodTAY2oqlnlPFf_0sdXweniRH3bi_sZWPb7N0QZqvAhuea_GBDVhHDqOF3lOfI',
              ),
            ),
          ),
        ],
      ),
    );
  }*/
}
