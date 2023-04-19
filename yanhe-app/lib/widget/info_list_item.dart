import 'package:boxApp/model/info_model.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/page/info/info.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class InfoListItem extends StatelessWidget {
  final InfoModel info;

  InfoListItem({Key key, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorManager.push(InfoDetailPage(infoId: 1));
      },
      child: Container(
        padding: EdgeInsets.only(left: 12, top: 10, right: 12, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          text: TextSpan(
                            children: [
                              // WidgetSpan(
                              //   alignment: PlaceholderAlignment.middle,
                              //   child: Image.asset(
                              //     'assets/images/ic_hot_01.png',
                              //     width: 11.0,
                              //     height: 12.0,
                              //   ),
                              // ), 
                              TextSpan(
                                text: '${info.name}',
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold
                                ),
                              ), 
                            ]
                          )
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            info.description ?? "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ), 
                      ],
                    ),
                  )
                ),
                SizedBox(width: 28),
                _buildImage()
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/ic_news_view.png',
                      width: 11.0,
                      height: 11.0,
                    ),
                    Text(
                      " 2.2k",
                      style: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 11.0,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/ic_news_comment.png',
                      width: 11.0,
                      height: 11.0,
                    ),
                    Text(
                      " 46",
                      style: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 11.0,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/ic_news_like.png',
                      width: 10.0,
                      height: 10.0,
                    ),
                    Text(
                      " 46",
                      style: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 11.0,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        )
      )
    );
  }

  _buildImage() {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: CachedNetworkImage(
            width: 64,
            height: 64,
            imageUrl: info.cover,
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}