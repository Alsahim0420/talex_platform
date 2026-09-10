import 'package:flutter/material.dart';

abstract final class AppRadii {
  static const double md = 12;
  static BorderRadius get border => BorderRadius.circular(md);
  static RoundedRectangleBorder get shape =>
      const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(md)));
}
