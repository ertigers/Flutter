import 'package:boxApp/model/senior_model.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/page/senior/senior.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SeniorListItem extends StatelessWidget {
  final SeniorModel senior;

  SeniorListItem({Key key, this.senior}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorManager.push(SeniorDetailPage(seniorId: 1));
      },
      child: Container(
        padding: EdgeInsets.only(left: 12, top: 10, right: 12, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              color: Color(0x1A1F86FE),
              offset: Offset(0.0, 5.0), //阴影xy轴偏移量
              blurRadius: 15.0, //阴影模糊程度
              spreadRadius: 1.0 //阴影扩散程度
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            ..._buildCollegeMajor(),
            _buildLabel()
          ],
        )
      )
    );
  }

  Widget _buildHeader() {
    return Row(
      children: <Widget>[
        _buildImage(),
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    senior.nickname ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),  
                SizedBox(height: 3),  
                Container(
                  padding: EdgeInsets.only(left: 5, top: 2, right: 5, bottom: 2),
                  decoration: BoxDecoration(
                    color: Color(0x4a1F86FE),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Image.asset(
                            'assets/images/ic_male.png',
                            width: 13.0,
                            height: 13.0,
                          ),
                        ), 
                        TextSpan(
                          text: ' 学长',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold
                          ),
                        ), 
                      ]
                    )
                  ),
                )
              ],
            ),
          )
        )
      ],
    );
  }

  Widget _buildImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular((40.0)), // 圆角度
        boxShadow: [
          BoxShadow(
            color: Color(0x331F86FE),
            offset: Offset(0.0, 2.0), //阴影xy轴偏移量
            blurRadius: 15.0, //阴影模糊程度
            spreadRadius: 1.0 //阴影扩散程度
          )
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: CachedNetworkImage(
          width: 40,
          height: 40,
          imageUrl: senior.avatar,
          fit: BoxFit.cover,
        ),
      )
    );
  }

  List<Widget> _buildCollegeMajor() {
    return [
      SizedBox(height: 16),
      Text(
        senior.college ?? "",
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          color: Color(0xFF666666),
          fontSize: 13.0,
        ),
      ),
      SizedBox(height: 4),
      Text(
        senior.major ?? "",
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          color: Color(0xFF666666),
          fontSize: 13.0,
        ),
      ),
      SizedBox(height: 12),
    ];
  }

  Widget _buildLabel() {
    return Text(
      senior.label.replaceAll(",", " / "),
      style: TextStyle(
        color: Color(0xFF1F86FE),
        fontSize: 9.0,
      ),
    );
  }

}

