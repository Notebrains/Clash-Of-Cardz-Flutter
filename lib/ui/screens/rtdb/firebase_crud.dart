
import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class FirebaseCrud extends StatefulWidget {
  FirebaseCrud({this.app});
  final FirebaseApp app;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<FirebaseCrud> {
  int joinedPlayerCount;
  int joinedPlayerSize = 0;
  DatabaseReference _joinedPlayerCountRef;
  DatabaseReference _playerDetailsRef;
  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;
  bool _anchorToBottom = false;

  String _kTestKey = 'playerName';
  DatabaseError _error;

  @override
  void initState() {
    super.initState();
    // Demonstrates configuring to the database using a file
    _joinedPlayerCountRef = FirebaseDatabase.instance.reference().child('joinedPlayerCount');
    // Demonstrates configuring the database directly
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    _playerDetailsRef = database.reference().child('playerDetails');

    database.reference().child('joinedPlayerCount').once().then((DataSnapshot snapshot) {
      print('Connected to second database and read ${snapshot.value}');
    });

    //get child items present in fb db.
    FirebaseDatabase.instance
        .reference()
        .child('playerDetails')
        .once()
        .then((onValue) {
      Map data = onValue.value;
      joinedPlayerSize = data.length;


      print('----joinedPlayerSize: $joinedPlayerSize');
    });



    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _joinedPlayerCountRef.keepSynced(true);
    _counterSubscription = _joinedPlayerCountRef.onValue.listen((Event event) {
      setState(() {
        _error = null;
        //joinedPlayerCount = event.snapshot.value ?? 0;
        joinedPlayerCount =  joinedPlayerSize?? 0;
      });
    }, onError: (Object o) {
      final DatabaseError error = o;
      setState(() {
        _error = error;
      });
    });

    _messagesSubscription =
        _playerDetailsRef.limitToLast(10).onChildAdded.listen((Event event) {
          print('Child added: ${event.snapshot.value}');
        }, onError: (Object o) {
          final DatabaseError error = o;
          print('Error: ${error.code} ${error.message}');
        });
  }

  @override
  void dispose() {
    super.dispose();
    _messagesSubscription.cancel();
    _counterSubscription.cancel();
  }

  Future<void> playerStateUpdate() async {
    // Increment counter in transaction.
    final TransactionResult transactionResult =
    await _joinedPlayerCountRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;
      return mutableData;
    });

    if (transactionResult.committed) {
      _playerDetailsRef.push().set(<String, String>{
        _kTestKey: '${transactionResult.dataSnapshot.value}',
        'image': 'https://www.google.com',
        'userId': 'MEM00055',
        'joinedUserType': joinedPlayerSize == 0 ? 'host': 'joined',
      });
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Center(
              child: _error == null
                  ? Text(
                'Button tapped $joinedPlayerCount time${joinedPlayerCount == 1 ? '' : 's'}. This includes all devices, ever.',
              )
                  : Text(
                'Error retrieving button tap count:\n${_error.message}',
              ),
            ),
          ),
          ListTile(
            leading: Checkbox(
              onChanged: (bool value) {
                setState(() {
                  _anchorToBottom = value;
                });
              },
              value: _anchorToBottom,
            ),
            title: const Text('Anchor to bottom'),
          ),
          Flexible(
            flex: 5,
            child: FirebaseAnimatedList(
              key: ValueKey<bool>(_anchorToBottom),
              query: _playerDetailsRef,
              reverse: _anchorToBottom,
              sort: _anchorToBottom
                  ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key)
                  : null,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return SizeTransition(
                  sizeFactor: animation,
                  child: ListTile(
                    trailing: IconButton(
                      onPressed: () =>
                          _playerDetailsRef.child(snapshot.key).remove(),

                      icon: Icon(Icons.delete),
                    ),
                    title: Text(
                      "$index: ${snapshot.value.toString()}",
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: playerStateUpdate,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
