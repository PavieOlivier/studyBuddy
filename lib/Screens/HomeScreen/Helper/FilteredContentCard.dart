import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:study_buddy/SizeConfig/sizeConfig.dart';

class FilteredContentCard extends StatelessWidget {
  final String senderName;
  final String senderMessage;
  final DateTime time;
  const FilteredContentCard({
    Key key, @required this.senderName,@required  this.senderMessage,@required this.time
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Slidable(
      
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
          color: Colors.white,
          child: Container(
            width: SizeConfig.horizontalBloc * 95,
            height: SizeConfig.verticalBloc * 16.5,
            //color: Colors.red,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.orange[50],
                  offset: Offset(0, 1.75),
                  blurRadius: 3)
            ], borderRadius: BorderRadius.circular(20)),
            child: Card(
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0.2,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal* 5.0),
                      child: Container(
                        
                       
                        color: Colors.transparent,
                        child: Image.asset('images/L.png'),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //TODO: you need to add the model here after creating the database
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              'At: ${DateFormat.jm().format(time)}',
                              style: TextStyle(
                                  color: Colors.orange[400],
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal * 3.5,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Container(
                            // color: Colors.pink,
                            width: SizeConfig.horizontalBloc * 55,
                            height: SizeConfig.verticalBloc * 2.2,
                            child: Text(
                              'A Message From $senderName',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.orange[400],
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeConfig.safeBlockHorizontal * 4),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            //color: Colors.pink,
                            width: SizeConfig.horizontalBloc * 59,
                            height: SizeConfig.verticalBloc * 9,
                            child: Text(
                              senderMessage,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                              style: TextStyle(
                                  color: Colors.black26,
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeConfig.safeBlockHorizontal * 4),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.white,
          foregroundColor: Colors.red,
          icon: Icons.delete,
          onTap: () => {},
        ),
      ],
    );
  }
}


