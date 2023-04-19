import 'package:boxApp/provider/material_list_model.dart';
import 'package:boxApp/util/size_fit.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:boxApp/widget/material_list_item.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:flutter/material.dart';


class MaterialListSimplePage extends StatefulWidget {
  String title;

  MaterialListSimplePage({Key key, this.title = "讲义资料"}) : super(key: key);

  @override
  _MaterialListSimplePageState createState() => _MaterialListSimplePageState();
}

class _MaterialListSimplePageState extends State<MaterialListSimplePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MaterialListModel>(
      model: MaterialListModel(),
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
                  child: MaterialListItem(
                    material: model.materialList[index],
                  )
                );
              },
              itemCount: model.materialList.length
            ),
          )
        );
      },
    );
  }
  

}
