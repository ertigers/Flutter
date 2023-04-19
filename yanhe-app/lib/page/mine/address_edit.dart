import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/provider/address_edit_model.dart';
import 'package:boxApp/util/constant.dart';
import 'package:boxApp/util/toast_util.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/widget/provider_widget.dart';

class AddressEditPage extends StatefulWidget {
  int addressId;

  AddressEditPage({Key key, this.addressId}) : super(key: key);
  
  @override
  State createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {
  TextEditingController _receiverController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  bool _defaultSelected = false;
  Result citys;
  AddressEditModel addressEditModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _receiverController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<AddressEditModel>(
      model: AddressEditModel(addressId: widget.addressId),
      onModelInit: (model) {
        addressEditModel = model;
        model.loadData(callback: () {
          _receiverController.text = model.addrsssModel.receiver ?? "";
          _phoneController.text = model.addrsssModel.mobile ?? "";
          _addressController.text = model.addrsssModel.address ?? "";
          _defaultSelected = model.addrsssModel.isDefault == 1;
        });
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
            title: Text("编辑收货地址", style: TextStyle(fontSize: 18, color: Colors.black)),
            actions: [
              IconButton(
                padding: EdgeInsets.only(right: 15),
                icon: Text('保存', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  verifyAndSubmit();
                },
              ),              
            ],
          ),
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child: Builder(builder: (context) {
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                      children: [
                        _buildFieldItem(title: '收货人', hint: '请输入收货人姓名', controller: _receiverController),
                        _buildFieldItem(title: '手机号码', hint: '请输入收货人手机号码', controller: _phoneController),
                        _buildCityItem(),
                        _buildTextArea(title: '详细地址', hint: '请输入详细地址', controller: _addressController),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x1A1F86FE),
                          offset: Offset(0.0, 2.0), //阴影xy轴偏移量
                          blurRadius: 15.0, //阴影模糊程度
                          spreadRadius: 1.0 //阴影扩散程度
                        )
                      ]
                    ),
                    child: _buildSwitchItem(title: '设为默认地址')
                  )
                ]
              );
            })
          )
        );
      }
    );
  }

  Widget _buildFieldItem({String title, String hint, TextEditingController controller}) {
    return Container(
      padding: EdgeInsets.only(top: 12, bottom: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5, color: Color(0xFFEEEEEE))),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            child: Text(title ?? "", style: TextStyle(fontSize: 14, color: Color(0xFF333333)))
          ),
          Expanded(
            child: TextField(
              controller: controller,
              autofocus: false,
              decoration: InputDecoration(
                hintText: hint ?? "",
                hintStyle: TextStyle(fontSize: 12, color: Color(0xFF999999)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
            ),
          )
        ],
      )
    );
  }

  Widget _buildTextArea({String title, String hint, TextEditingController controller}) {
    return Container(
      padding: EdgeInsets.only(top: 12, bottom: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5, color: Color(0xFFEEEEEE))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            // color: Colors.blue,
            child: Text(title ?? "", style: TextStyle(fontSize: 14, color: Color(0xFF333333)))
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              minLines: 3,
              autofocus: false,
              decoration: InputDecoration(
                hintText: hint ?? "",
                hintStyle: TextStyle(fontSize: 12, color: Color(0xFF999999)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
            ),
          )
        ],
      )
    );
  }

  Widget _buildCityItem() {
    return InkWell(
      onTap: () {
        _showRegionPicker();
      },
      child: Container(
        padding: EdgeInsets.only(top: 12, bottom: 8),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.5, color: Color(0xFFEEEEEE))),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80,
              // color: Colors.blue,
              child: Text("所在地区", style: TextStyle(fontSize: 14, color: Color(0xFF333333)))
            ),
            Expanded(
              child: addressEditModel.addrsssModel.area != null ?
              Text("${addressEditModel.addrsssModel.area}", style: TextStyle(fontSize: 14, color: Color(0xFF333333)))
              : Text("请选择所在地区", style: TextStyle(fontSize: 12, color: Color(0xFF999999)))
            ),
            Image.asset(
              'assets/images/ic_more_right.png',
              width: 5.0,
              height: 10.0,
            ),
          ],
        )
      )
    );
  }

  Widget _buildSwitchItem({String title}) {
    return Container(
      padding: EdgeInsets.only(top: 12, bottom: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5, color: Color(0xFFEEEEEE))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(title ?? "", style: TextStyle(fontSize: 14, color: Color(0xFF333333)))
          ),
          SizedBox(
            height: 20,
            child: Switch(
              materialTapTargetSize: MaterialTapTargetSize.padded,
              value: _defaultSelected,//当前状态
              onChanged: (value){
                //重新构建页面  
                setState(() {
                  _defaultSelected = value;
                });
              },
            ),
          )
        ],
      )
    );
  }

  // 地区
  _showRegionPicker() async {
    Result result = await CityPickers.showCityPicker(
      context: context,
      height: 300,
      showType: ShowType.pca,
      confirmWidget: Text("确定", style: TextStyle(fontSize: 14, color: Colors.blue)),
      cancelWidget: Text("取消", style: TextStyle(fontSize: 14, color: Colors.grey))
    );
    addressEditModel.addrsssModel.province = result.provinceId;
    addressEditModel.addrsssModel.city = result.cityId;
    addressEditModel.addrsssModel.district = result.areaId;
    addressEditModel.addrsssModel.area = result.provinceName + result.cityName + result.areaName;
    addressEditModel.notifyListeners();
  }

  // 表单验证
  void verifyAndSubmit() {
    String receiver = _receiverController.text.trim();
    if (receiver.isEmpty) {
      return ToastUtils.showCenter("请填写收货人姓名");
    }
    String phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      return ToastUtils.showCenter("请填写收货人手机号码");
    }
    bool isPhone = Constant.isPhone(phone);
    if (!isPhone) {
      return ToastUtils.showCenter("收货人手机号码格式不正确");
    }
    if (addressEditModel.addrsssModel.area == null) {
      return ToastUtils.showCenter("请选择所在地区");
    }
    String address = _addressController.text.trim();
    if (address.isEmpty) {
      return ToastUtils.showCenter("请填写详细地址");
    }

    addressEditModel.addrsssModel.receiver = receiver;
    addressEditModel.addrsssModel.mobile = phone;
    addressEditModel.addrsssModel.address = address;
    addressEditModel.addrsssModel.isDefault = _defaultSelected ? 1 : 0;

    if (widget.addressId != null) {
      addressEditModel.userAddressUpdate(data: addressEditModel.addrsssModel.toJson(), callback: (res) {
        NavigatorManager.pop();
      });
    } else {
      addressEditModel.userAddressCreate(data: addressEditModel.addrsssModel.toJson(), callback: (res) {
        NavigatorManager.pop();
      });
    }
  }

}


