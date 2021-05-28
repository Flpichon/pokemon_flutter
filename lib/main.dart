import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Pokémon'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<AssetImage, String> pokedex = {
    AssetImage('images/Salamèche.png'): 'Salamèche',
    AssetImage('images/Reptincel.png'): 'Reptincel',
    AssetImage('images/Dracaufeu.png'): 'Dracaufeu',
    AssetImage('images/Dracaufeu_Y.png'): 'Dracaufeu_Y'
  };
  List<AssetImage> _images = [
    AssetImage('images/Salamèche.png'),
    AssetImage('images/Reptincel.png'),
    AssetImage('images/Dracaufeu.png'),
    AssetImage('images/Dracaufeu_Y.png')
  ];
  int _counter = 0;
  String sens = 'asc';
  late AssetImage _currentImage = _images[0];
  late String name = 'Salamèche';

  void _changeImage() async {
    final previousImage = _currentImage.assetName.toString();
    final one = _images.firstWhere((img) => img.assetName == previousImage);
    if (_counter == _images.length - 1 && sens == 'asc') {
      sens = 'desc';
    }
    if (_counter == 0 && sens == 'desc') {
      sens = 'asc';
    }
    if (sens == 'asc') {
      _counter++;
    }
    if (sens == 'desc') {
      _counter--;
    }
    _currentImage = _images[_counter];
    final nextImage = _images[_counter].assetName.toString();
    final two = _images.firstWhere((img) => img.assetName == nextImage);

    Future<void> time(AssetImage arg) {
      return Future.delayed(
        Duration(milliseconds: 600),
        () => {
          setState(
            () {
              if (sens == 'asc') {
                name = 'Evolution';
              }
              if (sens == 'desc') {
                name = 'Désévolution';
              }
              _currentImage = arg;
            },
          ),
        },
      );
    }

    for (var i = 0; i <= 6; i++) {
      if (i % 2 == 0) {
        await time(two);
      } else {
        await time(one);
      }
    }
    _currentImage = _images[_counter];
    name = pokedex[_currentImage].toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.title),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 500,
            width: 500,
            child: GestureDetector(
              onTap: () => _changeImage(),
              child: Center(child: Image(image: _currentImage)),
            ),
          ),
          Center(
            child: Container(
              height: 200,
              width: 200,
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  scale: 1,
                  image: AssetImage(
                    'images/Pokeball.png',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
