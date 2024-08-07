import 'package:flutter/material.dart';

class ResponsiveView extends StatelessWidget {
  const ResponsiveView({
    super.key,
    required this.tab,
    required this.mobile,
  });
  final Widget tab;
  final Widget mobile;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width >= 800) {
      return tab;
    } else {
      return mobile;
    }
  }
}
