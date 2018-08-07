import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Animation Part2',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Home(),
    );
  }
}

class ChanegColor extends AnimatedWidget {
  ChanegColor({Key key, Animation<Color> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<Color> colorAnimation = listenable;
    return Text(
      'Anand',
      style: TextStyle(fontSize: 100.0, color: colorAnimation.value),
    );
  }
}

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> colorTween;
  Animation<double> animation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    colorTween =
        ColorTween(begin: Colors.pink, end: Colors.green).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void CallAnimation() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RotationTransition(
            turns: animation,
            child: FadeTransition(
              opacity: animation,
              child:Text(
              'Anand',
              style: TextStyle(fontSize: 100.0, color: Colors.green),
            ),
          ),),
          ChanegColor(
            animation: colorTween,
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: CallAnimation,
      ),
    );
  }
}
