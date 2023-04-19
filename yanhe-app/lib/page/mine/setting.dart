import 'package:boxApp/model/setting_item_model.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/page/entry.dart';
import 'package:boxApp/provider/setting_page_model.dart';
import 'package:boxApp/util/app_manager.dart';
import 'package:boxApp/util/toast_util.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:boxApp/widget/setting_item.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/widget/provider_widget.dart';

class SettingPage extends StatefulWidget {

  SettingPage({Key key}) : super(key: key);
  
  @override
  State createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  SettingPageModel settingPageModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<SettingPageModel>(
      model: SettingPageModel(),
      onModelInit: (model) {
        settingPageModel = model;
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
            title: Text("设置", style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child:  SingleChildScrollView(
              // padding: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  _buildSetting(model: model, settingList: model.aboutList),
                  SizedBox(height: 24),

                  _buildLogout()
                ],
              )
            ),            
          )
        );
      }
    );
  }

  Widget _buildSetting({SettingPageModel model, List<SettingItemModel> settingList}) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.only(left: 15, right: 15),
      alignment: Alignment.centerLeft,
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
      child: Column(
        children: settingList.map((item) {
          return SettingItem(item: _buildSettingItem(item));
        }).toList(),
      ),
    );
  }

  // 设置项包装
  SettingItemModel _buildSettingItem(SettingItemModel item) {
    String key = item.title;
    switch (key) {
      case '清除缓存':
        
        break;
      case '当前版本':

        break;
      default:
        break;
    }
    return item;
  }

  Widget _buildLogout() {
    return Container(
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
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: FlatButton(
          onPressed: () {
            ToastUtils.showSuccess('退出登录');
            AppManager.prefs.clear();
            NavigatorManager.pushAndRemoveUntil(EntryPage());
          },
          child: Text("退出登录"),
          color: Colors.white,
          textColor: Color(0xFF1F86FE),
        ),
      )
    );
  }


}


