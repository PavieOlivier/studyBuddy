import 'package:flutter/material.dart';
import 'package:study_buddy/SizeConfig/sizeConfig.dart';

class NavigationBarItem extends StatelessWidget {
  final String title;
  final Color textColor;
  final Function onTap;
  final TextDecoration textDecoration;
  const NavigationBarItem({
    Key key,
    @required this.title,
    @required this.textColor,
    @required this.onTap,
    this.textDecoration = TextDecoration.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 8,
            fontWeight: FontWeight.w700,
            decoration: textDecoration,
            decorationColor: textColor,
            color: textColor),
      ),
    );
  }
}
