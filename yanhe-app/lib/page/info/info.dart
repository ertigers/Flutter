import 'package:boxApp/provider/info_detail_model.dart';
import 'package:boxApp/provider/material_detail_model.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:flutter/material.dart';

class InfoDetailPage extends StatefulWidget {
  int infoId;

  InfoDetailPage({Key key, @required this.infoId}) : super(key: key);

  @override
  _InfoDetailPageState createState() => _InfoDetailPageState();
}

class _InfoDetailPageState extends State<InfoDetailPage> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<InfoDetailModel>(
      model: InfoDetailModel(widget.infoId),
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
            title: Text("详情", style: TextStyle(fontSize: 18, color: Colors.black)),
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