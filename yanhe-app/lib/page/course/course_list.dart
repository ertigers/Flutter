import 'package:boxApp/provider/course_list_model.dart';
import 'package:boxApp/util/size_fit.dart';
import 'package:boxApp/widget/course_list_item.dart';
import 'package:boxApp/widget/dropdown_menu/flutter_dropdown_menu.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:boxApp/widget/search_bars/search_bars.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/nav_router/manager.dart';

const List<Map<String, dynamic>> YEARS = [
  {"title": "全部"},
  {"title": "2020年"},
  {"title": "2021年"},
];

const int YEAR_INDEX = 0;

const List<Map<String, dynamic>> SUBJECTS = [
  {"title": "全部"},
  {"title": "政治"},
  {"title": "英语"},
  {"title": "数学"},
];

const int SUBJECT_INDEX = 0;

const List<Map<String, dynamic>> TYPES = [
  {"title": "全部"},
  {"title": "录播课"},
  {"title": "直播课"}
];

const int TYPE_INDEX = 0;


class CourseListPage extends StatefulWidget {
  bool autofocus = false;

  CourseListPage({Key key, this.autofocus = false}) : super(key: key);

  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<CourseListModel>(
      model: CourseListModel(),
      onModelInit: (model) {
        model.loadData();
      },
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            centerTitle: true,
            title: Text("课程列表", style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child: DefaultDropdownMenuController(
              onSelected: ({int menuIndex, int index, int subIndex, dynamic data}) {
                print("${menuIndex} ${index} ${data}");
              },
              child: Column(
                children: [
                  SearchTextFieldBar(
                    heroTag: "courseListSearchBar",
                    hint: "请输入课程名称",
                    defaultBorderRadius: 16,
                    autofocus: widget.autofocus,
                    margin: EdgeInsets.only(top: 8.0, bottom: 0.0, left: 15.0, right: 15.0),
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10.0, right: 0.0),
                    clearCallback: () {
                      
                    },
                    onSubmitted: (text) {
                      
                    }
                  ),
                  buildDropdownHeader(),
                  Expanded(
                    child: Stack(
                      children: [
                        ListView.builder(
                          padding: EdgeInsets.only(top: 8.0, bottom: MSizeFit.bottomBarHeight + 12, left: 15.0, right: 15.0),
                          itemExtent: 160,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(top: 12),
                              child: CourseListItem(
                                course: model.courseList[index],
                              )
                            );
                          },
                          itemCount: model.courseList.length
                        ),
                        buildDropdownMenu()
                      ],
                    )
                  )
                ],
              )
            )
          )
        );
      },
    );
  }

  DropdownHeader buildDropdownHeader({DropdownMenuHeadTapCallback onTap}) {
    return new DropdownHeader(
      onTap: onTap,
      titles: [YEARS[YEAR_INDEX], SUBJECTS[SUBJECT_INDEX], TYPES[TYPE_INDEX]],
    );
  }

  DropdownMenu buildDropdownMenu() {
    return new DropdownMenu(maxMenuHeight: kDropdownMenuItemHeight * 10,
        //  activeIndex: activeIndex,
        menus: [
          DropdownMenuBuilder(
            builder: (BuildContext context) {
              return new DropdownListMenu(
                selectedIndex: YEAR_INDEX,
                data: YEARS,
                itemBuilder: buildCheckItem,
              );
            },
            height: kDropdownMenuItemHeight * TYPES.length
          ),
          DropdownMenuBuilder(
            builder: (BuildContext context) {
              return new DropdownListMenu(
                selectedIndex: SUBJECT_INDEX,
                data: SUBJECTS,
                itemBuilder: buildCheckItem,
              );
            },
            height: kDropdownMenuItemHeight * TYPES.length
          ),
          DropdownMenuBuilder(
            builder: (BuildContext context) {
              return new DropdownListMenu(
                selectedIndex: TYPE_INDEX,
                data: TYPES,
                itemBuilder: buildCheckItem,
              );
            },
            height: kDropdownMenuItemHeight * TYPES.length
          ),
        ]
      );
  }

}
