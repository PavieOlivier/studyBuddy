

import 'package:flutter/material.dart';
import 'package:study_buddy/SizeConfig/sizeConfig.dart';

class ReminderEmptyPlaceHolder extends StatelessWidget {
  final String text;
  const ReminderEmptyPlaceHolder({
    @required this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Expanded(child: SizedBox()),
          Expanded(
            flex: 6,
            child: Container(
              // color: Colors.pink,
              width: SizeConfig.safeBlockHorizontal * 85,
              child: Image.asset('images/icons/reminder.gif'),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 6,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
