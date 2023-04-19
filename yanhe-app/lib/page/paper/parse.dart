import 'dart:async';

import 'package:boxApp/model/favorite_folder_model.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/page/paper/material_item.dart';
import 'package:boxApp/page/paper/normal_item.dart';
import 'package:boxApp/provider/exam_paper_model.dart';
import 'package:boxApp/provider/exam_parse_model.dart';
import 'package:boxApp/util/size_fit.dart';
import 'package:boxApp/widget/center_field_dialog.dart';
import 'package:boxApp/widget/list_item_single.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class ExamParsePage extends StatefulWidget {
  int exerciseId;
  int itemIndex;

  ExamParsePage({
    Key key, 
    @required this.exerciseId, 
    this.itemIndex = 0, 
  }) : super(key: key);

  @override
  _ExamParsePageState createState() => _ExamParsePageState();
}

class _ExamParsePageState extends State<ExamParsePage> {
  SwiperController _swiperController;
  SwiperController _subSwiperController;
  int _swiperIndex = 0;
  int startTime = DateTime.now().millisecondsSinceEpoch;

  @override
  void initState() {
    super.initState();  

    _swiperController = SwiperController();
  }

  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<ExamParsePageModel>(
      model: ExamParsePageModel(exerciseId: widget.exerciseId),
      onModelInit: (model) {
        model.loadData(callback: () {
          if (widget.itemIndex != null) {
            var itemModel = model.tiledItemList[widget.itemIndex];
            _swiperIndex = itemModel.index ?? 0;
            model.setMoveIndex(showIndex: itemModel.index ?? 0, showSubIndex: itemModel.subIndex ?? 0);
          }
        });
      },
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('题目解析', style: TextStyle(fontSize: 18,color: Colors.black)),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            brightness: Brightness.light,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child: Container(
              // height: 520,
              child: Column(
                children: [
                  Expanded(
                    child: Listener(
                      // onPointerDown: (event) => print('onPointerDown'),
                      // onPointerMove: (event) {
                      //   print('onPointerMove');
                      //   var position = event.position.distance;
                      // },
                      // onPointerUp: (event) => print('onPointerUp'),
                      // onPointerCancel: (event) => print('onPointerCancel'),

                      child: Swiper(
                        // key: UniqueKey(),
                        itemBuilder: (BuildContext context, int index) {
                          var itemModel = model.itemList[index];

                          if (itemModel.answerType == 8) {
                            return ExamPaperMaterialItem(
                              isParse: true,
                              itemModel: itemModel, 
                              index: model.computeItemIndex(index), 
                              showIndex: model.showSubIndex,
                              length: model.examItemLength, 
                              chooseCallback: model.updateItemModel,
                              onIndexChanged: model.updateShowItemIndex,
                              onInitCallback: (SwiperController subSwiperController) {
                                this._subSwiperController = subSwiperController;
                              }
                            );
                          }
                          return ExamPaperNormalItem(
                            isParse: true,
                            itemModel: itemModel, 
                            index: model.computeItemIndex(index), 
                            length: model.examItemLength, 
                            chooseCallback: model.updateItemModel
                          );
                        },
                        index: _swiperIndex,
                        itemCount: model.itemList.length,
                        autoplay: false,
                        loop: false,
                        controller: _swiperController,
                        onIndexChanged: (index) {
                          setState(() {
                            _swiperIndex = index;
                          });
                          var itemModel = model.itemList[index];
                          model.updateShowItemIndex(model.computeItemIndex(index), refresh: false);
                          model.setMoveIndex(showIndex: index, showSubIndex: itemModel.subIndex ?? 0);

                          // if (itemModel.answerType == 8 && _subSwiperController != null) {
                          //   print("2222222");
                          //   _subSwiperController?.move(0);
                          // }
                        }
                      ),
                    )
                  ),
                  _buildMenu(model)
                ],
              ),
            )  
          )
        );
      }
    );
  }

  Widget _buildMenu(ExamParsePageModel model) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      height:  MSizeFit.bottomBarHeight + 54,
      color: Colors.blue,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                if (model.showItemModel.favorite) {
                  model.userFavoriteDestroy(
                    data: {'ref_type': 1, 'ref_id': model.showItemModel.id},
                    callback: (res) {
                      model.showItemModel.favorite = false;
                    }
                  );
                } else {
                  _showFavoriteFolder(model);
                }          
              },
              child: Column(
                children: [
                  SvgPicture.asset((model.itemList.length > 0 && model.showItemModel.favorite) ? "assets/svgs/star_on.svg" : "assets/svgs/star_off.svg", color: Colors.white, width: 20, height: 20),
                  SizedBox(height: 2),
                  Text("收藏题目", style: TextStyle(fontSize: 12, color: Colors.white))
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                _showSheetCard(model);
              },
              child: Column(
                children: [
                  SvgPicture.asset("assets/svgs/sheet.svg", color: Colors.white, width: 20, height: 20),
                  SizedBox(height: 2),
                  Text("解析卡", style: TextStyle(fontSize: 12, color: Colors.white))
                ],
              )
            ),
          )
        ],
      )
    );
  }

  // 答题卡弹出层
  void _showSheetCard(ExamParsePageModel model) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MSizeFit.statusBarHeight),
              Container(
                child: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  title: Text('解析卡', style: TextStyle(fontSize: 16,color: Colors.black)),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  brightness: Brightness.light,
                  iconTheme: IconThemeData(color: Colors.black),
                )
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.only(left: 0, top: 15, right: 0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, 
                    childAspectRatio: 1.4, 
                    // mainAxisSpacing: 12.0,
                    // crossAxisSpacing: 12.0,
                  ),
                  itemCount: model.tiledItemList.length,
                  itemBuilder: (context, index) {
                    var itemModel = model.tiledItemList[index];

                    return Container(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          model.setMoveIndex(showIndex: itemModel.index, showSubIndex: itemModel.subIndex ?? 0);
                          // 主问题跳转
                          _swiperController.move(itemModel.index);
                          // 子问题跳转
                          if (itemModel.index == model.showIndex) {
                            if (_subSwiperController != null) {
                              _subSwiperController?.move(itemModel.subIndex ?? 0);
                            }
                          }                            
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: itemModel.answer.length > 0 ? (itemModel.isRight == 1 ? Colors.blue : Colors.red) : Colors.blue, width: 1),
                            color: itemModel.answer.length > 0 ? (itemModel.isRight == 1 ? Colors.blue : Colors.red) : Colors.white,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Text("${index+1}", style: TextStyle(fontSize: 14, color: itemModel.answer.length > 0 ? Colors.white : Colors.black)),
                        )
                      )
                    );
                  }
                )
              )
            ],
          ),
        );
      },
    );
  }

  // 收藏夹弹出层
  void _showFavoriteFolder(ExamParsePageModel model) {
    List<FavoriteFolderModel> folderList = model.favoriteFolderList;
    int itemChecked = 0;

    showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.white,
      // isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Container(
                    child: AppBar(
                      leading: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      title: Text('选择考题收藏夹', style: TextStyle(fontSize: 16,color: Colors.black)),
                      centerTitle: true,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      brightness: Brightness.light,
                      iconTheme: IconThemeData(color: Colors.black),
                    )
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return CenterFieldDialog(
                            contentWidget: CenterFieldDialogContent(
                              title: "新建收藏夹",
                              hintText: "请输入收藏夹名称",
                              cancelBtnTitle: "取消",
                              okBtnTitle: "确定",
                              okBtnTap: (text) {
                                model.favoriteFolderCreate(data: {'name': text, 'type': 1}, callback: (res) {
                                  model.getFavoriteFolderList(callback: (list) {
                                    state(() {
                                      folderList = list;
                                    });
                                  });                                  
                                });
                              }, 
                              cancelBtnTap: () {},
                            ),
                          );
                        }
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      alignment: Alignment.centerRight,
                      child: Text('新建收藏夹', style: TextStyle(fontSize: 14, color: Colors.blue)),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.only(top: 8.0, bottom: MSizeFit.bottomBarHeight + 12, left: 15.0, right: 15.0),
                      itemBuilder: (context, index) {
                        return ListItemSingle(
                          content: folderList[index].name,
                          value: index,
                          itemChecked: itemChecked,
                          onChanged: (value) {
                            if (itemChecked != index) {
                              state(() {
                                itemChecked = index;
                              });
                            }
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 12);
                      },
                      itemCount: folderList.length
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.only(left: 15, right: 15),
                    width: double.infinity,
                    // color: Colors.red,
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: folderList[itemChecked] != null ? () {
                        model.userFavoriteCreate(
                          data: {'ref_type': 1, 'ref_id': model.showItemModel.id, 'folder_id': folderList[itemChecked].id},
                          callback: (res) {
                            model.showItemModel.favorite = true;
                          }
                        );
                        NavigatorManager.pop();   
                      } : null,
                      color: Colors.blue,
                      disabledColor: Color(0xfff0f0f0),
                      textColor: Colors.white,
                      disabledTextColor: Colors.grey,
                      child: Text('确定', style: TextStyle())
                    )
                  ),
                  SizedBox(height: MSizeFit.bottomBarHeight),
                ],
              ),
            );
          }
        );
      },
    );
  }
}
