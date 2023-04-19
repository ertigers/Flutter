import 'package:boxApp/provider/exam_simulate_model.dart';
import 'package:boxApp/widget/exam_simulate_item.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:boxApp/widget/search_bars/search_bars.dart';
import 'package:flutter/material.dart';


class ExamSimulatePage extends StatefulWidget {
  @override
  _ExamSimulatePageState createState() => _ExamSimulatePageState();
}

class _ExamSimulatePageState extends State<ExamSimulatePage>
with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
  }

    @override
  Widget build(BuildContext context) {
    return ProviderWidget<ExamSimulateModel>(
      model: ExamSimulateModel(),
      onModelInit: (model) {
        // model.loadData();
      },
      builder: (context, model, child) {
        return LoadingContainer(
          loading: model.loading,
          error: model.error,
          retry: model.retry,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // 搜索框 仅展示作用
                    SearchStaticBar(
                      heroTag: "simulateSearchBar",
                      hint: "请输入您想查找的试卷",
                      margin: EdgeInsets.only(top: 8.0, bottom: 0.0, left: 15.0, right: 15.0),
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10.0, right: 10.0),
                      clickCallBack: () {
                        
                      },
                    ),
                  ],
                ),
              ),
               SliverPadding(
                padding: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 15.0),
                sliver: SliverFixedExtentList(
                  itemExtent: 160.0,
                  delegate: new SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return ExamSimulateItem();
                    },
                    childCount: model.simulateList.length
                  ),
                ),
              )              
            ],
          )
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
