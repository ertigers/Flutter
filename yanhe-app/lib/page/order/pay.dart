import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/page/webview/browser.dart';
import 'package:boxApp/provider/pay_page_model.dart';
import 'package:boxApp/util/size_fit.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PayPage extends StatefulWidget {

  PayPage({Key key}) : super(key: key);

  @override
  State createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  PayPageModel payPageModel;
  bool isAgree = true;
  int payType = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<PayPageModel>(
      model: PayPageModel(),
      onModelInit: (model) {
        payPageModel = model;
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
            title: Text("支付中心", style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _buildAmount(),
                      _buildPayList()
                    ],
                  ),
                ),
                _buildBottom()
              ],
            )
          )
        );
      }
    );
  }

  Widget _buildAmount() {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: [
          Text("待支付", style: TextStyle(fontSize: 16, color: Color(0xFF666666))),
          SizedBox(height: 12),
          Text("7946.90", style: TextStyle(fontSize: 24, color: Color(0xFFFE1F41), fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  Widget _buildPayList() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          _bildPayItem(icon: 'assets/images/wechat.png', title: "微信支付", type: 1),
          _bildPayItem(icon: 'assets/images/alipay.png', title: "支付宝", type: 2)
        ],
      ),
    );
  }

  Widget _bildPayItem({String icon, String title, int type}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          payType = type;
        });
      },
      child: Container(
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
        child: Row(
          children: [
            Image.asset(icon, width: 32, height: 32),
            SizedBox(width: 8),
            Text(title, style: TextStyle(fontSize: 14, color: Color(0xFF333333))),
            Spacer(),
            payType == type ? SvgPicture.asset("assets/svgs/selected.svg", color: Colors.blue, width: 20, height: 20) 
            : SvgPicture.asset("assets/svgs/circle.svg", color: Colors.grey, width: 20, height: 20)
          ],
        ),
      )
    );
  }

  Widget _buildBottom() {
    return Container(
      margin: EdgeInsets.only(bottom: MSizeFit.bottomBarHeight),
      height: 50,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 0.5, color: Color(0xFFEEEEEE))),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 15),
              height: 50,
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isAgree = !isAgree;
                          });
                        },
                        child: isAgree ? SvgPicture.asset("assets/svgs/selected.svg", color: Colors.blue, width: 16, height: 16)
                        : SvgPicture.asset("assets/svgs/circle.svg", color: Colors.grey, width: 16, height: 16)
                      )
                    ),
                    TextSpan(
                      text: ' 阅读并同意',
                      style: TextStyle(fontSize: 12, color: Color(0xff333333))
                    ),
                    TextSpan(
                      text: '《售后政策》',
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                      recognizer: TapGestureRecognizer()..onTap = () { 
                        print('售后政策');
                        NavigatorManager.push(Browser(url: 'http://render.koudaikaoyan.com/agreement', isFull: true));
                      },
                    ),
                  ],
                ),
              ),
            )
          ),
          InkWell(
            onTap: () {
              // NavigatorManager.push(PayPage());
            },
            child: Container(
              alignment: Alignment.center,
              width: 112,
              height: 50,
              color: Color(0xFFFE1F41),
              child: Text(
                "立即支付",
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 17.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}


