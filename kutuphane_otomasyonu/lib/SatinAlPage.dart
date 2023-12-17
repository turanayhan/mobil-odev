import 'package:flutter/material.dart';

import 'FirebaseManager.dart';


class SatinAlPage extends StatefulWidget {
  @override
  _SatinAlPageState createState() => _SatinAlPageState();
}

class _SatinAlPageState extends State<SatinAlPage> {


  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Yakında')
          ],
        ),
      ),
    );
  }
}
