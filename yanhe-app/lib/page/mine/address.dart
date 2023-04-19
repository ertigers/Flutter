import 'package:boxApp/model/address_model.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/page/mine/address_edit.dart';
import 'package:boxApp/provider/address_page_model.dart';
import 'package:boxApp/util/size_fit.dart';
import 'package:boxApp/widget/custom_dialog.dart';
import 'package:boxApp/widget/empty.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddressPage extends StatefulWidget {

  String type;
  int chooseAddressId;

  AddressPage({Key key, this.chooseAddressId, this.type = 'normal'}) : super(key: key);
  
  @override
  State createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  AddressPageModel addressPageModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<AddressPageModel>(
      model: AddressPageModel(),
      onModelInit: (model) {
        addressPageModel = model;
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
            title: Text("地址管理", style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child: Column(
              children: [
                Expanded(
                  child: model.addressList.length > 0 ? ListView.separated(
                    padding: EdgeInsets.only(top: 12.0, bottom: 24.0, left: 15.0, right: 15.0),
                    itemBuilder: (context, index) {
                      return _buildAddressItem(address: model.addressList[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 12);
                    },
                    itemCount: model.addressList.length
                  ) : Empty(),    
                ),
                Container(
                  margin: EdgeInsets.only(left: 35, top: 12, right: 35, bottom: MSizeFit.bottomBarHeight + 12),
                  width: double.infinity,
                  child:  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text("新建收货地址", style: TextStyle(fontSize: 14)),
                    color: Color(0xFF1F86FE),
                    disabledColor: Color(0xFFF8F8F8),
                    textColor: Colors.white,
                    disabledTextColor: Color(0xFFCCCCCC),
                    onPressed: () async {
                      await NavigatorManager.push(AddressEditPage());
                      addressPageModel.getAddressList();
                    }
                  )
                )
              ],
            )     
          )
        );
      }
    );
  }

 

  Widget _buildAddressItem({AddressModel address}) {
    return GestureDetector(
      onTap: () {
        if (widget.type == 'choose') {
          NavigatorManager.pop(address);
        }
      },
      child: Container(
        padding: EdgeInsets.all(12),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Color(0x1A1F86FE),
              offset: Offset(0.0, 2.0), //阴影xy轴偏移量
              blurRadius: 15.0, //阴影模糊程度
              spreadRadius: 1.0 //阴影扩散程度
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(address.receiver, style: TextStyle(fontSize: 16, color: Color(0xff333333))),
                SizedBox(width: 8),
                Text(address.mobile, style: TextStyle(fontSize: 16, color: Color(0xff0333333))),
                address.isDefault == 1 ? Container(
                  margin: EdgeInsets.only(left: 8),
                  padding: EdgeInsets.only(left: 8, top: 2, right: 8, bottom: 2),
                  decoration: BoxDecoration(
                    color: Color(0xFF1F86FE),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Text("默认", style: TextStyle(fontSize: 10, color: Color(0xffffffff))),
                ) : Container()
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              child: Text("${address.area} ${address.address}", style: TextStyle(fontSize: 14, color: Color(0xff999999)))
            ),
            SizedBox(height: 6),
            Row(
              children: [
                widget.type == 'choose' ? (
                  widget.chooseAddressId != null && widget.chooseAddressId == address.id ? 
                  _buildChooseTips() : _buildChooseNormalTips()
                ) : Container(),
                Spacer(),
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        await NavigatorManager.push(AddressEditPage(addressId: address.id));
                        addressPageModel.getAddressList();
                      },
                      child: Image.asset('assets/images/btn_edit.png', width: 60, height: 21),
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        _deleteAddressDialog(address: address);
                        
                      },
                      child: Image.asset('assets/images/btn_delete.png', width: 60, height: 21),
                    ),
                  ],
                )
              ]
            )
          ]
        )
      )
    );
  }

  Widget _buildChooseTips() {
    return Container(
      child: Row(
        children: [
          SvgPicture.asset("assets/svgs/selected.svg", color: Colors.blue, width: 16, height: 16),
          SizedBox(width: 4),
          Text("已选地址", style: TextStyle(fontSize: 12, color: Color(0xff0333333))),
        ],
      )
    );
  }

  Widget _buildChooseNormalTips() {
    return Container(
      child: Row(
        children: [
          SvgPicture.asset("assets/svgs/circle.svg", color: Colors.grey, width: 16, height: 16),
          SizedBox(width: 4),
          Text("选择地址", style: TextStyle(fontSize: 12, color: Color(0xff0333333))),
        ],
      )
    );
  }

  _deleteAddressDialog({AddressModel address}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return CustomDialog(
          content: '确定要删除地址吗？',
          isCancel: true,
          confirmTextColor: Color(0xFF1F86FE),
          confirmCallback: () {
            addressPageModel.userAddressDelete(data: {"id": address.id}, callback: (res) {
              addressPageModel.getAddressList();
            });
          }
        );
      }
    );
  }

}


