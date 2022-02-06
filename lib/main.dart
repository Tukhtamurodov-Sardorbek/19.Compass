import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) => runApp(const Compass()));

}
/// Since the direction keeps changing, we need to use stateful widget to note that and move compass accordingly
class Compass extends StatefulWidget {
  const Compass({Key? key}) : super(key: key);

  @override
  _CompassState createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  double _direction = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterCompass.events!.listen((direction) {
      setState(() {
        _direction = direction.heading!;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    FlutterCompass.events!.listen((event) {}).cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: CompassRED(direction: _direction),
    );
  }
}

class CompassRED extends StatelessWidget {
  final double _direction;
  const CompassRED({Key? key, required double direction}) : _direction = direction, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('COMPASS', style: TextStyle(color: Colors.black, letterSpacing: 1.5, fontWeight: FontWeight.bold, fontSize: 27)),
        backgroundColor: Colors.white,
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Transform.rotate(angle: (_direction * (pi/180) * -1),
          child: Image.asset('assets/compass/img_3.png', width: MediaQuery.of(context).size.width * 0.9),
        ),
      ),
    );
  }
}

