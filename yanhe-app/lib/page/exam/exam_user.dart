import 'package:boxApp/model/favorite_folder_model.dart';
import 'package:boxApp/model/mistake_folder_model.dart';
import 'package:boxApp/model/paper_params_model.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/page/paper/paper.dart';
import 'package:boxApp/provider/exam_user_model.dart';
import 'package:boxApp/util/size_fit.dart';
import 'package:boxApp/widget/center_field_dialog.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/widget/provider_widget.dart';

const TAB_LABEL = ['收藏题目', '答错题目'];

class ExamUserPage extends StatefulWidget {
  final String type;

  ExamUserPage({Key key, this.type = 'collect'}) : super(key: key);

  @override
  State createState() => _ExamUserPageState();
}

class _ExamUserPageState extends State<ExamUserPage> 
with SingleTickerProviderStateMixin {

  TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.type == 'collect') {
      _currentIndex = 0;
    } else {
      _currentIndex = 1;
    }
    _tabController = TabController(initialIndex: _currentIndex, length: TAB_LABEL.length, vsync: this);

    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<ExamUserModel>(
      model: ExamUserModel(),
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
            title: SizedBox(
              height: 36,
              child: TabBar(
                isScrollable: true,
                //是否可以滚动
                controller: _tabController,
                labelColor: Color(0xFF333333),
                labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                unselectedLabelColor: Color(0xFF666666),
                unselectedLabelStyle: TextStyle(fontSize: 16),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.only(left: 15, right: 15),
                tabs: TAB_LABEL.map((String label) {
                  return Tab(text: label);
                }).toList(),
              ),
            ),
            actions: [
              Offstage(
                offstage: _currentIndex != 0,
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    collectFolderCreate(model);
                  },
                )  
              ) 
            ],
          ),
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child: Container(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.separated(
                    padding: EdgeInsets.only(top: 8.0, bottom: MSizeFit.bottomBarHeight + 12, left: 15.0, right: 15.0),
                    itemBuilder: (context, index) {
                      return _buildFavoriteFolderItem(folderModel: model.favoriteFolderList[index], model: model);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 12);
                    },
                    itemCount: model.favoriteFolderList.length
                  ),
                  ListView.separated(
                    padding: EdgeInsets.only(top: 8.0, bottom: MSizeFit.bottomBarHeight + 12, left: 15.0, right: 15.0),
                    itemBuilder: (context, index) {
                      return _buildMistakeFolderItem(folderModel: model.mistakeFolderList[index], model: model);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 12);
                    },
                    itemCount: model.mistakeFolderList.length
                  ),
                ],
              )
            )          
          )
        );
      }
    );
  }

  // 收藏夹 单项
  Widget _buildFavoriteFolderItem({FavoriteFolderModel folderModel, ExamUserModel model}) {    
    return InkWell(
      onTap: () {
        _showPaperChoose(type: 'favorite', folderId: folderModel.id, title: folderModel.name);
      },
      child: Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 12.0, right: 12.0),
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
            Icon(Icons.folder_special, color: Color(0xFF1F86FE), size: 36),
            SizedBox(width: 12),
            Text(
              "${folderModel.name}（${folderModel.itemCount ?? 0}题）",
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 13.0,
              ),
            ),
            Spacer(),
            PopupMenuButton<String>(
              onSelected: (v) {
                if (v == 'delete') {
                  model.favoriteFolderDestroy(data: {'id': folderModel.id}, refresh: false, callback: (res) {
                    model.getFavoriteFolderList();
                  });
                }
              },
              padding: EdgeInsets.zero,
              child: Icon(Icons.more_horiz, color: Color(0xFF999999), size: 20),
              itemBuilder: (context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Container(
                      alignment: Alignment.center,
                      child: Text("删除"),
                    )
                  )
                ];
              },
            )
          ],
        ),
      )
    );
  }

  // 错题本 单项
  Widget _buildMistakeFolderItem({MistakeFolderModel folderModel, ExamUserModel model}) {    
    return InkWell(
      onTap: () {
        _showPaperChoose(type: 'mistake', folderId: folderModel.subjectId, title: folderModel.name);
      },
      child: Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 12.0, right: 12.0),
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
            Icon(Icons.folder_special, color: Color(0xFF1F86FE), size: 36),
            SizedBox(width: 12),
            Text(
              "${folderModel.name}（${folderModel.itemCount ?? 0}题）",
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 13.0,
              ),
            ),
            Spacer(),
            Icon(Icons.keyboard_arrow_right, color: Color(0xFF999999), size: 20)  
          ],
        ),
      )
    );
  }

  void collectFolderCreate(ExamUserModel model) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CenterFieldDialog(
          contentWidget: CenterFieldDialogContent(
            title: "新建文件夹",
            hintText: "请输入文件夹名称",
            cancelBtnTitle: "取消",
            okBtnTitle: "确定",
            okBtnTap: (text) {
              model.favoriteFolderCreate(data: {'name': text, 'type': 1}, callback: (res) {
                model.getFavoriteFolderList();                                  
              });
            },
            cancelBtnTap: () {},
          ),
        );
      }
    );
  }

  // 开始刷题 需要选择类型的部分
  _showPaperChoose({String type, int folderId, String title}) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.white,
      isScrollControlled: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16)
        )
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 145 + MSizeFit.bottomBarHeight,
          child: Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Column(
              children: [
                Text(
                  "请选择刷题方式",
                  style: TextStyle(fontSize: 16, color: Color(0xFF333333), fontWeight: FontWeight.w500)
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text("顺序刷题"),
                      color: Color(0xFF1F86FE),
                      disabledColor: Color(0xFFF8F8F8),
                      textColor: Colors.white,
                      disabledTextColor: Color(0xFFCCCCCC),
                      onPressed: () {
                        NavigatorManager.pop();
                        NavigatorManager.push(ExamPaperPage(
                          params: PaperParamsModel(
                            type: type,
                            title: title,
                            folderId: folderId,
                            random: 0
                          )
                        ));
                      }
                    ),
                    RaisedButton(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text("随机刷题"),
                      color: Color(0xFF1F86FE),
                      disabledColor: Color(0xFFF8F8F8),
                      textColor: Colors.white,
                      disabledTextColor: Color(0xFFCCCCCC),
                      onPressed: () {
                        NavigatorManager.pop();
                        NavigatorManager.push(ExamPaperPage(
                          params: PaperParamsModel(
                            type: type,
                            title: title,
                            folderId: folderId,
                            random: 1
                          )
                        ));
                      }
                    )
                  ],
                )
              ],
            ),
          )
        ); 
      },
    );
  }
}


