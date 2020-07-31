
import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:study_buddy/Fork/WidgetAnimator.dart';
import 'package:study_buddy/SizeConfig/sizeConfig.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class StudySessionListItem extends StatefulWidget {
  const StudySessionListItem(
      {Key key,
      this.backgroundColor = Colors.white,
      this.frameToAnimateTo,
      this.frameTIme,
      @required this.useGif,
      @required this.pathToImage,
      @required this.height,
      @required this.title,
      @required this.onTap})
      : super(key: key);

  final double height;
  final String title;
  final Function onTap;
  final String pathToImage;
  final bool useGif;
  final Color backgroundColor;
  final double frameToAnimateTo;
  final int frameTIme;

  @override
  _StudySessionListItemState createState() => _StudySessionListItemState();
}

class _StudySessionListItemState extends State<StudySessionListItem>
    with SingleTickerProviderStateMixin {
  GifController gifController;

  @override
  void initState() {
    super.initState();
    gifController = GifController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: widget.onTap,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
                      elevation: 0.7,
                      child: Container(
              width: SizeConfig.safeBlockHorizontal * 39,
              height: widget.height,
              decoration: BoxDecoration(
                  
                  boxShadow: [
                    BoxShadow(
                        color: Colors.orange[200],
                        offset: Offset(0, 1.85),
                        blurRadius: 5)
                  ],
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(20)),
              child: widget.useGif
                  ? GifImage(
                      controller: gifController,
                      image: AssetImage(widget.pathToImage),
                      onFetchCompleted: () {
                        gifController.duration =
                            Duration(milliseconds: widget.frameTIme);
                        gifController.animateTo(widget.frameToAnimateTo);
                      },
                    )
                  : Center(child: Container(
                    
                    width: SizeConfig.safeBlockHorizontal*25,
                    height: SizeConfig.safeBlockVertical*19,
                    decoration: BoxDecoration(

                      //color: Colors.red,
                      image: DecorationImage(
                          image: AssetImage(
                            widget.pathToImage,
                          ),
                          fit: BoxFit.contain),
                    ),
                  )),
                      ),
                    ),
                    Expanded(
                      child: Center(
                child: Text(
              widget.title,
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal*4.3,
                  fontWeight: FontWeight.w500, color: Colors.orange[300]),
                      )),
                    )
                  ],
                ),
      ),
    );
  }
}
