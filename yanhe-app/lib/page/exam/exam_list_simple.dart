import 'package:boxApp/provider/exam_list_model.dart';
import 'package:boxApp/util/size_fit.dart';
import 'package:boxApp/widget/exam_list_item.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:flutter/material.dart';



class ExamListSimplePage extends StatefulWidget {
  String title;

  ExamListSimplePage({Key key, this.title = "专业题库"}) : super(key: key);

  @override
  _ExamListSimplePageState createState() => _ExamListSimplePageState();
}

class _ExamListSimplePageState extends State<ExamListSimplePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<ExamListModel>(
      model: ExamListModel(),
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
            title: Text(widget.title, style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 0.0, bottom: MSizeFit.bottomBarHeight + 12, left: 15.0, right: 15.0),
              itemExtent: 160,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(top: 12),
                  child: ExamListItem(
                    exam: model.examList[index],
                  )
                );
              },
              itemCount: model.examList.length
            )
          )
        );
      },
    );
  }
  

}
