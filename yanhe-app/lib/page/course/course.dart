import 'package:boxApp/page/course/course_list.dart';
import 'package:boxApp/provider/course_page_model.dart';
import 'package:boxApp/widget/course_list_item.dart';
import 'package:boxApp/widget/course_live_item.dart';
import 'package:boxApp/widget/common_menu_item.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:boxApp/widget/search_bars/search_bars.dart';
import 'package:boxApp/widget/section_header.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/nav_router/manager.dart';

class CoursePage extends StatefulWidget {
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage>
with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
    print('CoursePage初始化方法...');
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<CoursePageModel>(
      model: CoursePageModel(),
      onModelInit: (model) {
        // model.loadData();
      },
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('课程中心', style: TextStyle(fontSize: 20, color: Colors.black)),
            centerTitle: false,
            backgroundColor: Colors.white,
            elevation: 0,
            brightness: Brightness.light
          ),
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // 搜索框 仅展示作用
                      SearchStaticBar(
                        heroTag: "courseSearchBar",
                        hint: "请输入您想查找的课程",
                        margin: EdgeInsets.only(top: 8.0, bottom: 0.0, left: 15.0, right: 15.0),
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10.0, right: 10.0),
                        clickCallBack: () {
                          NavigatorManager.push(CourseListPage(autofocus: true));
                        },
                      ),
                      // 菜单栏部分
                      Container(
                        margin: EdgeInsets.only(top: 30.0),
                        // color: Colors.red,
                        child: Wrap(
                          spacing: 48,
                          runSpacing: 24,
                          children: model.menuList.map((item) => CommonMenuItem(menu: item)).toList(),
                        )
                      ),
                      // 精品直播课
                      Container(
                        margin: EdgeInsets.only(top: 28.0, bottom: 0.0, left: 15.0, right: 15.0),
                        child: SectionHeader(
                          title: "精品·直播课",
                          more: () {
                            NavigatorManager.push(CourseListPage());
                          },
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        height: 200,
                        child: ListView.builder(
                          itemCount: model.liveCourseList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CourseLiveItem(
                              course: model.liveCourseList[index],
                              last: index == model.liveCourseList.length - 1
                            );
                          }
                        ),
                      )
                    ],
                  ),
                ),
                // 热门推荐                
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(top: 8.0, bottom: 0.0, left: 15.0, right: 15.0),
                    child: SectionHeader(
                      title: "热门推荐"
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(left: 15, top: 8, right: 15),
                  sliver: SliverFixedExtentList(
                    itemExtent: 160.0,
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(top: 12),
                          child: CourseListItem(
                            course: model.hotCourseList[index],
                          )
                        );
                      },
                      childCount: model.hotCourseList.length
                    ),
                  )
                ),
                SliverToBoxAdapter(
                  child: InkWell(
                    onTap: () {
                      NavigatorManager.push(CourseListPage());
                    },
                    child: Container(
                      height: 39,
                      margin: EdgeInsets.only(top: 12.0, bottom: 20.0, left: 15.0, right: 15.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0x1A1F86FE),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        "查看全部",
                        style: TextStyle(
                          color: Color(0xFF1F86FE),
                          fontSize: 14.0,
                          // fontWeight: FontWeight.bold
                        ),
                      )
                    ),
                  )
                ),
                // 学科               
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(top: 30.0, bottom: 0.0, left: 15.0, right: 15.0),
                    child: SectionHeader(
                      title: "学科",
                      subTitle: "点击进入，立即开始针对性刷题",
                      more: () {
                        NavigatorManager.push(CourseListPage());
                      },
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(left: 15, top: 8, right: 15),
                  sliver: SliverFixedExtentList(
                    itemExtent: 160.0,
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(top: 12),
                          child: CourseListItem(
                            course: model.hotCourseList[index],
                          )
                        );
                      },
                      childCount: model.hotCourseList.length
                    ),
                  )
                ),
                SliverToBoxAdapter(
                  child: InkWell(
                    onTap: () {
                      NavigatorManager.push(CourseListPage());
                    },
                    child: Container(
                      height: 39,
                      margin: EdgeInsets.only(top: 12.0, bottom: 20.0, left: 15.0, right: 15.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0x1A1F86FE),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        "查看全部",
                        style: TextStyle(
                          color: Color(0xFF1F86FE),
                          fontSize: 14.0,
                          // fontWeight: FontWeight.bold
                        ),
                      )
                    ),
                  )
                ),
              ],
            )
          )
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
