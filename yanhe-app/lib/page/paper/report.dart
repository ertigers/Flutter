import 'package:boxApp/model/exam_chapter_model.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/page/paper/parse.dart';
import 'package:boxApp/provider/exam_report_model.dart';
import 'package:boxApp/util/size_fit.dart';
import 'package:boxApp/widget/circle_progress_view.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ExamReportPage extends StatefulWidget {
  ExamChapterModel chapterModel;
  int parseId;

  ExamReportPage({Key key, @required this.parseId}) : super(key: key);

  @override
  _ExamReportPageState createState() => _ExamReportPageState();
}

class _ExamReportPageState extends State<ExamReportPage> {

  @override
  void initState() {
    super.initState(); 
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<ExamReportPageModel>(
      model: ExamReportPageModel(parseId: widget.parseId),
      onModelInit: (model) {
        model.loadData();
      },
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('答题报告', style: TextStyle(fontSize: 18,color: Colors.black)),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            brightness: Brightness.light,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child: model.examExerciseModel == null ? Container() : Container(
              child: Column(
                children: [
                  SizedBox(height: 24),
                  Container(
                    alignment: Alignment.center,
                    child: CircleProgressView(
                      width: 140,
                      height: 140,
                      progress: (model.examExerciseModel.rightRate * 100).toDouble(),
                      progressWidth: 12,
                      backgroundColor: Color(0xfff0f0f0)
                    )
                  ),
                  SizedBox(height: 8),
                  Text("正确率：${(model.examExerciseModel.rightRate * 100).toInt()}%", style: TextStyle(fontSize: 18)),
                  SizedBox(height: 24),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 15, top: 20, right: 15, bottom: 20),
                      color: Color(0xfff0f0f0),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 35, top: 6, right: 35, bottom: 5),
                              decoration: BoxDecoration(
                                color: Color(0x1A1F86FE),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(4),
                                  bottomRight: Radius.circular(4)
                                )
                              ),
                              child: Text('详细结果', style: TextStyle(fontSize: 16)),
                            ),
                            SizedBox(height: 12),
                            Expanded(
                              child: GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5, 
                                  childAspectRatio: 1.4, 
                                  // mainAxisSpacing: 12.0,
                                  // crossAxisSpacing: 12.0,
                                ),
                                itemCount: model.examExerciseModel.answers.length,
                                itemBuilder: (context, index) {
                                  var answer = model.examExerciseModel.answers[index];

                                  return Container(
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      onTap: () {
                                        NavigatorManager.push(ExamParsePage(exerciseId: model.examExerciseModel.id, itemIndex: index));
                                      },
                                      child: Container(
                                        width: 36,
                                        height: 36,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: answer.isRight == 1 ? Colors.green : Colors.red,
                                          borderRadius: BorderRadius.circular(22),
                                        ),
                                        child: Text("${index+1}", style: TextStyle(fontSize: 16, color: Colors.white)),
                                      )
                                    )
                                  );
                                }
                              )
                            ),
                            SizedBox(height: 12)
                          ],
                        ),
                      )
                    ),
                  ),
                  _buildMenu(model)
                ],
              ),
            )
          )
        );
      }
    );
  }

    Widget _buildMenu(ExamReportPageModel model) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      height:  MSizeFit.bottomBarHeight + 54,
      color: Colors.blue,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                NavigatorManager.push(ExamParsePage(exerciseId: model.examExerciseModel.id));
              },
              child: Column(
                children: [
                  SvgPicture.asset("assets/svgs/mistake.svg", color: Colors.white, width: 20, height: 20),
                  SizedBox(height: 2),
                  Text("错题解析", style: TextStyle(fontSize: 12, color: Colors.white))
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                NavigatorManager.push(ExamParsePage(exerciseId: model.examExerciseModel.id));
              },
              child: Column(
                children: [
                  SvgPicture.asset("assets/svgs/parse.svg", color: Colors.white, width: 20, height: 20),
                  SizedBox(height: 2),
                  Text("全部解析", style: TextStyle(fontSize: 12, color: Colors.white))
                ],
              )
            ),
          ),
        ],
      )
    );
  }
}
