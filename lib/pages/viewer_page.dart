import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewerPage extends StatefulWidget {
  @override
  _ViewerPageState createState() => _ViewerPageState();
}

class _ViewerPageState extends State<ViewerPage> {
  Size size;
  Map args;
  final transformationController = TransformationController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: Container(
            color: Colors.black,
            padding: EdgeInsets.only(top: 60),
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: Center(child: _body())));
  }

  Widget _body() {
    return InteractiveViewer(
        alignPanAxis: true,
        boundaryMargin: const EdgeInsets.all(double.infinity),
        constrained: false,
        child: Image.network(
            args['url'],
            width: MediaQuery.of(context).size.width));
  }
}
