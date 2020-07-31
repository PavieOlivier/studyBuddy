import 'package:flutter/material.dart';
import 'package:study_buddy/Logic/Logic.dart' as logic;
import 'package:study_buddy/SizeConfig/sizeConfig.dart';


class DayOfTheWeekItem extends StatefulWidget {
  final String dayName;
  const DayOfTheWeekItem({
    Key key,
    @required this.dayName,
  }) : super(key: key);

  @override
  _DayOfTheWeekItemState createState() => _DayOfTheWeekItemState();
}

class _DayOfTheWeekItemState extends State<DayOfTheWeekItem> {
  bool isSelected;
  @override
  void initState() {
    super.initState();
    isSelected = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected == true) {
            isSelected = false;
           logic.selectedDays.removeWhere((element){
             return element == widget.dayName;
            });
            //TODO: remove from the selected list
          } else {
            isSelected = true;
            logic.selectedDays.add(widget.dayName);
            //TODO: add to the selected List
          }
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Container(
          width: SizeConfig.safeBlockHorizontal * 35,
          decoration: BoxDecoration(
              color: isSelected ? Color(0xffF7D360) : Colors.white60,
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: ClipOval(
                    child: Container(
                        width: 15,
                        height: 15,
                        color: isSelected
                            ? Colors.greenAccent[400]
                            : Colors.grey[300]),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.dayName,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[300],
                      fontSize: SizeConfig.safeBlockHorizontal * 5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
