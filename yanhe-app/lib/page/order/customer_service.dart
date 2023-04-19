import 'package:boxApp/provider/customer_service_model.dart';
import 'package:boxApp/util/toast_util.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomerServicePage extends StatefulWidget {
  @override
  _CustomerServicePageState createState() => _CustomerServicePageState();
}

class _CustomerServicePageState extends State<CustomerServicePage> {
  String wechat = 'yanhetiku000';

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<CustomerServiceModel>(
      model: CustomerServiceModel(),
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
            title: Text("联系客服", style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 12),
                    padding: EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 12),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("研盒客服", style: TextStyle(fontSize: 16, color: Color(0xFF1F86FE))),
                        SizedBox(height: 4),
                        Text("研小妹将努力解决您的疑惑，为您带来最好的服务。", style: TextStyle(fontSize: 12, color: Color(0xFF333333))),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            Image.asset('assets/images/logo.png', width: 38, height: 38),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("微信号：yanhetiku000", style: TextStyle(fontSize: 14, color: Color(0xFF333333))),
                                  Text("研盒小妹", style: TextStyle(fontSize: 12, color: Color(0xFF999999)))
                                ],
                              ),
                            ),
                            SizedBox(width: 12),
                            InkWell(
                              onTap: () { 
                                Clipboard.setData(ClipboardData(text: wechat));
                                ToastUtils.showSuccess('微信号复制成功');
                              },
                              child: Container(
                                height: 28,
                                margin: EdgeInsets.only(top: 0.0, bottom: 0.0, left: 15.0, right: 15.0),
                                padding: EdgeInsets.only(left: 10, right: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  // color: Color(0x1A1F86FE),
                                  border: Border.all(color: Color(0xFF1F86FE), width: 0.5),
                                  borderRadius: BorderRadius.circular(28.0),
                                ),
                                child: Text(
                                  "复制微信号",
                                  style: TextStyle(
                                  color: Color(0xFF1F86FE),
                                  fontSize: 12.0,
                                  // fontWeight: FontWeight.bold
                                ),
                                )
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ]
              ),
            )
          )
        );
      }
    );
  }
}