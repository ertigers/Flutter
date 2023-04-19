import 'package:boxApp/model/college_model.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/provider/college_choose_model.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:boxApp/widget/search_bars/search_bars.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/widget/provider_widget.dart';


class CollegeChoosePage extends StatefulWidget {
  @override
  State createState() => _CollegeChoosePageState();
}

class _CollegeChoosePageState extends State<CollegeChoosePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<CollegeChooseModel>(
      model: CollegeChooseModel(),
      onModelInit: (model) {
        model.loadData();
      },
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomPadding: true,
          appBar: AppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            centerTitle: true,
            title: Text("选择院校", style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child: Container(
              child: Column(
                children: [
                  // 搜索框 仅展示作用
                  SearchTextFieldBar(
                    heroTag: "collegeChooseSearchBar",
                    hint: "请输入院校名称",
                    defaultBorderRadius: 16,
                    margin: EdgeInsets.only(top: 8.0, bottom: 0.0, left: 15.0, right: 15.0),
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10.0, right: 0.0),
                    clearCallback: () {
                      model.getCollegeList();
                    },
                    onSubmitted: (text) {
                      model.getCollegeList(keyword: text);
                    }
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: ListView(
                      children: _buildList(model),
                    )                  
                  )
                ]
              ),
            )
          )
        );
      }
    );
  }
  
  List<Widget> _buildList(CollegeChooseModel model){
    List<Widget> widgets = [];
    model.collegeMaps.forEach((key, value) {
      widgets.add(CollegeItem(provinceName: key, collegeList: value));
    });
    return widgets;
  }
}

class CollegeItem extends StatefulWidget {
  String provinceName;
  List<CollegeModel> collegeList;

  CollegeItem({key, this.provinceName, this.collegeList}) : super(key: key);

  @override
  State createState() => _CollegeItemState();

}

class _CollegeItemState extends State<CollegeItem> 
  with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animation = new Tween(begin: 0.0, end: 0.5).animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  _changeOpacity(bool expand) {
    setState(() {
      if (expand) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionTile(
        // initiallyExpanded: true,
        trailing: RotationTransition(
          turns: animation,
          child: const Icon(Icons.expand_more, size: 16, color: Color(0xffacacac)),
        ),
        onExpansionChanged: (bool) {
          _changeOpacity(bool);
        },
        title: Row(
          children: [
            Text(
              widget.provinceName,
              style: TextStyle(color: Color(0xFF333333), fontSize: 14),
            ),
            Container(
              margin: EdgeInsets.only(left: 6),
              padding: EdgeInsets.only(left: 5, top: 1, right: 5, bottom: 1),
              decoration: BoxDecoration(
                color: Color(0x1A1F86FE),
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: Text(
                "${widget.collegeList.length}",
                style: TextStyle(color: Color(0xFF1F86FE), fontSize: 10),
              ),
            ),
          ],
        ),
        children: widget.collegeList.map((college)=>_buildSub(college)).toList(),
      )
    );
  }

  Widget _buildSub(CollegeModel college){
    //可以设置撑满宽度的盒子 称之为百分百布局
    return FractionallySizedBox(
      //宽度因子 1为百分百撑满
      widthFactor: 1,
      child: InkWell(
        onTap: () {
          NavigatorManager.pop(college);
        },
        child: Container(
          padding: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
          // decoration: BoxDecoration(color: Colors.lightBlueAccent),
          decoration: BoxDecoration(
            color: Color(0xFFF8F8F8),
            border: Border(bottom: BorderSide(width: 1,color: Color(0xffeeeeee)))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text("${college.name}", style: TextStyle(fontSize: 14, color: Color(0xff333333))),
              ),
              SizedBox(width: 12),
              Text("院校代码：${college.code}", style: TextStyle(fontSize: 12, color: Color(0xff666666))),
            ],
          )
        ),
      )
    );
  }
}


