import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
          Flexible(
            flex: 1,
             fit: FlexFit.tight,
            child: _top()),
            Flexible(flex: 6, fit: FlexFit.tight, child: _middle()),
            Flexible(flex: 3,  fit: FlexFit.tight, child: _bottom())
              ],
            ),
        ));
  }

  Widget _top() => Container(
    width: double.infinity,
    alignment: Alignment.center,
    color: Colors.amber,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.title, style: TextStyle(decoration: TextDecoration.combine([TextDecoration.underline]))),
        Container(
          height: 10.0,
          color: Colors.accents[0],
        )
      ],),
  );

  Widget _middle() => Container(
    width: double.infinity,
    color: Colors.green,
    child: Wrap(
      direction: Axis.vertical,
      children: [
        Text(widget.title),
        
      ],),
  );

  Widget _bottom() => Container(
    width: double.infinity,
    color: Colors.red,
    child: Wrap(
      direction: Axis.vertical,
      children: [
        Text(widget.title),
        
      ],),
  );
}
