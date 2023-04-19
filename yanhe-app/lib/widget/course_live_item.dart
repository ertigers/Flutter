import 'package:boxApp/model/course_model.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/page/course/detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CourseLiveItem extends StatelessWidget {
  final CourseModel course;
  final bool last;

  CourseLiveItem({Key key, this.course, this.last}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorManager.push(CourseDetailPage(courseId: course.id));
      },
      child: Container(
        margin: EdgeInsets.only(left: 15, right: last ? 15 : 0, bottom: 20),
        width: 160,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.all(0),
          elevation: 10.0,
          shadowColor: Color(0x141F86FE),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildImage(),
              Container(
                margin: EdgeInsets.fromLTRB(10, 8, 10, 0),
                alignment: Alignment.centerLeft,
                child: Text(
                  course.name,
                  // softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),              
              Container(
                margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                alignment: Alignment.center,
                height: 20,
                width: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg_btn_01.png"),
                    fit: BoxFit.cover
                  )
                ),
                child: Text(
                  "免费学习",
                  style: TextStyle(
                    color: Color(0xFFffffff),
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          )
        ),
      )
    );
  }

  _buildImage() {
    return Stack(
      children: <Widget>[
        CachedNetworkImage(
          width: 160,
          height: 120,
          imageUrl: course.cover,
          fit: BoxFit.cover,
        ),
        Positioned(
          left: 0,
          top: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            child: Container(
              padding: EdgeInsets.only(left: 4, top: 5, right: 4, bottom: 5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1F86FE), Color(0xFF42BBFF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              ),
              alignment: AlignmentDirectional.center,
              child: Text(
                course.label,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  // fontWeight: FontWeight.bold
                ),
              )
            )
          )
        )
      ],
    );
  }
}