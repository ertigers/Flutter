import 'package:boxApp/model/common_menu_model.dart';
import 'package:flutter/material.dart';

class CommonMenuItem extends StatelessWidget {
  final CommonMenuModel menu;

  CommonMenuItem({
    Key key,
    @required this.menu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              menu.iconUrl,
              width: 44.0,
              height: 44.0,
            ),
            SizedBox(height: 8.0),
            Text(
              menu.title,
              style: TextStyle(
                color: Color(0xFF191919),
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}