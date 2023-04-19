import 'package:boxApp/model/consult_model.dart';
import 'package:boxApp/provider/consult_list_model.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:boxApp/widget/search_bars/search_bars.dart';
import 'package:boxApp/widget/section_header.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/widget/provider_widget.dart';

class ExamConsultAddPage extends StatefulWidget {
  @override
  State createState() => _ExamConsultAddPageState();
}

class _ExamConsultAddPageState extends State<ExamConsultAddPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<ConsultListModel>(
      model: ConsultListModel(),
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
            title: Text("添加参考书", style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    child: SearchTextFieldBar(
                      heroTag: "subjectAddSearchBar",
                      hint: "请输入参考书名称",
                      defaultBorderRadius: 16,
                      margin: EdgeInsets.only(top: 8.0, bottom: 0.0, left: 15.0, right: 15.0),
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10.0, right: 0.0),
                      clearCallback: () {
                        model.getConsultList();
                      },
                      onSubmitted: (text) {
                        model.getConsultList(keyword: text);
                      }
                    )
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(top: 15.0, bottom: 0.0, left: 15.0, right: 15.0),
                    child: SectionHeader(
                      title: "已选参考书"
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(left: 15, top: 15.0, right: 15),
                  sliver: new SliverGrid( //Grid
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, //Grid按两列显示
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 3.1,
                    ),
                    delegate: new SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        //创建子widget      
                        return _buildSelectedItem(consult: model.userConsultList[index], model: model);
                      },
                      childCount: model.userConsultList.length,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(top: 30.0, bottom: 0.0, left: 15.0, right: 15.0),
                    child: SectionHeader(
                      title: "热门参考书"
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(top: 3.0, bottom: 24.0, left: 15.0, right: 15.0),
                  sliver: model.consultList.length > 0 ? SliverFixedExtentList(
                    itemExtent: 54.0,
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        //创建列表项      
                        return _buildConsultItem(consult: model.consultList[index], model: model);
                      },
                      childCount: model.consultList.length
                    ),
                  ) : SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(top: 24),
                      alignment: Alignment.center,
                      child: Text('暂无更多参考书～', style: TextStyle(fontSize: 12, color: Color(0xff999999))),
                    ),
                  ),
                ),
                
              ],
            )
          )
        );
      }
    );
  }

  Widget _buildSelectedItem({@required ConsultModel consult, @required ConsultListModel model}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 12.0, right: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A1F86FE),
            offset: Offset(0.0, 5.0), //阴影xy轴偏移量
            blurRadius: 15.0, //阴影模糊程度
            spreadRadius: 1.0 //阴影扩散程度
          )
        ]
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  consult.name, 
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 14, color: Color(0xFF333333))
                ),
                SizedBox(height: 2),
                Text(
                  consult.description, 
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 11, color: Color(0xFF999999))
                )
              ],
            ),
          ),
          SizedBox(width: 5),
          InkWell(
            onTap: () {
              model.userConsultRemove(consultId: consult.id, refresh: false);
            },
            child: Container(
              padding: EdgeInsets.only(left: 5, top: 1, right: 5, bottom: 1),
              decoration: BoxDecoration(
                // color: Color(0x1A1F86FE),
                border: Border.all(color: Color(0xFF1F86FE), width: 0.5),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text("删除", style: TextStyle(fontSize: 13, color: Color(0xFF1F86FE))),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildConsultItem({@required ConsultModel consult, @required ConsultListModel model}) {    
    return Container(
      margin: EdgeInsets.only(top: 12),
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A1F86FE),
            offset: Offset(0.0, 5.0), //阴影xy轴偏移量
            blurRadius: 15.0, //阴影模糊程度
            spreadRadius: 1.0 //阴影扩散程度
          )
        ]
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 12.0, bottom: 12.0, left: 12.0, right: 12.0),
              child: Row(
                children: [
                  Text(
                    "${consult.name}",
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 13.0,
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    "${consult.description}",
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 11.0,
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            )
          ),
          InkWell(
            onTap: () {
              model.userConsultAdd(consultId: consult.id, refresh: false);
            },
            child: Container(
              padding: EdgeInsets.only(top: 12.0, bottom: 12.0, left: 12.0, right: 12.0),
              decoration: BoxDecoration(
                color: Color(0xFF1F86FE),
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), topRight: Radius.circular(8)),
              ),
              child: Text(
                "添加",
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 13.0,
                  // fontWeight: FontWeight.bold
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}


