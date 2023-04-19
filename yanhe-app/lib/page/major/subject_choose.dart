import 'package:boxApp/model/subject_model.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/provider/subject_choose_model.dart';
import 'package:boxApp/util/size_fit.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubjectChoosePage extends StatefulWidget {
  int majroId;
  String collegeCode;

  SubjectChoosePage({Key key, @required this.majroId, this.collegeCode}) : super(key: key);

  @override
  State createState() => _SubjectChoosePageState();
}

class _SubjectChoosePageState extends State<SubjectChoosePage> {
  SubjectChooseModel subjectChooseModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<SubjectChooseModel>(
      model: SubjectChooseModel(majorId: widget.majroId, collegeCode: widget.collegeCode),
      onModelInit: (model) {
        subjectChooseModel = model;
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
            title: Text("选择报考科目", style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.only(top: 8.0, bottom: 12, left: 15.0, right: 15.0),
                      itemBuilder: (context, index) {
                        return _buildSubjectItem(model.subjectList[index]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 12);
                      },
                      itemCount: model.subjectList.length
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 24.0, bottom: MSizeFit.bottomBarHeight + 24, left: 30.0, right: 30.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: RaisedButton(
                        padding: EdgeInsets.all(0.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text("确 定"),
                        color: Colors.blue,
                        disabledColor: Color(0xFFF8F8F8),
                        textColor: Colors.white,
                        disabledTextColor: Color(0xFFCCCCCC),
                        onPressed: () {
                          NavigatorManager.pop(subjectChooseModel.subjectList.where((subject) => subject.selected == 1).toList());
                        }
                      )
                    )
                  ),
                ],
              ),
            )
          )
        );
      }
    );
  }
  
  Widget _buildSubjectItem(SubjectModel subject) {
    return GestureDetector(
      onTap: () {
        // widget.onChanged(widget.value);
        subject.selected = subject.selected == 1 ? 0 : 1;
        subjectChooseModel.updateSubjectModel(subject);
      },
      child: Container(
        padding: EdgeInsets.only(left: 12, top: 10, right: 12, bottom: 10),
        // height: 44,
        decoration: BoxDecoration(
          color: Color(0xfff2f2f2),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(subject.name, style: TextStyle(fontSize: 14, color: Color(0xff000000))),
                  SizedBox(height: 6),
                  Text('科目代码：${subject.code}', style: TextStyle(fontSize: 12, color: Color(0xff666666))),
                ],
              )
            ),
            SvgPicture.asset("assets/svgs/selected.svg", color: subject.selected == 1 ? Colors.blue : Color(0xffd2d2d2), width: 24, height: 24),
          ],
        ),
      )
    );
  }

}


