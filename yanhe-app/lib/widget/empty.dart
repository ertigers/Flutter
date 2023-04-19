import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Empty extends StatelessWidget {
  final String tips;

  Empty({Key key, this.tips}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 20, bottom: 20),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/svgs/empty_02.svg", color: Colors.grey, height: 80),
            SizedBox(height: 6),
            Text(this.tips ?? "暂时空空如也哦～", style: TextStyle(fontSize: 12, color: Colors.grey))
          ],
        )
      )
    );
  }
}