import 'package:boxApp/model/teacher_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CourseDetailTeacher extends StatelessWidget {
  final List<TeacherModel> teacherList;

  CourseDetailTeacher({Key key, this.teacherList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 15),
      itemCount: teacherList.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return _buildTeacherItem(teacherList[index]);
      }
    );
  }

  Widget _buildTeacherItem(TeacherModel teacher) {
    return Container(
      padding: EdgeInsets.only(top: 16, right: 15, bottom: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5,color: Color(0xffeeeeee)))
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                width: 34,
                height: 34,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: CachedNetworkImage(
                    imageUrl: teacher.avatar,
                    fit: BoxFit.cover,
                  )
                ),  
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${teacher.name}",
                      style: TextStyle(fontSize: 16, color: Color(0xff333333))
                    ),
                    Text(
                      "${teacher.description}",
                      style: TextStyle(fontSize: 10, color: Color(0xff999999))
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 8),
                width: 34,
              ),
              Expanded(
                child: Text(
                  "${teacher.detail}",
                  style: TextStyle(fontSize: 14, color: Color(0xff666666))
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}