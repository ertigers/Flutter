import 'package:boxApp/provider/senior_list_model.dart';
import 'package:boxApp/util/size_fit.dart';
import 'package:boxApp/widget/dropdown_menu/flutter_dropdown_menu.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:boxApp/widget/search_bars/search_bars.dart';
import 'package:boxApp/widget/senior_list_item.dart';
import 'package:boxApp/util/size_fit.dart';
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


class SeniorListPage extends StatefulWidget {
  bool autofocus = false;

  SeniorListPage({Key key, this.autofocus = false}) : super(key: key);

  @override
  _SeniorListPageState createState() => _SeniorListPageState();
}

class _SeniorListPageState extends State<SeniorListPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<SeniorListModel>(
      model: SeniorListModel(),
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
            title: Text("找学长", style: TextStyle(fontSize: 18, color: Colors.black)),
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
                    heroTag: "seniorListSearchBar",
                    hint: "请输入学长名称",
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
                        GridView.builder(
                          padding: EdgeInsets.only(left: 15, top: 20, right: 15, bottom: MSizeFit.bottomBarHeight + 10),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, //Grid按两列显示
                            mainAxisSpacing: 12.0,
                            crossAxisSpacing: 12.0,
                            childAspectRatio: 1.0,
                          ),
                          itemCount: model.seniorList.length,
                          itemBuilder: (context, index) {
                            return SeniorListItem(
                              senior: model.seniorList[index]
                            );
                          }
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
