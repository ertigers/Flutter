import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListItemSingle extends StatefulWidget {
  int value;
  String content = "";
  int itemChecked;

  Function(int) onChanged;

  ListItemSingle({
    Key key, 
    @required this.value, 
    @required this.content,
    @required this.itemChecked,
    @required this.onChanged
  }) : super(key: key);

  @override
  _ListItemSingleState createState() => _ListItemSingleState();
}

class _ListItemSingleState extends State<ListItemSingle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.onChanged(widget.value);
      },
      child: Container(
        height: 44,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 5, right: 45),
                child: Text(
                  widget.content,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Color(0xff666666)),
                ),
              ),
            ),
            SvgPicture.asset("assets/svgs/selected.svg", color: widget.value == widget.itemChecked ? Colors.blue : Color(0xffd2d2d2), width: 20, height: 20),
          ],
        ),
      )
    );
  }
}