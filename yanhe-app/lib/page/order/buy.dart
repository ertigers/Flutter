import 'package:boxApp/model/address_model.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/page/mine/address.dart';
import 'package:boxApp/page/order/pay.dart';
import 'package:boxApp/provider/buy_page_model.dart';
import 'package:boxApp/util/size_fit.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/widget/provider_widget.dart';

class BuyPage extends StatefulWidget {

  BuyPage({Key key}) : super(key: key);

  @override
  State createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  BuyPageModel buyPageModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<BuyPageModel>(
      model: BuyPageModel(),
      onModelInit: (model) {
        buyPageModel = model;
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
            title: Text("确认订单", style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        _buildAddress(),
                        _buildGoods(),
                        _buildAmount(),
                      ]
                    ),
                  )
                ),
                _buildBottom()
              ],
            )
          )
        );
      }
    );
  }

  Widget _buildAddress() {
    return GestureDetector(
      onTap: () async {
        var result = await NavigatorManager.push(AddressPage(type: "choose"));
        if (result is AddressModel) {
          buyPageModel.addrsssModel = result;
          buyPageModel.notifyListeners();
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 8),
        padding: EdgeInsets.only(left: 15, top: 18, right: 15, bottom: 18),
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
        child: Row(
          children: [
            Image.asset('assets/images/ic_location.png', width: 20, height: 20),
            SizedBox(width: 12),
            Expanded(
              child: buyPageModel.addrsssModel != null ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${buyPageModel.addrsssModel.receiver}  ${buyPageModel.addrsssModel.mobile}", style: TextStyle(fontSize: 16, color: Color(0xff333333))),
                  SizedBox(height: 4),
                  Text("${buyPageModel.addrsssModel.area} ${buyPageModel.addrsssModel.address}", style: TextStyle(fontSize: 14, color: Color(0xFF999999))),
                ],
              ) : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${buyPageModel.userInfo.nickname}  ${buyPageModel.userInfo.mobile}", style: TextStyle(fontSize: 16, color: Color(0xff333333))),
                  SizedBox(height: 4),
                  Text("编辑收货地址", style: TextStyle(fontSize: 14, color: Color(0xFF999999))),
                ],
              ) 
            ),
            SizedBox(width: 12),
            Image.asset(
              'assets/images/ic_more_right.png',
              width: 5.0,
              height: 10.0,
            )
          ],
        ),
      )
    );
  }

  Widget _buildGoods() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.only(left: 15, top: 12, right: 15, bottom: 12),
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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CachedNetworkImage(
              width: 100,
              height: 76,
              imageUrl: "http://img.koudaikaoyan.com/c52b438401ac45a59707b2da378be337.png",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 76,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("2021年英语四级考前系统班", style: TextStyle(fontSize: 16, color: Color(0xff333333))),
                  Text("¥8826.90", style: TextStyle(fontSize: 16, color: Color(0xFFFE1F41))),
                ],
              )
            )
          )
        ],
      ),
    );
  }

  Widget _buildAmount() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.only(left: 15, top: 18, right: 15, bottom: 18),
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
        children: [
          Row(
            children: [
              Text("订单金额", style: TextStyle(fontSize: 14, color: Color(0xff333333))),
              Spacer(),
              Text("¥8826.90", style: TextStyle(fontSize: 16, color: Color(0xff999999)))
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Spacer(),
              Text("合计：", style: TextStyle(fontSize: 14, color: Color(0xff333333))),
              Text("¥8826.90", style: TextStyle(fontSize: 16, color: Color(0xFFFE1F41))),
            ],
          )
        ],
      ),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '¥',
                          style: TextStyle(fontSize: 14, color: Color(0xFFFE1F41))
                        ),
                        TextSpan(
                          text: '8826',
                          style: TextStyle(fontSize: 18, color: Color(0xFFFE1F41), fontWeight: FontWeight.bold)
                        ),
                        TextSpan(
                          text: '.90',
                          style: TextStyle(fontSize: 14, color: Color(0xFFFE1F41))
                        ),
                      ]
                    )
                  ),
                  SizedBox(height: 2),
                  Text(
                    "订单原价8826.90，共优惠0",
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            )
          ),
          InkWell(
            onTap: () {
              NavigatorManager.push(PayPage());
            },
            child: Container(
              alignment: Alignment.center,
              width: 112,
              height: 50,
              color: Color(0xFFFE1F41),
              child: Text(
                "提交订单",
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


