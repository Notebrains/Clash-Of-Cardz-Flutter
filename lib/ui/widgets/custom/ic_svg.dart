import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IcSgv extends StatelessWidget {
  final String ic;
  final Function onClick;

  const IcSgv({
    Key key,
    this.ic,
    this.onClick,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: IconButton(
        icon: SvgPicture.asset(
          ic,
          width: 25,
          height: 25,
          color: Colors.white.withOpacity(0.7),
        ),
        onPressed: onClick,
      ),
    );
  }
}