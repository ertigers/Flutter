import 'package:boxApp/model/setting_item_model.dart';
import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final SettingItemModel item;

  SettingItem({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        item.onTap?.call();
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                item.iconUrl != null ?
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Image.asset(
                    item.iconUrl,
                    width: 20.0,
                    height: 20.0,
                  ),
                ) : Container(),
                Text(
                  item.title,
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 13.0,
                    // fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(width: 12),
                // Spacer(),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: _buildValue(),
                  ),
                ),
                Offstage(
                  offstage: false,
                  child: Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Image.asset(
                      'assets/images/ic_more_right.png',
                      width: 5.0,
                      height: 10.0,
                    ),
                  )
                )        
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: item.iconUrl != null ? 30 : 0, top: 15),
              height: 1,
              color: Color(0xFFEEEEEE)
            )
          ],
        ),
      ),
    );
  }

  Widget _buildValue() {
    if (item.child != null) {
      return item.child;
    } else if (item.value is String && item.value.toString().isNotEmpty) {
      return Container(
        child: Text('${item.value}', style: TextStyle(fontSize: 12, color: Color(0xff333333))),
      );
    } else if (item.hint != null) {
      return Container(
        child: Text('${item.hint}', style: TextStyle(fontSize: 12, color: Color(0xff999999))),
      );
    }
    return Container();
  }
}