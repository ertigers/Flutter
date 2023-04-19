import 'package:boxApp/provider/senior_list_model.dart';
import 'package:boxApp/util/size_fit.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:boxApp/widget/senior_list_item.dart';
import 'package:flutter/material.dart';


class SeniorListSimplePage extends StatefulWidget {
  String title;

  SeniorListSimplePage({Key key, this.title = "学长学姐"}) : super(key: key);

  @override
  _SeniorListSimplePageState createState() => _SeniorListSimplePageState();
}

class _SeniorListSimplePageState extends State<SeniorListSimplePage> {

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
            title: Text(widget.title, style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child: GridView.builder(
              padding: EdgeInsets.only(left: 15, top: 8.0, right: 15, bottom: MSizeFit.bottomBarHeight + 12),
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
          )
        );
      },
    );
  }

}
