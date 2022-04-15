import 'package:flutter/material.dart';

selfFieldDecoration(){
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    boxShadow: [
      new BoxShadow(
        color: Colors.black54,
        offset: new Offset(1.0, 1.0),
        blurRadius: 3.0,
      )
    ],
  );
}