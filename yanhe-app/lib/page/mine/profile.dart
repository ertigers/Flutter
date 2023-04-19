import 'package:boxApp/model/college_model.dart';
import 'package:boxApp/model/consult_model.dart';
import 'package:boxApp/model/major_model.dart';
import 'package:boxApp/model/setting_item_model.dart';
import 'package:boxApp/model/subject_model.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/page/major/college_choose.dart';
import 'package:boxApp/page/major/major_choose.dart';
import 'package:boxApp/page/major/subject_choose.dart';
import 'package:boxApp/provider/profile_page_model.dart';
import 'package:boxApp/util/toast_util.dart';
import 'package:boxApp/widget/bottom_field_dialog.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:boxApp/widget/section_header.dart';
import 'package:boxApp/widget/setting_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  SubjectModel subjectModel;
  ConsultModel consultModel;
  int examType;
  String title;

  ProfilePage({Key key, this.subjectModel, this.consultModel, this.examType, this.title}) : super(key: key);
  
  @override
  State createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _imagePicker = ImagePicker();
  ProfilePageModel profilePageModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<ProfilePageModel>(
      model: ProfilePageModel(),
      onModelInit: (model) {
        profilePageModel = model;
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
            title: Text("个人资料", style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child:  SingleChildScrollView(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  SizedBox(height: 12),
                  SectionHeader(title: '关于我'),
                  _buildSetting(model: model, settingList: model.infoList),
                  SizedBox(height: 24),
                  SectionHeader(title: '关于考研'),
                  _buildSetting(model: model, settingList: model.applicantList),
                  SizedBox(height: 24),
                  // SectionHeader(title: '关于本科'),
                  // _buildSetting(model: model, settingList: model.studentList)
                ],
              )
            ),            
          )
        );
      }
    );
  }

  Widget _buildSetting({ProfilePageModel model, List<SettingItemModel> settingList}) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      alignment: Alignment.centerLeft,
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
      case '头像':
        _handleAvatar(item);
        break;
      case '昵称':
        _handleNickName(item);
        break;
      case '性别':
        _handleGender(item);
        break;
      case '签名':
        _handleSignature(item);
        break;

      case '考研年份':
        _handleApplyYear(item);
        break;
      case '报考院校':
        _handleCollege(item);
        break;
      case '报考专业':
        _handleMajor(item);
        break;
      case '报考科目':
        _handleSubject(item);
        break;

      case '院校目标':
      
        break;
      case '备考状态':
      
        break;
      case '本科院校':
      
        break;
      case '本科专业':
      
        break;
      default:
        break;
    }
    return item;
  }

  // 头像处理
  SettingItemModel _handleAvatar(SettingItemModel item) {
    item.child = Container(
      width: 22,
      height: 22,
      child: profilePageModel.userInfo?.avatar != null ? ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: CachedNetworkImage(
          imageUrl: profilePageModel.userInfo?.avatar ?? '',
          fit: BoxFit.cover,
          width: 60, 
          height: 60
        )
      ) : Container(),  
    );
    item.onTap = () {
      _showSelectPhotoDialog();
    };
    return item;
  }

  // 昵称处理
  SettingItemModel _handleNickName(SettingItemModel item) {    
    item.onTap = () {
      _showSetNickNameDialog(item);
    };
    item.value = profilePageModel.userInfo?.nickname ?? '';
    return item;
  }

  
  // 性别处理
  SettingItemModel _handleGender(SettingItemModel item) {    
    item.onTap = () {
      _showGenderPicker(item);
    };
    if (profilePageModel.userInfo?.gender != null) {
      if (profilePageModel.userInfo.gender == 1) {
        item.value = '小哥哥';
      } else if (profilePageModel.userInfo.gender == 2) {
        item.value = '小姐姐';
      } else {
        item.value = '保密';
      }
    }
    return item;
  }

  // 签名处理
  SettingItemModel _handleSignature(SettingItemModel item) {    
    item.onTap = () {
      _showSetSignatureDialog(item);
    };
    item.value = profilePageModel.userInfo?.signature ?? '';
    return item;
  }

  // 考研年份处理
  SettingItemModel _handleApplyYear(SettingItemModel item) {    
    item.onTap = () {
      _showApplyYearPicker(item);
    };
    item.value = profilePageModel.applicant?.applyYear ?? '';
    return item;
  }

  // 报考院校处理
  SettingItemModel _handleCollege(SettingItemModel item) {    
    item.onTap = () async {
      var college = await NavigatorManager.push(CollegeChoosePage());
      if (college is CollegeModel) {
        profilePageModel.updateUserApplicant(data: {'college_code': college.code});
      }
    };
    item.value = profilePageModel.applicant?.college?.name ?? '';
    return item;
  }

  // 报考专业处理
  SettingItemModel _handleMajor(SettingItemModel item) {    
    item.onTap = () async {
      if (profilePageModel.applicant?.applyCollegeCode == null) {
        return ToastUtils.showTip('请先选择院校');
      }
      var major = await NavigatorManager.push(MajorChoosePage(collegeCode: profilePageModel.applicant.applyCollegeCode));
      if (major is MajorModel) {
        profilePageModel.updateUserApplicant(data: {'major_id': major.id});
      }
    };
    item.value = profilePageModel.applicant?.major?.name ?? '';
    return item;
  }

  // 报考科目处理
  SettingItemModel _handleSubject(SettingItemModel item) {    
    
    item.onTap = () async {
      if (profilePageModel.applicant?.applyMajorId == null) {
        return ToastUtils.showTip('请先选择专业');
      }
      List<SubjectModel> subjectList = await NavigatorManager.push(SubjectChoosePage(majroId: profilePageModel.applicant.applyMajorId, collegeCode: profilePageModel.applicant.applyCollegeCode));
      if (subjectList != null) {
        profilePageModel.updateUserApplicant(data: {'major_id': profilePageModel.applicant?.applyMajorId, 'subject_ids': subjectList.map((subject) => subject.id).toList()});
      }
    };
    item.value = profilePageModel.subjectList.where((e) => e.selected == 1).map((e) => e.name).toList().join('、');
    return item;
  }

  _showSelectPhotoDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _bottomWidget('拍照', () {
              NavigatorManager.pop();
              _getImage(ImageSource.camera);
            }),
            _bottomWidget('相册', () {
              NavigatorManager.pop();
              _getImage(ImageSource.gallery);
            }),
            _bottomWidget('取消', () {
              NavigatorManager.pop();
            })
          ],
        );
      }
    );
  }

  Widget _bottomWidget(String text, VoidCallback callback) {
    return ListTile(
        title: Text(text, textAlign: TextAlign.center), onTap: callback);
  }

  //模拟头像选择修改，目前存储在本地，实际开发应当上传到云存储平台
  _getImage(ImageSource source) async {
    var imageFile = await _imagePicker.getImage(source: source);
    if (mounted) {
      Map<String ,dynamic> map = Map();
      var filePath = imageFile.path;
      var fileName = filePath.substring(filePath.lastIndexOf("/") + 1, filePath.length);
      map["file"] = await MultipartFile.fromFile(filePath, filename: fileName);
      ///通过FormData
      FormData formData = FormData.fromMap(map);
      profilePageModel.userImageUpload(data: formData, callback: (res) {
        profilePageModel.updateUserInfo(data: {'avatar': res['data']['url']});
      });
    }
  }

  // 昵称
  _showSetNickNameDialog(SettingItemModel item) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return BottomFieldContent(
          defaultValue: item.value,
          title: "给自己换一个萌萌哒的昵称吧",
          hintText: "请输入昵称",
          okBtnTitle: "确定",
          okBtnTap: (text) {
            profilePageModel.updateUserInfo(data: {'nickname': text});
          },
        );
      }
    );
  }

  // 性别选择
  _showGenderPicker(SettingItemModel item) {
    var list = ['小哥哥', '小姐姐'];
    Picker(
      adapter: PickerDataAdapter<String>(pickerdata: list),
      changeToFirst: false,
      textAlign: TextAlign.left,
      textStyle: const TextStyle(color: Colors.black),
      selectedTextStyle: TextStyle(fontSize: 16, color: Colors.blue),
      columnPadding: const EdgeInsets.all(8.0),
      cancelText: '取消',
      confirmText: '确定',
      confirmTextStyle: TextStyle(fontSize: 14, color: Colors.blue),
      cancelTextStyle: TextStyle(fontSize: 14, color: Colors.grey),
      onConfirm: (Picker picker, List value) {
        var vs = picker.getSelectedValues();
        if (vs[0] == '小哥哥') {
          profilePageModel.updateUserInfo(data: {'gender': 1});
        } else if (vs[0] == '小姐姐') {
          profilePageModel.updateUserInfo(data: {'gender': 2});
        }
      }
    ).showModal(this.context);
  }

  // 签名
  _showSetSignatureDialog(SettingItemModel item) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return BottomFieldContent(
          defaultValue: item.value,
          title: "给自己设置一款个性的签名吧",
          hintText: "请输入签名",
          okBtnTitle: "确定",
          okBtnTap: (text) {
            profilePageModel.updateUserInfo(data: {'signature': text});
          },
        );
      }
    );
  }

  // 考研年份
  _showApplyYearPicker(SettingItemModel item) {
    final now = DateTime.now();
    List<String> list = [];
    list.add((now.year + 1).toString());
    list.add((now.year + 2).toString());
    list.add((now.year + 3).toString());
    list.add((now.year + 4).toString());

    Picker(
      adapter: PickerDataAdapter<String>(pickerdata: list),
      changeToFirst: false,
      textAlign: TextAlign.left,
      textStyle: const TextStyle(color: Colors.black),
      selectedTextStyle: TextStyle(fontSize: 16, color: Colors.blue),
      columnPadding: const EdgeInsets.all(8.0),
      cancelText: '取消',
      confirmText: '确定',
      confirmTextStyle: TextStyle(fontSize: 14, color: Colors.blue),
      cancelTextStyle: TextStyle(fontSize: 14, color: Colors.grey),
      onConfirm: (Picker picker, List value) {
        var vs = picker.getSelectedValues();
        profilePageModel.updateUserApplicant(data: {'apply_year': vs[0]});
      }
    ).showModal(this.context);
  }

  // // 地区
  // _showRegionPicker(SettingItemModel item) async {
  //   Result result = await CityPickers.showCityPicker(
  //     context: context,
  //     height: 300,
  //     showType: ShowType.pc,
  //     confirmWidget: Text("确定", style: TextStyle(fontSize: 14, color: Colors.blue)),
  //     cancelWidget: Text("取消", style: TextStyle(fontSize: 14, color: Colors.grey))
  //   );
  //   print(result.toString());
  // }


}


