import 'package:boxApp/page/college/college_home.dart';
import 'package:boxApp/page/college/college_major.dart';
import 'package:flutter/material.dart';

const TAB_LABEL = ['院校', '专业'];

class CollegePage extends StatefulWidget {
  @override
  _CollegePageState createState() => _CollegePageState();
}

class _CollegePageState extends State<CollegePage>
with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    print('CollegePage初始化方法...');

    _tabController = TabController(initialIndex: _currentIndex, length: TAB_LABEL.length, vsync: this);
     _pageController = PageController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: false,
        title: SizedBox(
          height: 36,
          child: TabBar(
            isScrollable: true,
            //是否可以滚动
            controller: _tabController,
            labelColor: Color(0xFF333333),
            labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            unselectedLabelColor: Color(0xFF666666),
            unselectedLabelStyle: TextStyle(fontSize: 16),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.only(left: 5, right: 5),
            tabs: TAB_LABEL.map((String label) {
              return Tab(text: label);
            }).toList(),
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
              _pageController.animateToPage(index, duration: kTabScrollDuration, curve: Curves.ease);
            },
          ),
        ),
        actions: [
          Offstage(
            offstage: _currentIndex != 0,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(left: 8.0, top: 8, right: 23, bottom: 8),
                alignment: Alignment.center,
                child: Text("切换院校", style: TextStyle(fontSize: 14, color: Color(0xFF333333))),
              )
            )
          ),
          Offstage(
            offstage: _currentIndex != 1,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(left: 8.0, top: 8, right: 23, bottom: 8),
                alignment: Alignment.center,
                child: Text("切换专业", style: TextStyle(fontSize: 14, color: Color(0xFF333333))),
              )
            )
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          _tabController.index = index;
        },
        children: <Widget>[
          CollegeHomePage(),
          CollegeMajorPage()
        ]
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}
