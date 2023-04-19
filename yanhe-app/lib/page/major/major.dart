import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/page/major/college_choose.dart';
import 'package:boxApp/page/major/major_choose.dart';
import 'package:boxApp/page/major/subject_choose.dart';
import 'package:boxApp/provider/major_page_model.dart';
import 'package:boxApp/util/size_fit.dart';
import 'package:boxApp/util/toast_util.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/widget/provider_widget.dart';

class MajorPage extends StatefulWidget {
  @override
  State createState() => _MajorPageState();
}

class _MajorPageState extends State<MajorPage> {

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MajorPageModel>(
      model: MajorPageModel(),
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
            // title: Text("专业信息", style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child:ListView(
              padding: EdgeInsets.only(left: 28, top: 10, right: 28, bottom: 20 + MSizeFit.bottomBarHeight),
              children: [
                _buildHeader(),
                _buildYear(model),
                _buildTimes(model),
                _buildCollege(model),
                _buildMajor(model),
                _buildSubject(model),
                // 提交按钮
                Container(
                  margin: EdgeInsets.only(top: 58.0, bottom: 0.0, left: 30.0, right: 30.0),
                  child: RaisedButton(
                    padding: EdgeInsets.all(0.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text("确认提交"),
                    color: Color(0xFF1F86FE),
                    disabledColor: Color(0xFFF8F8F8),
                    textColor: Colors.white,
                    disabledTextColor: Color(0xFFCCCCCC),
                    onPressed: model.verify() ? () {
                      model.submit();
                    } : null
                  )
                ),
              ],
            )
          )
        );
      }
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, //子组件的排列方式为主轴两端对齐
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '请填写您的基本信息',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(51, 51, 51, 1)
              )
            ),
            SizedBox(height: 8),
            Text(
              '后续可以修改，请放心填写',
              style: TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(153, 153, 153, 1)
              )
            ),
          ],
        ),
        Container(
          child: Image.asset('assets/images/logo.png', width: 51, height: 51)
        )
      ],
    );
  }

  // 考研年份
  Widget _buildYear(MajorPageModel model) {
    return Container(
      margin: EdgeInsets.only(top: 38),
      constraints: BoxConstraints(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text("考研年份", style: TextStyle(fontSize: 18, color: Color(0xff333333))),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: model.getYears().map((e) => InkWell(
                onTap: () {
                  model.setYear = e;
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(8, 1, 8, 1),
                  width: 92,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: model.year == e ? Color(0xFF1F86FE) : Color(0xFFCCCCCC), width: 0.5),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    "$e",
                    style: TextStyle(
                      color: model.year == e ? Color(0xFF1F86FE) : Color(0xff333333),
                      fontSize: 14.0,
                    ),
                  ),
                ),
              )
            ).toList()
          )
        ]
      ),
    );
  }

  // 考研资料
  Widget _buildTimes(MajorPageModel model) {
    return Container(
      margin: EdgeInsets.only(top: 24),
      constraints: BoxConstraints(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text("考研次数", style: TextStyle(fontSize: 18, color: Color(0xff333333))),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: model.getTimes().map((e) => InkWell(
              onTap: () {
                model.setTimes = e['value'];
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(8, 1, 8, 1),
                width: 92,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: model.times == e['value'] ? Color(0xFF1F86FE) : Color(0xFFCCCCCC), width: 0.5),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  "${e['label']}",
                  style: TextStyle(
                    color: model.times == e['value'] ? Color(0xFF1F86FE) : Color(0xff333333),
                    fontSize: 14.0,
                  ),
                ),
              ))
            ).toList()
          )
        ]
      ),
    );
  }

  // 报考院校
  Widget _buildCollege(MajorPageModel model) {
    return Container(
      margin: EdgeInsets.only(top: 24),
      constraints: BoxConstraints(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text("报考院校", style: TextStyle(fontSize: 18, color: Color(0xff333333))),
          ),
          InkWell(
            onTap: () {              
              NavigatorManager.push(CollegeChoosePage()).then((college) {
                if (college == null) return;
                if (college.id != model.collegeModel?.id) {
                  model.majorModel = null;
                  model.subjectList = [];
                }
                model.collegeModel = college;
                setState(() {});
              });
            },
            child: Container(
              margin: EdgeInsets.only(top: 18),
              padding: EdgeInsets.only(bottom: 5),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 1,color: Color(0xffeeeeee)))
              ),
              child: model.collegeModel != null ?
              Text(model.collegeModel?.name ?? "", style: TextStyle(fontSize: 14, color: Color(0xff000000)))
              : Text('选择报考院校', style: TextStyle(fontSize: 14, color: Color(0xff999999))),
            )
          )
        ]
      ),
    );
  }

  // 报考专业
  Widget _buildMajor(MajorPageModel model) {
    return Container(
      margin: EdgeInsets.only(top: 24),
      constraints: BoxConstraints(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text("报考专业", style: TextStyle(fontSize: 18, color: Color(0xff333333))),
          ),
          InkWell(
            onTap: () {
              if (model.collegeModel == null) {
                if (model.collegeModel == null) {
                  return ToastUtils.showTip('请先选择院校');
                }
              }
              NavigatorManager.push(MajorChoosePage(collegeCode: model.collegeModel.code)).then((major) {
                if (major == null) return;
                if (major.id != model.majorModel?.id) {
                  model.subjectList = [];
                }
                model.majorModel = major;
                setState(() {});
              });
            },
            child: Container(
              margin: EdgeInsets.only(top: 18),
              padding: EdgeInsets.only(bottom: 5),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 1,color: Color(0xffeeeeee)))
              ),
              child: model.majorModel != null ?
              Text(model.majorModel.name ?? "", style: TextStyle(fontSize: 14, color: Color(0xff000000)))
              : Text('选择报考专业', style: TextStyle(fontSize: 14, color: Color(0xff999999))),
            )
          )
        ]
      ),
    );
  }

  // 报考科目
  Widget _buildSubject(MajorPageModel model) {
    return Container(
      margin: EdgeInsets.only(top: 24),
      constraints: BoxConstraints(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text("报考科目", style: TextStyle(fontSize: 18, color: Color(0xff333333))),
          ),
          InkWell(
            onTap: () {
              if (model.majorModel == null) {
                if (model.majorModel == null) {
                  return ToastUtils.showTip('请先选择专业');
                }
              }
              NavigatorManager.push(SubjectChoosePage(majroId: model.majorModel.id, collegeCode: model.collegeModel.code,)).then((subjectList) {
                if (subjectList == null) return;
                model.subjectList = subjectList;
                setState(() {});
              });
            },
            child: Container(
              margin: EdgeInsets.only(top: 18),
              padding: EdgeInsets.only(bottom: 5),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 1,color: Color(0xffeeeeee)))
              ),
              child: model.subjectList.length > 0 ?
              Text(model.subjectList.map((e) => e.name).toList().join('、'), style: TextStyle(fontSize: 14, color: Color(0xff000000)))
              : Text('选择报考科目', style: TextStyle(fontSize: 14, color: Color(0xff999999)))
            )
          )
        ]
      ),
    );
  }
}


