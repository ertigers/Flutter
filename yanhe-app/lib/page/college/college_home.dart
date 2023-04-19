import 'package:boxApp/page/course/course_list_simple.dart';
import 'package:boxApp/page/exam/exam_list_simple.dart';
import 'package:boxApp/page/info/info_list_simple.dart';
import 'package:boxApp/page/material/material_list_simple.dart';
import 'package:boxApp/page/senior/senior_list_simple.dart';
import 'package:boxApp/provider/college_home_model.dart';
import 'package:boxApp/widget/course_list_item.dart';
import 'package:boxApp/widget/course_live_item.dart';
import 'package:boxApp/widget/exam_list_item.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:boxApp/widget/material_list_item.dart';
import 'package:boxApp/widget/info_list_item.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:boxApp/widget/section_header.dart';
import 'package:boxApp/widget/senior_list_item.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/nav_router/manager.dart';


class CollegeHomePage extends StatefulWidget {
  @override
  _CollegeHomePageState createState() => _CollegeHomePageState();
}

class _CollegeHomePageState extends State<CollegeHomePage>
with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController = ScrollController();
  CollegeHomeModel _model;
  GlobalKey _scrollKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    // 监听滚动事件，打印滚动位置
    _scrollController.addListener((){
      // 打印滚动位置
      // print(_scrollController.offset);
      _anchorChange(offsetTop: _scrollController.offset, model: _model);
    });
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<CollegeHomeModel>(
      model: CollegeHomeModel(),
      onModelInit: (model) {
        // model.loadData();
        _model = model;
      },
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child: CustomScrollView(
              key: _scrollKey,
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      _buildHeader(),
                      // 菜单栏部分
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        // color: Colors.red,
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: model.anchorList.map((anchor) => _buildAnchorItem(anchor: anchor, model: model)).toList(),
                        )
                      ),
                      // 公开课程
                      ..._buildPublicCourse(model)
                    ],
                  ),
                ),
                // 院校资讯
                ..._buildInfo(model), 
                // 学长经验
                ..._buildExperience(model),
                // 专业题库
                ..._buildExam(model),
                // 讲义资料
                ..._buildMaterial(model),
                // 小班课程
                ..._buildSmallCourse(model),
                // 全科定制
                ..._buildCustomize(model),
                // 学长学姐
                ..._buildSenior(model),

                SliverPadding(padding: EdgeInsets.only(top: 20))
              ],
            )
          )
        );
      },
    );
  }

  void _anchorChange({double offsetTop, CollegeHomeModel model}) {
    final RenderBox scrollBox = _scrollKey.currentContext.findRenderObject();
    for (var i = 0; i < model.anchorList.length; i++) {
      AnchorModel anchor = model.anchorList[i];
      final RenderBox renderBox = anchor.key.currentContext.findRenderObject();
      if (renderBox != null) {
        Offset offset = renderBox.localToGlobal(Offset.zero, ancestor: scrollBox);
        if (offsetTop > offset.dy + offsetTop) {
          anchor.active = true;
          model.setAnchorActive(anchor);
        }
      }
    }
  }

  // 面包屑导航项
  Widget _buildAnchorItem({AnchorModel anchor, CollegeHomeModel model}) {
    return InkWell(
      onTap: () {
        anchor.active = true;
        model.setAnchorActive(anchor);

        final RenderBox renderBox = anchor.key.currentContext.findRenderObject();
        if (renderBox != null) {
          Offset offset = renderBox.localToGlobal(Offset.zero);
          _scrollController.animateTo(
            offset.dy - 100,
            // 返回顶部的过程中执行一个滚动动画，动画时间是200毫秒，动画曲线是Curves.ease
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          );
        }
      },
      child: Container(
        width: 80,
        height: 40,
        alignment: Alignment.center,   
        decoration: BoxDecoration(
          border: Border.all(color: anchor.active ? Color(0xFF1F86FE) : Colors.transparent, width: 0.5),
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: [
            BoxShadow(
              color: Color(0x1A1F86FE),
              offset: Offset(0.0, 5.0), //阴影xy轴偏移量
              blurRadius: 15.0, //阴影模糊程度
              spreadRadius: 1.0 //阴影扩散程度
            )
          ]          
        ),
        child: Text(
          "${anchor.name}",
          style: TextStyle(
            color: anchor.active ? Color(0xFF1F86FE) : Color(0xFF333333),
            fontSize: 13.0,
            // fontWeight: FontWeight.bold
          ),
        )
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 160,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset("assets/images/bg_college_01.png", fit: BoxFit.cover)
              // child: CachedNetworkImage(
              //   imageUrl: "http://img.koudaikaoyan.com/da6f6840f45e4e1baf65f918f5cbbf38.png",
              //   fit: BoxFit.cover,
              // )
            )
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "上海工业大学",
                  style: TextStyle(
                    color: Color(0xFFFBF5DE),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Shanghai University of Technology",
                  style: TextStyle(
                    color: Color(0xFFFBF5DE),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "院校类别：",
                          style: TextStyle(
                            color: Color(0xFFFF885A),
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "985、211院校",
                          style: TextStyle(
                            color: Color(0xFFFBF5DE),
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "创建时间：",
                          style: TextStyle(
                            color: Color(0xFFFF885A),
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "1948年",
                          style: TextStyle(
                            color: Color(0xFFFBF5DE),
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "院校人数：",
                          style: TextStyle(
                            color: Color(0xFFFF885A),
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "9.8w",
                          style: TextStyle(
                            color: Color(0xFFFBF5DE),
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            width: 80,
            child: InkWell(
              onTap: () {
                print("分享");
              },
              child: ClipRRect(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6), topRight: Radius.circular(6)),
                child: Container(
                  padding: EdgeInsets.only(left: 4, top: 5, right: 4, bottom: 5),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF42BBFF), Color(0xFF1F86FE)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  ),
                  alignment: AlignmentDirectional.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Image.asset(
                            'assets/images/ic_share_02.png',
                            width: 13.0,
                            height: 13.0,
                          ),
                        ),
                        TextSpan(
                          text: ' 分享',
                          style: TextStyle(fontSize: 13, color: Color(0xFFFFFFFF)),
                        ),   
                      ]
                    )
                  )
                )
              ),
            )
          )
        ],
      )
    );
  }

  // 公开课程
  List<Widget> _buildPublicCourse(CollegeHomeModel model) {
    AnchorModel anchor = model.getAnchor('公开课程');
    return [
      Container(
        key: anchor?.key,
        margin: EdgeInsets.only(top: 28.0, bottom: 0.0, left: 15.0, right: 15.0),
        child: SectionHeader(
          title: "公开·课程",
          more: () {
            NavigatorManager.push(CourseListSimplePage(title: "公开课程"));
          },
        ),
      ),
      SizedBox(height: 20.0),
      Container(
        height: 200,
        child: ListView.builder(
          itemCount: model.publiceCourseList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return CourseLiveItem(
              course: model.publiceCourseList[index],
              last: index == model.publiceCourseList.length - 1
            );
          }
        ),
      )
    ];
  }

  // 院校资讯
  List<Widget> _buildInfo(CollegeHomeModel model) {
    AnchorModel anchor = model.getAnchor('院校资讯');
    return [
      SliverToBoxAdapter(
        child: Container(
          key: anchor?.key,
          margin: EdgeInsets.only(top: 15.0, bottom: 0.0, left: 15.0, right: 15.0),
          child: SectionHeader(
            title: "院校·资讯",
            more: () {
              NavigatorManager.push(InfoListSimplePage(title: "院校资讯"));
            }
          ),
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.only(top: 8.0, bottom: 0.0, left: 15.0, right: 15.0),
        sliver: SliverFixedExtentList(
          itemExtent: 160.0,
          delegate: new SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(top: 12),
                child: InfoListItem(info: model.infoList[index])
              );
            },
            childCount: model.infoList.length
          ),
        ),
      )
    ];
  }

  // 学长经验
  List<Widget> _buildExperience(CollegeHomeModel model) {
    AnchorModel anchor = model.getAnchor('学长经验');
    return [
      SliverToBoxAdapter(
        child: Container(
          key: anchor?.key,
          margin: EdgeInsets.only(top: 28.0, bottom: 0.0, left: 15.0, right: 15.0),
          child: SectionHeader(
            title: "学长·经验",
            more: () {
              NavigatorManager.push(InfoListSimplePage(title: "学长经验"));
            }
          ),
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.only(top: 8.0, bottom: 0.0, left: 15.0, right: 15.0),
        sliver: SliverFixedExtentList(
          itemExtent: 160.0,
          delegate: new SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(top: 12),
                child: InfoListItem(info: model.experienceList[index])
              );
            },
            childCount: model.experienceList.length
          ),
        )
      )
    ];
  }

  // 专业题库
  List<Widget> _buildExam(CollegeHomeModel model) {
    AnchorModel anchor = model.getAnchor('专业题库');
    return [
      SliverToBoxAdapter(
        child: Container(
          key: anchor?.key,
          margin: EdgeInsets.only(top: 28.0, bottom: 0.0, left: 15.0, right: 15.0),
          child: SectionHeader(
            title: "专业·题库",
            more: () {
              NavigatorManager.push(ExamListSimplePage(title: "专业题库"));
            }
          ),
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.only(top: 8.0, bottom: 0.0, left: 15.0, right: 15.0),
        sliver: SliverFixedExtentList(
          itemExtent: 160.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(top: 12),
                child: ExamListItem(
                  exam: model.examList[index],
                )
              );
            },
            childCount: model.smallCourseList.length
          ),
        )
      )
    ];
  }

  // 讲义资料
  List<Widget> _buildMaterial(CollegeHomeModel model) {
    AnchorModel anchor = model.getAnchor('讲义资料');
    return [
      SliverToBoxAdapter(
        child: Container(
          key: anchor?.key,
          margin: EdgeInsets.only(top: 28.0, bottom: 0.0, left: 15.0, right: 15.0),
          child: SectionHeader(
            title: "讲义·资料",
            more: () {
              NavigatorManager.push(MaterialListSimplePage());
            }
          ),
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.only(top: 8.0, bottom: 0.0, left: 15.0, right: 15.0),
        sliver: SliverFixedExtentList(
          itemExtent: 160.0,
          delegate: new SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(top: 12),
                child: MaterialListItem(
                  material: model.materialList[index]
                )
              );
            },
            childCount: model.smallCourseList.length
          ),
        )
      )
    ];
  }

  // 小班课程
  List<Widget> _buildSmallCourse(CollegeHomeModel model) {
    AnchorModel anchor = model.getAnchor('小班课程');
    return [
      SliverToBoxAdapter(
        child: Container(
          key: anchor?.key,
          margin: EdgeInsets.only(top: 28.0, bottom: 0.0, left: 15.0, right: 15.0),
          child: SectionHeader(
            title: "小班·课程",
            more: () {
              NavigatorManager.push(CourseListSimplePage(title: "小班课程"));
            }
          ),
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.only(top: 8.0, bottom: 0.0, left: 15.0, right: 15.0),
        sliver: SliverFixedExtentList(
          itemExtent: 160.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(top: 12),
                child: CourseListItem(
                  course: model.smallCourseList[index]
                )
              );
            },
            childCount: model.smallCourseList.length
          ),
        )
      )
    ];
  }

  // 全科定制
  List<Widget> _buildCustomize(CollegeHomeModel model) {
    AnchorModel anchor = model.getAnchor('全科定制');
    return [
      SliverToBoxAdapter(
        child: Container(
          key: anchor?.key,
          margin: EdgeInsets.only(top: 28.0, bottom: 0.0, left: 15.0, right: 15.0),
          child: SectionHeader(
            title: "全科·定制",
            more: () {
              NavigatorManager.push(CourseListSimplePage(title: "全科定制"));
            }
          ),
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.only(top: 8.0, bottom: 0.0, left: 15.0, right: 15.0),
        sliver: SliverFixedExtentList(
          itemExtent: 160.0,
          delegate: new SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(top: 12),
                child: CourseListItem(
                  course: model.customizeList[index]
                )
              );
            },
            childCount: model.customizeList.length
          ),
        )
      )
    ];
  }

  // 学长学姐
  List<Widget> _buildSenior(CollegeHomeModel model) {
    AnchorModel anchor = model.getAnchor('学长学姐');
    return [
      SliverToBoxAdapter(
        child: Container(
          key: anchor?.key,
          margin: EdgeInsets.only(top: 28.0, bottom: 0.0, left: 15.0, right: 15.0),
          child: SectionHeader(
            title: "学长·学姐",
            more: () {
              NavigatorManager.push(SeniorListSimplePage());
            }
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        sliver: SliverGrid( //Grid
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //Grid按两列显示
            mainAxisSpacing: 12.0,
            crossAxisSpacing: 12.0,
            childAspectRatio: 1.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return SeniorListItem(
                senior: model.seniorList[index]
              );
            },
            childCount: model.seniorList.length
          ),
        ),
      ),
    ];
  }

  @override
  bool get wantKeepAlive => true;
}
