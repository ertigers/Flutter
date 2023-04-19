import 'package:boxApp/model/authorize_model.dart';
import 'package:boxApp/model/consult_model.dart';
import 'package:boxApp/model/exam_model.dart';
import 'package:boxApp/model/subject_model.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/page/subject/exam_chapter.dart';
import 'package:boxApp/provider/auth_page_model.dart';
import 'package:boxApp/provider/exam_list_model.dart';
import 'package:boxApp/util/content_util.dart';
import 'package:boxApp/widget/empty.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExamListPage extends StatefulWidget {
  SubjectModel subjectModel;
  ConsultModel consultModel;
  int examType;
  String title;

  ExamListPage({Key key, this.subjectModel, this.consultModel, this.examType, this.title}) : super(key: key);
  
  @override
  State createState() => _ExamListPageState();
}

class _ExamListPageState extends State<ExamListPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<ExamListModel>(
      model: ExamListModel(subjectId: widget.subjectModel?.id, consultId: widget.consultModel?.id, examType: widget.examType),
      onModelInit: (model) {
        model.loadData();
      },
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomPadding: true,
          appBar: AppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            centerTitle: true,
            title: Text(widget.title ?? "考点刷题", style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child:  model.examList.length > 0 ? Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg_exam_list.png"),
                  fit: BoxFit.cover
                )
              ),
              child: ListView.separated(
                padding: EdgeInsets.only(top: 12.0, bottom: 24.0, left: 15.0, right: 15.0),
                itemBuilder: (context, index) {
                  return _buildExamItem(exam: model.examList[index], model: model);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 12);
                },
                itemCount: model.examList.length
              ),
            ) : Container(
              margin: EdgeInsets.only(top: 50),
              child: Empty(),
            ),            
          )
        );
      }
    );
  }

  Widget _buildExamItem({ExamModel exam, ExamListModel model}) {
    var authStatus = ContentUtils.computeExamAuthStatus(exam);

    return InkWell(
      onTap: () async {
        if (widget.subjectModel != null) {
          exam.subjectId = widget.subjectModel.id;
        }
        await NavigatorManager.push(ExamChapterPage(examModel: exam));
        model.getExamList();
      },
      child: Container(
        padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 12.0, right: 12.0),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${exam.name}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 13.0,
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [  
                      Offstage(
                        offstage: exam.price <= 0,
                        child: Container(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: SvgPicture.asset("assets/svgs/lock2.svg", color: Colors.black, width: 11, height: 11),
                                ),
                                TextSpan(
                                  text: ' ¥${exam.price}',
                                  style: TextStyle(fontSize: 11, color: Color(0xffff0000))
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Offstage(
                        offstage: exam.price <= 0 ? false : true,
                        child: Container(
                          padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 6.0, right: 6.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green, width: 0.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            '免费题库',
                            style: TextStyle(fontSize: 10, color: Colors.green)
                          ),
                        ),
                      ),
                      Offstage(
                        offstage: (exam.price > 0 && exam.auth != null && exam.auth.authType == 1) ? false : true,
                        child: Container(
                          padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 6.0, right: 6.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green, width: 0.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            '已购买',
                            style: TextStyle(fontSize: 10, color: Colors.green)
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(width: 12),
            Container(
              // padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 12.0, right: 12.0),
              // decoration: BoxDecoration(
              //   border: Border.all(color: Color(0xFF1F86FE), width: 1),
              //   borderRadius: BorderRadius.circular(10.0),
              // ),
              child: Row(
                children: [
                  Text(
                    authStatus['status'] == 'free' ? '刷题' : '免费体验(${authStatus['usableTrialCount']}/${authStatus['totalTrialCount']})', 
                    style: TextStyle(fontSize: 11, color: Colors.blue)
                  ),
                  Icon(Icons.keyboard_arrow_right, size: 18, color: Colors.blue)
                ],
              )
            )
          ],
        ),
      )
    );
  }

}


