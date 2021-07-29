import 'package:flutter/material.dart';

class Media {
  BuildContext context;
  Size screenSize;

  Media(this.context) {
    screenSize = MediaQuery.of(context).size;
  }

  double s(sizeArg) {
    assert(sizeArg is int || sizeArg is double);
    double size = sizeArg is int ? sizeArg.toDouble() : sizeArg;
    return screenSize.width *0.0283* size / 10;
  }

  double sH(sizeArg) {
    assert(sizeArg is int || sizeArg is double);
    double size = sizeArg is int ? sizeArg.toDouble() : sizeArg;
    return screenSize.height *0.014* size / 10;
  }

  double get width => screenSize.width;
  double get height => screenSize.height;

  double get s5 => screenSize.width * 0.015;
  double get s8 => screenSize.width * 0.022;
  double get s10 => screenSize.width * 0.027;
  double get s12 => screenSize.width * 0.035;
  double get s13 => screenSize.width * 0.037;
  double get s14 => screenSize.width * 0.04;
  double get s15 => screenSize.width * 0.044;
  double get s17 => screenSize.width * 0.047;
  double get s18 => screenSize.width * 0.051;
  double get s20 => screenSize.width * 0.056;
  double get s22 => screenSize.width * 0.06;
  double get s24 => screenSize.width * 0.065;
  double get s26 => screenSize.width * 0.07;
  double get s30 => screenSize.width * 0.083;
  double get s35 => screenSize.width * 0.094;
  double get s40 => screenSize.width * 0.1108;
  double get s60 => screenSize.width * 0.16;
  double get s100 => screenSize.width * 0.275;
}
