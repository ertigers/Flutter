import 'package:boxApp/model/common_menu_model.dart';
import 'package:boxApp/model/setting_item_model.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/page/auth/login.dart';
import 'package:boxApp/page/mine/address.dart';
import 'package:boxApp/page/mine/profile.dart';
import 'package:boxApp/page/mine/setting.dart';
import 'package:boxApp/provider/mine_page_model.dart';
import 'package:boxApp/util/size_fit.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:boxApp/widget/setting_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
    print('MinePage初始化方法...');
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MinePageModel>(
      model: MinePageModel(),
      onModelInit: (model) {
        model.loadData();
      },
      builder: (context, model, child) {
        return Scaffold(
          body: ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Stack(
              fit: StackFit.expand, //未定位widget占满Stack整个空间
              alignment: Alignment.center , //指定未定位或部分定位widget的对齐方式
              children: <Widget>[
                Container(
                  child: CustomScrollView(
                    physics: ClampingScrollPhysics(),
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 256,
                              child: Image.asset("assets/images/bg_mine_header.png", fit: BoxFit.cover,)
                            ),
                            Container(
                              margin: EdgeInsets.only(top: kToolbarHeight + MSizeFit.statusBarHeight - 10),
                              padding: EdgeInsets.only(left: 15, right: 15),
                              width: double.infinity,
                              // color: Colors.blue,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  model.userInfo != null ? _buildHeader(model) : _buildHeaderEmpay(),
                                  _buildHeaderMenu(model)
                                ],
                              )
                            ),
                          ],
                        )
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSetting(model: model, settingList: model.settingList1),
                              _buildSetting(model: model, settingList: model.settingList2),
                            ],
                          )
                        )
                      ),
                    ]
                  )
                ),  
                Positioned(
                  top: 0.0,
                  child: Container(
                    width: MSizeFit.screenWidth,
                    height: kToolbarHeight + MSizeFit.statusBarHeight,
                    child: AppBar(
                      backgroundColor: Color(0x00000000),
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      centerTitle: false,
                      // title: Text('MinePage', style: TextStyle(fontSize: 18, color: Colors.white)),
                      actions: [
                        IconButton(
                          icon: Image.asset('assets/images/ic_setting.png', width: 20, height: 20),
                          onPressed: () {
                            NavigatorManager.push(SettingPage());                            
                          },
                        )
                      ],
                    ),
                  )
                ), 
              ],
            ),
          )
        );
      }
    );    
  }

  Widget _buildHeaderEmpay() {
    return InkWell(
      onTap: () {
        NavigatorManager.push(LoginPage());
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset('assets/images/avatar_default.png', width: 60, height: 60)
              ),  
            ),
            SizedBox(width: 15),
            Container(
              margin: EdgeInsets.only(top: 4),
              child: Text(
                '登录 / 注册',
                style: TextStyle(fontSize: 20, color: Color(0xffffffff))
              ),
            ),
          ],
        ),
      )
    );
  }

  // 头部
  Widget _buildHeader(MinePageModel model) {
    String applicantStr = '';
    if (model.applicant?.applyYear != null) {
      applicantStr += '${model.applicant.applyYear}届';
    }
    if (model.applicant?.college != null && model.applicant?.college?.name != null) {
      applicantStr += ' ${model.applicant.college.name}';
    }
    if (model.applicant?.major != null && model.applicant?.major?.name != null) {
      applicantStr += ' ${model.applicant.major.name}';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: CachedNetworkImage(
              imageUrl: model.userInfo?.avatar ?? '',
              fit: BoxFit.cover,
            )
          ),  
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          child: Text(
            model.userInfo?.nickname ?? '',
            style: TextStyle(fontSize: 24, color: Color(0xffffffff))
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          child: Text(
            model.userInfo?.signature ?? '',
            style: TextStyle(fontSize: 13, color: Color(0xffffffff))
          ),
        ),
        InkWell(
          onTap: () {
            NavigatorManager.push(ProfilePage());
          },
          child: Container(
            margin: EdgeInsets.only(top: 4),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '我的目标院校: ',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1F86FE)),
                  ),
                  TextSpan(
                    text: applicantStr,
                    style: TextStyle(fontSize: 13, color: Color(0xFF1F86FE)),
                  ),
                ]
              )
            ),
          )
        )        
      ],
    );
  }

  // 头部菜单 块
  Widget _buildHeaderMenu(MinePageModel model) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(12),
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
              Image.asset(
                'assets/images/ic_header_left.png',
                width: 4.0,
                height: 20.0,
              ),
              SizedBox(width: 8.0),
              Text(
                "学习中心",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333))
              )
            ],
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 38.0,
            alignment: WrapAlignment.center,
            children: model.menuList.map((item) => _buildHeaderMenuItem(item)).toList(),
          ),
        ],
      ),
    );
  }

  // 头部菜单 项
  Widget _buildHeaderMenuItem(CommonMenuModel menu) {
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        color: Colors.white,
        // margin: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              menu.iconUrl,
              width: 30.0,
              height: 30.0,
            ),
            SizedBox(height: 8.0),
            Text(
              menu.title,
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSetting({MinePageModel model, List<SettingItemModel> settingList}) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.only(left: 12, right: 12),
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
        children: settingList.map((item) => SettingItem(item: _buildSettingItem(item))).toList(),
      ),
    );
  }

    // 设置项包装
  SettingItemModel _buildSettingItem(SettingItemModel item) {
    String key = item.title;
    switch (key) {
      case '我的订单':
        item.onTap = () {
          print('我的订单');
        };
        break;
      case '我的消息':
        item.onTap = () {
          print('我的消息');
        };
        break;
      case '优惠券包':
        item.onTap = () {
          print('优惠券包');
        };
        break;

      case '地址管理':
        item.onTap = () {
          NavigatorManager.push(AddressPage());
          print('地址管理');
        };
        break;
      case '在线客服':
        item.onTap = () {
          print('在线客服');
        };
        break;
      case '学长认证':
        item.onTap = () {
          print('学长认证');
        };
        break;

      default:
        break;
    }
    return item;
  }

  @override
  bool get wantKeepAlive => true;
}
