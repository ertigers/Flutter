import 'package:boxApp/model/course_chapter_model.dart';
import 'package:flutter/material.dart';


const CITY_NAMES = {
  '北京':['东城区','西城区','海淀区','朝阳区','石景山区','顺义区'],
  '上海':['黄浦区','徐汇区','长宁区','静安区','普陀区','闸北区'],
  '广州':['越秀','海珠','荔湾','天河','白云','黄埔','南沙'],
  '深圳':['南山','福田','罗湖','盐田','龙岗','宝安','龙华'],
  '杭州':['上城区','下城区','江干区','拱墅区','西湖区','滨江区'],
  '苏州':['姑苏区','吴中区','相城区','高新区','虎丘区','工业园区','吴江区'],
};

class CourseDetailChapter extends StatelessWidget {
  List<CourseChapterModel> chapterList = [];

  CourseDetailChapter({Key key, this.chapterList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: _buildList(),
      )
    );
  }

  List<Widget> _buildList(){
    List<Widget> widgets = [];
    chapterList.forEach((chapter){
      widgets.add(CourseChapterItem(chapter: chapter));
    });
    return widgets;
  }
}


class CourseChapterItem extends StatefulWidget {
  CourseChapterModel chapter;

  CourseChapterItem({key, this.chapter}) : super(key: key);

  @override
  State createState() => _CourseChapterItemState();

}

class _CourseChapterItemState extends State<CourseChapterItem> 
  with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  bool _isExpansion = false;

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
      margin: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5,color: _isExpansion ? Colors.transparent : Color(0xffeeeeee)))
      ),
      child: ExpansionTile(
        trailing: RotationTransition(
          turns: animation,
          child: Icon(Icons.expand_more, size: 16, color: Color(0xffacacac)),
        ),
        onExpansionChanged: (bool) {
          setState(() {
            _isExpansion = bool;
          });
          _changeOpacity(bool);
        },
        tilePadding: EdgeInsets.zero,
        title: Row(
          children: [
            Text(
              widget.chapter?.name,
              style: TextStyle(color: Color(0xFF333333), fontSize: 14),
            ),
          ],
        ),
        children: widget.chapter.children.length > 0 
        ? widget.chapter.children.map((subChapter)=>_buildSub(subChapter)).toList()
        : [
          Container(
            padding: EdgeInsets.only(top: 12, bottom: 12),
            child: Text("暂无子章节", style: TextStyle(fontSize: 14, color: Color(0xff999999)))
          )
        ]
      )
    );
  }

  Widget _buildSub(CourseChapterModel chapter){
    //可以设置撑满宽度的盒子 称之为百分百布局
    return FractionallySizedBox(
      //宽度因子 1为百分百撑满
      widthFactor: 1,
      child: InkWell(
        onTap: () {
          print('choose');
          // NavigatorManager.pop("college");
        },
        child: Container(
          padding: EdgeInsets.only(left: 15, top: 12, right: 15, bottom: 12),
          // decoration: BoxDecoration(color: Colors.lightBlueAccent),
          decoration: BoxDecoration(
            color: Color(0xFFF8F8F8),
            border: Border(bottom: BorderSide(width: 1, color: Color(0xffeeeeee)))
          ),
          child: Text(chapter.name),
        ),
      )
    );
  }
}
