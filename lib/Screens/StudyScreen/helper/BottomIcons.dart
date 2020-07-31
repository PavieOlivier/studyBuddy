import 'package:flutter/material.dart';
import 'package:study_buddy/SizeConfig/sizeConfig.dart';

class BottomIcons extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  final Color color;
  const BottomIcons({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.onTap,
    @required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon , color: color,size: SizeConfig.safeBlockHorizontal*7,),
          Text(title , style: TextStyle(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: SizeConfig.safeBlockHorizontal*4
          ),
          textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
