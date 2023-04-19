import 'package:boxApp/provider/home_page_model.dart';
import 'package:boxApp/util/size_fit.dart';
import 'package:boxApp/widget/course_list_item.dart';
import 'package:boxApp/widget/common_menu_item.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:boxApp/widget/material_list_item.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:boxApp/widget/section_header.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
    print('HomePage初始化方法...');
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<HomePageModel>(
      model: HomePageModel(),
      onModelInit: (model) {
        // model.loadData();
      },
      builder: (context, model, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: LoadingContainer(
              loading: model.loading,
              error: model.error,
              retry: model.retry,
              child: CustomScrollView(
                slivers: [
                  SliverPadding(padding: EdgeInsets.only(top: MSizeFit.statusBarHeight)),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        _buildTop(),
                        _buildBanner(),
                        // 菜单栏部分
                        Container(
                          margin: EdgeInsets.only(top: 28.0, bottom: 28, left: 0, right: 0),
                          // color: Colors.red,
                          child: Wrap(
                            spacing: 48,
                            children: model.menuList.map((item) => CommonMenuItem(menu: item)).toList(),
                          )
                        ),
                      ],
                    ),
                  ),
                  // 热门推荐                
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(top: 8.0, bottom: 0.0, left: 15.0, right: 15.0),
                      child: SectionHeader(
                        title: "推荐·课程",
                        more: Text("")
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
                              course: model.hotCourseList[index]
                            )
                          );
                        },
                        childCount: model.hotCourseList.length
                      ),
                    )
                  ),
                  // 学科               
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(top: 30.0, bottom: 0.0, left: 15.0, right: 15.0),
                      child: SectionHeader(
                        title: "热门·资料",
                        more: Text("")
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
                        childCount: model.materialList.length
                      ),
                    ),
                  ),
                  SliverPadding(padding: EdgeInsets.only(top: MSizeFit.statusBarHeight + 20)),
                ],
              )
            )
          )
        );
      },
    );
  }

  Widget _buildTop() {
    return Container(
      margin: EdgeInsets.only(left: 15, top: 15, right: 15),
      padding: EdgeInsets.only(left: 8, top: 5, right: 15, bottom: 5),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg_date_01.png"),
          fit: BoxFit.cover
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("78", style: TextStyle(fontSize: 30, color: Color(0xFF1F86FE), fontWeight: FontWeight.bold)),
          SizedBox(width: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("DAY", style: TextStyle(fontSize: 10, color: Color(0xFF070000))),
              Text("距下次考研", style: TextStyle(fontSize: 11, color: Color(0xFF070000))),
            ],
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.only(left: 8, top: 4, right: 8, bottom: 4),
            decoration: BoxDecoration(
              // color: Color(0x1A1F86FE),
              border: Border.all(color: Color(0xFF1F86FE), width: 1),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text("Tuesday", style: TextStyle(fontSize: 11, color: Color(0xFF1F86FE), fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      margin: EdgeInsets.only(left: 15, top: 15, right: 15),
      // padding: EdgeInsets.only(),
      height: 160,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        child: Swiper(
          itemBuilder: (BuildContext context,int index){
            return ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              child: Image.network("http://img.koudaitiku.com/003ecad9f1714914bd347a706d66758a.png",fit: BoxFit.fill,)
            );
          },
          itemCount: 3,
          autoplay: true,
          pagination: SwiperPagination(
            alignment: Alignment.bottomCenter,
            builder: DotSwiperPaginationBuilder(
              color: Color.fromRGBO(
                  255, 255, 255, 0.6),
              size: 6,
              activeSize: 6
            )
          ),
        ),
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}
