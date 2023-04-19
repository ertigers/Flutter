import 'package:boxApp/model/common_menu_model.dart';
import 'package:boxApp/model/paper_params_model.dart';
import 'package:boxApp/model/subject_model.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/page/paper/paper.dart';
import 'package:boxApp/page/subject/exam_list.dart';
import 'package:boxApp/page/ranklist/ranklist.dart';
import 'package:boxApp/provider/subject_page_model.dart';
import 'package:boxApp/util/share_util.dart';
import 'package:boxApp/util/size_fit.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/widget/provider_widget.dart';

class ExamSubjectPage extends StatefulWidget {
  SubjectModel subjectModel;

  ExamSubjectPage({Key key, this.subjectModel}) : super(key: key);

  @override
  State createState() => _ExamSubjectPageState();
}

class _ExamSubjectPageState extends State<ExamSubjectPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<SubjectPageModel>(
      model: SubjectPageModel(widget.subjectModel.id),
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
            title: Text(widget.subjectModel?.name ?? "", style: TextStyle(fontSize: 18, color: Colors.black)),
            actions: [
              IconButton(
                icon: Image.asset('assets/images/ic_share.png', width: 20, height: 20),
                onPressed: () {
                  ShareUtil.share(widget.subjectModel?.name ?? "", "https://h5.koudaikaoyan.com");
                },
              )   
            ],
          ),
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child: CustomScrollView(
              slivers: [
                _buildHeader(model),
                _buildMenuList(model),
                _buildExamOther(model)
              ],
            ),
          )
        );
      }
    );
  }

  Widget _buildHeader(SubjectPageModel model) {
    return SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                     RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${model.counts != null ? model.counts['exam_item_count'] : 0}",
                            style: TextStyle(fontSize: 28, color: Color(0xff333333), fontWeight: FontWeight.bold)
                          ),
                          TextSpan(
                            text: '道',
                            style: TextStyle(fontSize: 12, color: Color(0xff333333))
                          ),
                        ]
                      )
                    ),
                    SizedBox(height: 2),
                    Text('累计刷题数',style: TextStyle(fontSize: 14, color: Color(0xff333333))),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                     RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${model.counts != null ? (model.counts['exam_right_rate'] * 100).toInt() : 0}',
                            style: TextStyle(fontSize: 28, color: Color(0xff333333), fontWeight: FontWeight.bold)
                          ),
                          TextSpan(
                            text: '%',
                            style: TextStyle(fontSize: 12, color: Color(0xff333333))
                          ),
                        ]
                      )
                    ),
                    SizedBox(height: 2),
                    Text('当前准确率',style: TextStyle(fontSize: 14, color: Color(0xff333333))),
                  ],
                ),
              )
            ],
          ),
        ),
    );
  }

  Widget _buildMenuList(SubjectPageModel model) {
    return SliverToBoxAdapter(
      child: Column(
        children: model.menuList.map((e) => _buildMenuItem(e)).toList(),
      ),
    );
  }

  // 菜单项
  Widget _buildMenuItem(CommonMenuModel menu) {
    return InkWell(
      onTap: () {
        if (menu.title == '考点刷题') {   
          NavigatorManager.push(ExamListPage(subjectModel: widget.subjectModel, examType: 1, title: "考点刷题"));
        } else if (menu.title == '历年真题') {
          NavigatorManager.push(ExamListPage(subjectModel: widget.subjectModel, examType: 3, title: "历年真题"));
        } else if (menu.title == '书籍题库') {
          NavigatorManager.push(ExamListPage(subjectModel: widget.subjectModel, examType: 2, title: "书籍题库"));
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 15, top: 12, right: 15),
        padding: EdgeInsets.only(left: 24, top: 0, right: 24, bottom: 0),
        width: double.infinity,
        height: 84,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          image: DecorationImage(
            image: AssetImage(menu.iconUrl),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${menu.title}",
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 8),
            Text(
              "${menu.subtitle}",
              style: TextStyle(
                color: Color(0xff999999),
                fontSize: 11.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 参考书题库
  Widget _buildExamOther(SubjectPageModel model) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 16),
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Text("更多服务", style: TextStyle(fontSize: 16, color: Color(0xFF333333))),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _showPaperChoose(type: 'mistake', folderId: widget.subjectModel.id, title: widget.subjectModel.name);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 12, bottom: 12),
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
                        children: [
                          Image.asset(
                            "assets/images/menu_exam_mistake.png",
                            width: 48.0,
                            height: 48.0,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "错题集",
                            style: TextStyle(
                              color: Color(0xFF191919),
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ),
                SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      NavigatorManager.push(RanklistPage());
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 12, bottom: 12),
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
                        children: [
                          Image.asset(
                            "assets/images/menu_exam_ranklist.png",
                            width: 48.0,
                            height: 48.0,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "排行榜",
                            style: TextStyle(
                              color: Color(0xFF191919),
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                )
              ],
            )
          )
        ],
      ),
    );
  }

  // 开始刷题 需要选择类型的部分
  _showPaperChoose({String type, int folderId, String title}) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.white,
      isScrollControlled: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16))),
      builder: (BuildContext context) {
        return SizedBox(
          height: 145 + MSizeFit.bottomBarHeight,
          child: Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Column(
              children: [
                Text(
                  "请选择刷题方式",
                  style: TextStyle(fontSize: 16, color: Color(0xFF333333), fontWeight: FontWeight.w500)
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text("顺序刷题"),
                      color: Color(0xFF1F86FE),
                      disabledColor: Color(0xFFF8F8F8),
                      textColor: Colors.white,
                      disabledTextColor: Color(0xFFCCCCCC),
                      onPressed: () {
                        NavigatorManager.pop();
                        NavigatorManager.push(ExamPaperPage(
                          params: PaperParamsModel(
                            type: type,
                            title: title,
                            folderId: folderId,
                            random: 0
                          )
                        ));
                      }
                    ),
                    RaisedButton(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text("随机刷题"),
                      color: Color(0xFF1F86FE),
                      disabledColor: Color(0xFFF8F8F8),
                      textColor: Colors.white,
                      disabledTextColor: Color(0xFFCCCCCC),
                      onPressed: () {
                        NavigatorManager.pop();
                        NavigatorManager.push(ExamPaperPage(
                          params: PaperParamsModel(
                            type: type,
                            title: title,
                            folderId: folderId,
                            random: 1
                          )
                        ));
                      }
                    )
                  ],
                )
              ],
            ),
          )
        ); 
      },
    );
  }
}

