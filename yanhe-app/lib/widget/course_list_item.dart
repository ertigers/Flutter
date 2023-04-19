import 'package:boxApp/model/course_model.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/page/course/detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CourseListItem extends StatelessWidget {
  final CourseModel course;

  CourseListItem({Key key, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorManager.push(CourseDetailPage(courseId: course.id));
      },
      child: Container(
        // margin: EdgeInsets.only(left: 15, top: 12, right: 15, bottom: 0),
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
        child: Row(
          children: <Widget>[
            _buildImage(),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Container(
                              margin: EdgeInsets.only(right: 5),
                              padding: EdgeInsets.only(left: 5, top: 2, right: 5, bottom: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(4), bottomRight: Radius.circular(4)),
                                gradient: LinearGradient(
                                  colors: [Color(0xFF1F86FE), Color(0xFF42BBFF)],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )
                              ),
                              child: Text("考研", style: TextStyle(fontSize: 10, color: Color(0xffffffff))),
                            )
                          ),
                          TextSpan(
                            text: '${course.name}',
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
                        course.description ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),    
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0x1A1F86FE),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            "直播+录播",
                            style: TextStyle(
                              color: Color(0xFF1F86FE),
                              fontSize: 11.0,
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 10),
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0x1A1F86FE),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            "${course.hours}课时",
                            style: TextStyle(
                              color: Color(0xFF1F86FE),
                              fontSize: 11.0,
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                        ),                        
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween, //子组件在主轴的排列方式为两端对齐
                        crossAxisAlignment: CrossAxisAlignment.end, //子组件的在交叉轴的对齐方式为起点
                        children: [
                          Text(
                            "已有88人报名",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: Color(0xFFB2B2B2),
                              fontSize: 10.0,
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "¥ ${course.price}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: Color(0xFFFE1F41),
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      )
                    )
                  ],
                ),
              )
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
          borderRadius: BorderRadius.circular(4),
          child: CachedNetworkImage(
            width: 92,
            height: 120,
            imageUrl: course.cover,
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}