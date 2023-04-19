import 'package:flutter/material.dart';

class SectionHeaderVertical extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget action;

  SectionHeaderVertical({
    Key key,
    this.title,
    this.subTitle,
    this.action
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textList = [];
    List<String> strList = title.split('·');
    if (strList.length > 1) {
      strList.asMap().forEach((key, value) {
        if (key != strList.length-1) {
          textList.addAll([
            TextSpan(
              text: value,
              style: TextStyle(
                color: Color(0xFF1F86FE),
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              ),
            ),
            TextSpan(
              text: "·",
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              ),
            )
          ]);
        } else {
          textList.add(TextSpan(
            text: value,
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 18.0,
              fontWeight: FontWeight.bold
            ),
          ));
        }
      });
    } else {
      textList.add(TextSpan(
        text: title ?? "",
        style: TextStyle(
          color: Color(0xFF333333),
          fontSize: 18.0,
          fontWeight: FontWeight.bold
        ),
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/ic_header_left.png',
              width: 4.0,
              height: 20.0,
            ),
            SizedBox(width: 8.0),
            RichText(
              text: TextSpan(
                children: textList
              )
            ),
            SizedBox(width: 8.0),            
            Spacer(),
            Offstage(
              offstage: action == null,
              child: action
            )        
          ],
        ),
        Offstage(
          offstage: subTitle == null,
          child: Container(
            margin: EdgeInsets.only(top: 4.0),
            child: Text(
              subTitle ?? "",
              style: TextStyle(
                color: Color(0xFF999999),
                fontSize: 11.0,
                fontWeight: FontWeight.w400
              ),
            ),
          )
        )
      ],
    );
  }
}