import 'package:boxApp/model/consult_model.dart';
import 'package:boxApp/model/exam_model.dart';
import 'package:boxApp/model/subject_model.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/page/exam/consult_add.dart';
import 'package:boxApp/page/exam/exam_user.dart';
import 'package:boxApp/page/subject/exam_list.dart';
import 'package:boxApp/page/subject/subject.dart';
import 'package:boxApp/page/exam/subject_add.dart';
import 'package:boxApp/provider/exam_home_model.dart';
import 'package:boxApp/widget/empty.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:boxApp/widget/section_header_vertical.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class ExamHomePage extends StatefulWidget {
  @override
  _ExamHomePageState createState() => _ExamHomePageState();
}

class _ExamHomePageState extends State<ExamHomePage>
with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<ExamHomeModel>(
      model: ExamHomeModel(),
      onModelInit: (model) {
        model.loadData();
      },
      builder: (context, model, child) {
        return LoadingContainer(
          loading: model.loading,
          error: model.error,
          retry: model.retry,
          child: CustomScrollView(
            slivers: [
              _buildHeaderCount(),
              // 已选科目      
              ..._buildSubjectList(model),
              // 已选参考书
              ..._buildConsultList(model),
              // 当前刷题     
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(top: 30.0, bottom: 0.0, left: 15.0, right: 15.0),
                  child: SectionHeaderVertical(
                    title: "当前·刷题",
                    subTitle: "考研1000道精选集；助力考研梦想",
                    action: InkWell(
                      onTap: () {
                        NavigatorManager.push(ExamUserPage(type: 'mistake',));
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
                        decoration: BoxDecoration(
                          // color: Color(0x1A1F86FE),
                          border: Border.all(color: Color(0xFF666666), width: 0.5),
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Image.asset(
                                  'assets/images/ic_more_right.png',
                                  width: 11.0,
                                  height: 11.0,
                                ),
                              ),                                  
                              TextSpan(
                                text: ' 我的错题',
                                style: TextStyle(fontSize: 11, color: Color(0xFF999999)),
                              ),
                            ]
                          )
                        )
                      )
                    )
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(left: 15, top: 0, right: 15, bottom: 10),
                sliver: model.recentExamList.length > 0 ? SliverFixedExtentList(
                  itemExtent: 80.0,
                  delegate: new SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return _buildExamItem(model.recentExamList[index]);
                    },
                    childCount: model.recentExamList.length
                  ),
                ) : SliverToBoxAdapter(
                  child: Empty(),
                ),
              ),
              // 为你推荐   
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 0.0, left: 15.0, right: 15.0),
                  child: SectionHeaderVertical(
                    title: "为你·推荐",
                    subTitle: "精选考研英语政治大纲「模块式分析」",
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(left: 15, top: 0, right: 15, bottom: 20),
                sliver: SliverFixedExtentList(
                  itemExtent: 120.0,
                  delegate: new SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return _buildRecommendItem();
                    },
                    childCount: 5
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 头部统计
  Widget _buildHeaderCount() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: 20.0),
        padding: EdgeInsets.only(top: 0.0, bottom: 0.0, left: 15.0, right: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  // margin: EdgeInsets.only(top: 12.0, bottom: 0.0, left: 15.0, right: 15.0),
                  alignment: Alignment.center,
                  child: Text(
                    "坚持天数",
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 12.0,
                      // fontWeight: FontWeight.bold
                    ),
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 0.0, left: 0.0, right: 0.0),
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '89',
                          style: TextStyle(fontSize: 36, color: Color(0xFF333333), fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '天',
                          style: TextStyle(fontSize: 11, color: Color(0xFF333333)),
                        ),
                      ]
                    )
                  )
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 0.0, left: 0.0, right: 0.0),
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Image.asset(
                              'assets/images/ic_more_right.png',
                              width: 5.0,
                              height: 14.0,
                            ),
                          ),
                          TextSpan(
                            text: ' 排名：',
                            style: TextStyle(fontSize: 13, color: Color(0xFF999999)),
                          ),
                          TextSpan(
                            text: '34223 ',
                            style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
                          ),
                          WidgetSpan(
                            child: Image.asset(
                              'assets/images/ic_more_right.png',
                              width: 5.0,
                              height: 14.0,
                            ),
                          ),       
                        ]
                      )
                    )
                  ),
                )
              ],
            ),
            Container(
              width: 1,
              height: 74,
              color: Color(0xFFEEEEEE),
              margin: EdgeInsets.only(left: 35.0, right: 35.0),
            ),
            Column(
              children: [
                Container(
                  // margin: EdgeInsets.only(top: 12.0, bottom: 0.0, left: 15.0, right: 15.0),
                  alignment: Alignment.center,
                  child: Text(
                    "累计刷题数",
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 12.0,
                      // fontWeight: FontWeight.bold
                    ),
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 0.0, left: 0.0, right: 0.0),
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '953',
                          style: TextStyle(fontSize: 36, color: Color(0xFF333333), fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '道',
                          style: TextStyle(fontSize: 11, color: Color(0xFF333333)),
                        ),
                      ]
                    )
                  )
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 0.0, left: 0.0, right: 0.0),
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Image.asset(
                              'assets/images/ic_more_right.png',
                              width: 5.0,
                              height: 14.0,
                            ),
                          ),                                  
                          TextSpan(
                            text: ' 排名：',
                            style: TextStyle(fontSize: 13, color: Color(0xFF999999)),
                          ),
                          TextSpan(
                            text: '34223 ',
                            style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
                          ),
                          WidgetSpan(
                            child: Image.asset(
                              'assets/images/ic_more_right.png',
                              width: 5.0,
                              height: 14.0,
                            ),
                          ),       
                        ]
                      )
                    )
                  ),
                )                
              ],
            ),
          ],
        )
      )
    );
  }

  // 科目部分
  List<Widget> _buildSubjectList(ExamHomeModel model) {
    return [
      SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.only(top: 30.0, bottom: 0.0, left: 15.0, right: 15.0),
          child: SectionHeaderVertical(
            title: "已选·科目",
            subTitle: "清华郝教授大课堂现场直播(^-^)",
            action: InkWell(
              onTap: () {
                NavigatorManager.push(ExamUserPage());
              },
              child: Container(
                padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 2.0),
                decoration: BoxDecoration(
                  // color: Color(0x1A1F86FE),
                  border: Border.all(color: Color(0xFF666666), width: 0.5),
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Image.asset(
                          'assets/images/ic_more_right.png',
                          width: 11.0,
                          height: 11.0,
                        ),
                      ),                                  
                      TextSpan(
                        text: ' 我的收藏',
                        style: TextStyle(fontSize: 11, color: Color(0xFF999999)),
                      ),
                    ]
                  )
                )
              )
            )
          ),
        ),
      ),   
      SliverPadding(
        padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 15.0),
        sliver: model.userSubjectList.length > 0 ? SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            ///九宫格的列数
            crossAxisCount: 2,
            ///子Widget 宽与高的比值
            childAspectRatio: 2.4,
            ///主方向的 两个 子Widget 之间的间距
            mainAxisSpacing: 10,
            /// 次方向 子Widget 之间的间距
            crossAxisSpacing: 10,
          ),
          ///子Item构建器
          delegate: new SliverChildBuilderDelegate(
            (BuildContext context, num index) {
              ///每一个子Item的样式
              return _buildSubjectItem(model.userSubjectList[index]);
            },
            ///子Item的个数
            childCount: model.userSubjectList.length,
          ),
        ) : SliverToBoxAdapter(
          child: Empty(),
        ),
      ),
      SliverToBoxAdapter(
        child: InkWell(
          onTap: () async { 
            await NavigatorManager.push(ExamSubjectAddPage());
            model.loadData();
          },
          child: Container(
            height: 30,
            margin: EdgeInsets.only(top: 0.0, bottom: 0.0, left: 15.0, right: 15.0),
            padding: EdgeInsets.fromLTRB(8, 1, 8, 1),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              // color: Color(0x1A1F86FE),
              border: Border.all(color: Color(0xFF1F86FE), width: 0.5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              "+ 添 加 科 目",
              style: TextStyle(
              color: Color(0xFF1F86FE),
              fontSize: 13.0,
              // fontWeight: FontWeight.bold
            ),
            )
          ),
        )
      )
    ];
  }

  // 参考书部分
  List<Widget> _buildConsultList(ExamHomeModel model) {
    return [
      SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.only(top: 30.0, bottom: 0.0, left: 15.0, right: 15.0),
          child: SectionHeaderVertical(
            title: "已选·参考书",
            // subTitle: "历年优质参考书(^-^)",
          ),
        ),
      ),   
      SliverPadding(
        padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 15.0),
        sliver: model.userConsultList.length > 0 ? SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            ///九宫格的列数
            crossAxisCount: 2,
            ///子Widget 宽与高的比值
            childAspectRatio: 2.4,
            ///主方向的 两个 子Widget 之间的间距
            mainAxisSpacing: 10,
            /// 次方向 子Widget 之间的间距
            crossAxisSpacing: 10,
          ),
          ///子Item构建器
          delegate: new SliverChildBuilderDelegate(
            (BuildContext context, num index) {
              ///每一个子Item的样式
              return _buildConsultItem(model.userConsultList[index]);
            },
            ///子Item的个数
            childCount: model.userConsultList.length,
          ),
        ) : SliverToBoxAdapter(
          child: Empty(),
        ),
      ),
      SliverToBoxAdapter(
        child: InkWell(
          onTap: () async { 
            await NavigatorManager.push(ExamConsultAddPage());
            model.loadData();
          },
          child: Container(
            height: 30,
            margin: EdgeInsets.only(top: 0.0, bottom: 0.0, left: 15.0, right: 15.0),
            padding: EdgeInsets.fromLTRB(8, 1, 8, 1),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              // color: Color(0x1A1F86FE),
              border: Border.all(color: Color(0xFF1F86FE), width: 0.5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              "+ 添 加 参 考 书",
              style: TextStyle(
              color: Color(0xFF1F86FE),
              fontSize: 13.0,
              // fontWeight: FontWeight.bold
            ),
            )
          ),
        )
      )
    ];
  }

  // 科目项
  Widget _buildSubjectItem(SubjectModel item) {
    return InkWell(
      onTap: () {
        NavigatorManager.push(ExamSubjectPage(subjectModel: item));
      },
      child: Container(
        padding: EdgeInsets.only(top: 12.0, bottom: 12.0, left: 12.0, right: 12.0),
        alignment: Alignment.centerLeft,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Text(
                "${item.name}",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 14.0,
                  // fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0),
              child: Text(
                "科目代码：${item.code}",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 11.0,
                  // fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  // 参考书项
  Widget _buildConsultItem(ConsultModel item) {
    return InkWell(
      onTap: () {
        NavigatorManager.push(ExamListPage(consultModel: item, title: item.name));
      },
      child: Container(
        padding: EdgeInsets.only(top: 12.0, bottom: 12.0, left: 12.0, right: 12.0),
        alignment: Alignment.centerLeft,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Text(
                "${item.name}",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 14.0,
                  // fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0),
              child: Text(
                "${item.description}",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 11.0,
                  // fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  // 题库项
  Widget _buildExamItem(ExamModel item) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(top: 12.0),
        padding: EdgeInsets.only(top: 12.0, bottom: 12.0, left: 12.0, right: 12.0),
        alignment: Alignment.centerLeft,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Text(
                "${item.name}",
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 14.0,
                  // fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '当前学习进度：',
                          style: TextStyle(fontSize: 11, color: Color(0xFF333333)),
                        ),
                        TextSpan(
                          text: '86%',
                          style: TextStyle(fontSize: 12, color: Color(0xFFFE1F41), fontWeight: FontWeight.bold),
                        ),
                      ]
                    )
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 1, 8, 1),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      // color: Color(0x1A1F86FE),
                      border: Border.all(color: Color(0xFF1F86FE), width: 0.5),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      "继续刷题",
                      style: TextStyle(
                        color: Color(0xFF1F86FE),
                        fontSize: 12.0,
                        // fontWeight: FontWeight.bold
                      ),
                    ),
                  ),       
                ],
              )
            ),
          ],
        ),
      )
    );
  }

  // 推荐项
  Widget _buildRecommendItem() {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(top: 12.0),
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png",
            fit: BoxFit.cover,
          )
        ),  
      )    
    );
  }  

  @override
  bool get wantKeepAlive => true;
}
