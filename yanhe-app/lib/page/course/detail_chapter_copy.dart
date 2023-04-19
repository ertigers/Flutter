import 'package:flutter/material.dart';


class ExpandState{
  var isOpen;
  var index;
  ExpandState(this.index,this.isOpen);
}

class CourseDetailChapter extends StatefulWidget {
  @override
  State createState() => _CourseDetailChapterState();
}

class _CourseDetailChapterState extends State<CourseDetailChapter> {

  List<int> mList=new List();
  List<ExpandState> expandStateList=new List();

  @override
  void initState() {
    super.initState();

    for(int i=0; i<10; i++) {
      mList.add(i);
      expandStateList.add(ExpandState(i,false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        elevation: 0,
        expandedHeaderPadding: EdgeInsets.all(0),
        expansionCallback: (index,bool){
          //回调
          setState(() {
              expandStateList[index].isOpen = !expandStateList[index].isOpen;
          });
        },                        
        children: mList.map((index){
          return ExpansionPanel(
            canTapOnHeader: true,
            headerBuilder: (context,isExpanded){
              return ListTile(
                title: Text('标题'),
                // subtitle: Text("二级标题"),
                
              );
            },
            body: ListTile(
              title: Text('内容内容内容'),
            ),
            isExpanded: expandStateList[index].isOpen
          );
        }).toList(),
      ),
    );      
  }
}


