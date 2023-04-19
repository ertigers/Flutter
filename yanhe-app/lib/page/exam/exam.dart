import 'package:boxApp/config/color.dart';
import 'package:flutter/material.dart';

import 'exam_home.dart';
import 'exam_simulate.dart';

const TAB_LABEL = ['题库', '模考'];

class ExamPage extends StatefulWidget {
  @override
  _ExamPageState createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage>
with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  TabController _tabController;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    print('ExamPage初始化方法...');
    _tabController = TabController(length: TAB_LABEL.length, vsync: this);
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
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0,
        title: Container(
          height: 32,
          alignment: Alignment.centerLeft,
          child: TabBar(
            isScrollable: true,
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: MColor.hitTextColor,
            labelStyle: TextStyle(fontSize: 20, color: Color(0xFF333333)),
            unselectedLabelStyle: TextStyle(fontSize: 18, color: Color(0xFF333333)),
            indicatorColor: Color(0xFF1F86FE),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: TAB_LABEL.map((String label) {
              return Tab(text: label);
            }).toList(),
            onTap: (index) => _pageController.animateToPage(index,
                duration: kTabScrollDuration, curve: Curves.ease)
          ),
        ),
      ),  
      body: Container(
        color: Colors.white,
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) => _tabController.index = index,
          children: <Widget>[
            ExamHomePage(),
            ExamSimulatePage()
          ]
        ),
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}
