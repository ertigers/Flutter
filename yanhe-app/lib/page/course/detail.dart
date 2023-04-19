import 'package:boxApp/model/course_model.dart';
import 'package:boxApp/page/course/detail_chapter.dart';
import 'package:boxApp/page/course/detail_info.dart';
import 'package:boxApp/page/course/detail_teacher.dart';
import 'package:boxApp/page/order/customer_service.dart';
import 'package:boxApp/page/order/buy.dart';
import 'package:boxApp/provider/course_detail_model.dart';
import 'package:boxApp/util/date_util.dart';
import 'package:boxApp/util/size_fit.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/nav_router/manager.dart';

const TAB_LABEL = ['课程详情', '课程大纲', '授课教师'];

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      // height: 40,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5, color: Color(0xFFEEEEEE))),
        color: Colors.white
      ),
      child: this.child
    );
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class CourseDetailPage extends StatefulWidget {
  int courseId;

  CourseDetailPage({Key key, @required this.courseId}) : super(key: key);

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage>
with SingleTickerProviderStateMixin {
  CourseDetailModel courseDetailModel;
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: TAB_LABEL.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<CourseDetailModel>(
      model: CourseDetailModel(widget.courseId),
      onModelInit: (model) {
        courseDetailModel = model;
        model.loadData();
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
                NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      _buildHeader(model.courseModel),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: StickyTabBarDelegate(
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
                          ),
                        ),
                      ),
                    ];
                  },
                  body: Container(
                    padding: EdgeInsets.only(bottom: MSizeFit.bottomBarHeight + 50),
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        CourseDetailInfo(courseModel: model.courseModel),
                        CourseDetailChapter(chapterList: model.chapterList),
                        CourseDetailTeacher(teacherList: model.teacherList)
                      ],
                    ),
                  ),
                ),
                Positioned(
                  height: MSizeFit.bottomBarHeight + 50,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _buildBottom(model.courseModel),
                )
              ],
            )
          )
        );
      },
    );
  }

  Widget _buildHeader(CourseModel course) {
    return SliverToBoxAdapter(
      child: course == null ? Container() : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: course.cover,
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
                  "${course.name}",
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  course.description ?? "",
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
                      "有效期 ${DateUtils.formatDateMs(course.expireTime, format: 'yyyy-MM-dd')}     ${course.hours}课时",
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
                            text: '${course.price}',
                            style: TextStyle(fontSize: 18, color: Color(0xFFFE1F41), fontWeight: FontWeight.bold)
                          ),
                          // TextSpan(
                          //   text: '.90',
                          //   style: TextStyle(fontSize: 14, color: Color(0xFFFE1F41))
                          // ),
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

  Widget _buildBottom(CourseModel course) {
    return course == null ? Container() : Container(
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
                          text: "${course.price}",
                          style: TextStyle(fontSize: 18, color: Color(0xFFFE1F41), fontWeight: FontWeight.bold)
                        ),
                        // TextSpan(
                        //   text: '.90',
                        //   style: TextStyle(fontSize: 14, color: Color(0xFFFE1F41))
                        // ),
                      ]
                    )
                  ),
                  SizedBox(height: 2),
                  Text(
                    "已售：${course.userCount ?? 0}人",
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
            margin: EdgeInsets.only(top: 8),
            width: 1,
            height: 34,
            color: Color(0xffeeeeee)
          ),
          InkWell(
            onTap: () {
              NavigatorManager.push(CustomerServicePage());
            },
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/ic_service.png', width: 22, height: 22),
                  SizedBox(height: 2),
                  Text(
                    "客服",
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              NavigatorManager.push(BuyPage());
            },
            child: Container(
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
            ),
          )
        ],
      ),
    );
  }

}
