import 'package:boxApp/provider/senior_detail_model.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:flutter/material.dart';

class SeniorDetailPage extends StatefulWidget {
  int seniorId;

  SeniorDetailPage({Key key, @required this.seniorId}) : super(key: key);

  @override
  _SeniorDetailPageState createState() => _SeniorDetailPageState();
}

class _SeniorDetailPageState extends State<SeniorDetailPage> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<SeniorDetailModel>(
      model: SeniorDetailModel(widget.seniorId),
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
            title: Text("学长信息", style: TextStyle(fontSize: 18, color: Colors.black)),
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