import 'package:boxApp/page/course/detail_chapter_copy.dart';
import 'package:boxApp/page/course/detail_info.dart';
import 'package:boxApp/page/course/detail_teacher.dart';
import 'package:boxApp/provider/course_detail_model.dart';
import 'package:boxApp/util/size_fit.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

const TAB_LABEL = ['课程详情', '课程大纲', '授课教师'];

class CourseDetailPage extends StatefulWidget {
  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage>
with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(initialIndex: _currentIndex, length: TAB_LABEL.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<CourseDetailModel>(
      model: CourseDetailModel(1),
      onModelInit: (model) {
        // model.loadData();
      },
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('课程详情', style: TextStyle(fontSize: 18, color: Colors.black)),
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
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: <Widget>[
                    _buildHeader(),
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.white,
                      toolbarHeight: 36,
                      pinned: true,
                      titleSpacing: 0,
                      title: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.5, color: Color(0xFFEEEEEE))),
                        ),
                        child: SizedBox(
                          height: 36,
                          child: TabBar(
                            isScrollable: false, //是否可以滚动
                            controller: _tabController,
                            labelColor: Color(0xFF333333),
                            labelStyle: TextStyle(fontSize: 16),
                            labelPadding: EdgeInsets.only(left: 25, top: 0, right: 25, bottom: 0),
                            unselectedLabelColor: Color(0xFF999999),
                            unselectedLabelStyle: TextStyle(fontSize: 16),
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorPadding: EdgeInsets.only(left: 15, right: 15),
                            tabs: TAB_LABEL.map((String label) {
                              return Tab(text: "${label}");
                            }).toList(),
                            onTap: (index) {
                              setState(() {                                
                                _currentIndex = index;
                              });
                            },
                          ),
                        ),
                      )
                    ),
                    // SliverOffstage(
                    //   offstage: _currentIndex != 0,
                    //   sliver: SliverToBoxAdapter(
                    //     child: CourseDetailInfo(),
                    //   ),
                    // ),
                    // SliverOffstage(
                    //   offstage: _currentIndex != 1,
                    //   sliver: SliverToBoxAdapter(
                    //     child: CourseDetailChapter(),
                    //   ),
                    // ),
                    // SliverOffstage(
                    //   offstage: _currentIndex != 2,
                    //   sliver: SliverToBoxAdapter(
                    //     child: CourseDetailTeacher(),
                    //   ),
                    // ),
                    SliverFillRemaining(
                      // fillOverscroll: true,
                      // hasScrollBody: false,
                      child: TabBarView(
                        controller: _tabController,
                        physics: ScrollPhysics(),
                        children: [
                          CourseDetailInfo(),
                          CourseDetailChapter(),
                          CourseDetailTeacher()
                        ],
                      ),
                    ),
                    SliverPadding(padding: EdgeInsets.only(bottom: 50))
                  ],
                ),
                Positioned(
                  height: MSizeFit.bottomBarHeight + 50,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _buildBottom(),
                )
              ],
            )
          )
        );
      },
    );
  }

  Widget _buildHeader() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: "http://img.koudaitiku.com/003ecad9f1714914bd347a706d66758a.png",
            fit: BoxFit.cover,
          ),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg_course_countdown.png"),
                fit: BoxFit.cover
              )
            ),
            // child: Text(
            //   "免费学习",
            //   style: TextStyle(
            //     color: Color(0xFFffffff),
            //     fontSize: 11.0,
            //     fontWeight: FontWeight.bold
            //   ),
            // ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, top: 20, right: 15, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "2021年英语四级考前系统班",
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "最优课程的讲解方式，全新的角度，最广泛的思考模式…",
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 12.0,
                    // fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, bottom: 15),
                  height: 0.5,
                  color: Color(0xffeeeeee)
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "有效期 2020-12-31     120课时",
                      style: TextStyle(
                        color: Color(0xFF666666),
                        fontSize: 14.0,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '¥',
                            style: TextStyle(fontSize: 14, color: Color(0xFFFE1F41))
                          ),
                          TextSpan(
                            text: '8826',
                            style: TextStyle(fontSize: 18, color: Color(0xFFFE1F41), fontWeight: FontWeight.bold)
                          ),
                          TextSpan(
                            text: '.90',
                            style: TextStyle(fontSize: 14, color: Color(0xFFFE1F41))
                          ),
                        ]
                      )
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 8,
            color: Color(0xFFF5F5F5)
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 0.5, color: Color(0xFFEEEEEE))),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 15),
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '¥',
                          style: TextStyle(fontSize: 14, color: Color(0xFFFE1F41))
                        ),
                        TextSpan(
                          text: '8826',
                          style: TextStyle(fontSize: 18, color: Color(0xFFFE1F41), fontWeight: FontWeight.bold)
                        ),
                        TextSpan(
                          text: '.90',
                          style: TextStyle(fontSize: 14, color: Color(0xFFFE1F41))
                        ),
                      ]
                    )
                  ),
                  SizedBox(height: 2),
                  Text(
                    "已售：3470人",
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            )
          ),
          Container(
            child: Column(
              children: [],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 112,
            height: 50,
            color: Color(0xFFFE1F41),
            child: Text(
              "立即抢购",
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 17.0,
              ),
            ),
          )
        ],
      ),
    );
  }

}
