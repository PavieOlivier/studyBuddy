import 'package:flutter/material.dart';
import 'package:study_buddy/SizeConfig/sizeConfig.dart';

class FrequencyUnit extends StatelessWidget {
  final Color backGroundColor;
  final Color textColor;
  final String text;
  final Function onTap;
  const FrequencyUnit({
    Key key,
    @required this.backGroundColor,
    @required this.textColor,
    @required this.onTap,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Chip(
          backgroundColor: backGroundColor,
          label: Text(
            text,
          ),
          labelStyle: TextStyle(
            color: textColor,
            fontSize: SizeConfig.safeBlockHorizontal * 5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
