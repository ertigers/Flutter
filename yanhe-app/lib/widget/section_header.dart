import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String subTitle;
  final dynamic more;

  SectionHeader({
    Key key,
    this.title,
    this.subTitle,
    this.more
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
    return Row(
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
        Offstage(
          offstage: false,
          child: Text(
            subTitle ?? "",
            style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 12.0,
              fontWeight: FontWeight.w400
            ),
          ),
        ),
        Spacer(),
        Offstage(
          offstage: more == null,
          child: more is Widget 
          ? more 
          : InkWell(
            onTap: () {
              if (more is Function) {
                more?.call();
              }
            },
            child: Row(
              children: [
                Text(
                  "更多",
                  style: TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(width: 2.0),
                Image.asset(
                  'assets/images/ic_more_right.png',
                  width: 5.0,
                  height: 10.0,
                ),
              ],
            ),
          )
        )        
      ],
    );
  }
}