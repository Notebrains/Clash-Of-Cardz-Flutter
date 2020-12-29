// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [Counter] does
/// _not_ depend on Provider.
class Counter with ChangeNotifier {
  int value = 0;
  String name = 'Kiron';

  void increment() {
    value += 1;
    name += 'Mondal';
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // Provide the model to all widgets within the app. We're using
      // ChangeNotifierProvider because that's a simple way to rebuild
      // widgets when a model changes. We could also just use
      // Provider, but then we would have to listen to Counter ourselves.
      //
      // Read Provider's docs to learn about all the available providers.
      home: ChangeNotifierProvider(
        // Initialize the model in the builder. That way, Provider
        // can own Counter's lifecycle, making sure to call `dispose`
        // when not needed anymore.
        create: (context) => Counter(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            // Consumer looks for an ancestor Provider widget
            // and retrieves its model (Counter, in this case).
            // Then it uses that model to build widgets, and will trigger
            // rebuilds if the model is updated.
            Consumer<Counter>(
              builder: (context, counter, child) => Text(
                '${counter.value} ${counter.name} ',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // You can access your providers anywhere you have access
          // to the context. One way is to use Provider<Counter>.of(context).
          //
          // The provider package also defines extension methods on context
          // itself. You can call context.watch<Counter>() in a build method
          // of any widget to access the current state of Counter, and to ask
          // Flutter to rebuild your widget anytime Counter changes.
          //
          // You can't use context.watch() outside build methods, because that
          // often leads to subtle bugs. Instead, you should use
          // context.read<Counter>(), which gets the current state
          // but doesn't ask Flutter for future rebuilds.
          //
          // Since we're in a callback that will be called whenever the user
          // taps the FloatingActionButton, we are not in the build method here.
          // We should use context.read().
          context.read<Counter>().increment();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

/*

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (context) => ValueNotifier("Some fancy data"),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ChildWidget1(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ValueNotifier<String>>().value = "Some new fancy data";
        },
      ),
    );
  }
}

class ChildWidget1 extends StatelessWidget {
  const ChildWidget1({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChildWidget2();
  }
}

class ChildWidget2 extends StatelessWidget {
  const ChildWidget2({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChildWidget3();
  }
}

class ChildWidget3 extends StatelessWidget {
  const ChildWidget3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textNotifier = context.watch<ValueNotifier<String>>();
    return Text(_textNotifier.value);
  }
}*/