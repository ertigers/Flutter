import 'package:boxApp/provider/material_detail_model.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:flutter/material.dart';

class MaterialDetailPage extends StatefulWidget {
  int materialId;

  MaterialDetailPage({Key key, @required this.materialId}) : super(key: key);

  @override
  _MaterialDetailPageState createState() => _MaterialDetailPageState();
}

class _MaterialDetailPageState extends State<MaterialDetailPage> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MaterialDetailModel>(
      model: MaterialDetailModel(widget.materialId),
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
            title: Text("资料详情", style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child: Column(
              children: [],
            )
          )
        );
      }
    );
  }
}