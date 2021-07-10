import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  Loader(
    this.isLoading,
  );

  bool isLoading;

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return widget.isLoading == null || widget.isLoading
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black.withOpacity(0.7),
            child: Center(
                child: Text('Loading...',
                    style: TextStyle(fontSize: 20, color: Colors.white))))
        : Container();
  }
}
