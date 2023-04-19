import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/page/auth/login.dart';
import 'package:boxApp/util/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:boxApp/config/string.dart';
import 'package:boxApp/page/home/home.dart';
import 'package:boxApp/page/college/college.dart';
import 'package:boxApp/page/course/course.dart';
import 'package:boxApp/page/exam/exam.dart';
import 'package:boxApp/page/mine/mine.dart';
import 'package:boxApp/util/toast_util.dart';

class TabNavigation extends StatefulWidget {
  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  DateTime lastTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[HomePage(), CollegePage(), CoursePage(), ExamPage(), MinePage()],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              final token = AppManager.prefs.getString('token');
              // 未登录
              if (token == null) {
                // 我的题库 必须登录
                if (index == 3) {
                  NavigatorManager.push(LoginPage());
                  return;
                }                
              }
              
              _pageController.jumpToPage(index); //跳转到指定页面
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed, //显示标题
            items: [
              _bottomItem(MString.home, 'assets/images/ic_home_normal.png',
                  'assets/images/ic_home_selected.png', 0),
              _bottomItem(MString.college, 'assets/images/ic_college_normal.png',
                  'assets/images/ic_college_selected.png', 1),
              _bottomItem(MString.course, 'assets/images/ic_course_normal.png',
                  'assets/images/ic_course_selected.png', 2),
              _bottomItem(MString.exam, 'assets/images/ic_exam_normal.png',
                  'assets/images/ic_exam_selected.png', 3),
              _bottomItem(MString.mine, 'assets/images/ic_mine_normal.png',
                  'assets/images/ic_mine_selected.png', 4)
            ]),
        ),
        onWillPop: _onWillPop);
  }

  Future<bool> _onWillPop() async {
    if (lastTime == null ||
        DateTime.now().difference(lastTime) > Duration(seconds: 2)) {
      lastTime = DateTime.now();
      ToastUtils.showTip(MString.exit_tip);
      return false;
    } else {
      SystemNavigator.pop();
      return true;
    }
  }

  _bottomItem(String title, String normalIcon, String selectIcon, int index) {
    return BottomNavigationBarItem(
      icon: Image.asset(normalIcon, width: 24, height: 24),
      activeIcon: Image.asset(selectIcon, width: 24, height: 24),
      title: Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text(title,
              style: TextStyle(
                  color: _currentIndex == index
                      ? Color.fromRGBO(33, 145, 255, 1)
                      : Color.fromRGBO(51, 51, 51, 1),
                  fontSize: 14))),
    );
  }
}
