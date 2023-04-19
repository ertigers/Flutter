import 'package:boxApp/model/favorite_folder_model.dart';
import 'package:boxApp/model/paper_params_model.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/page/paper/material_item.dart';
import 'package:boxApp/page/paper/normal_item.dart';
import 'package:boxApp/page/paper/report.dart';
import 'package:boxApp/provider/exam_paper_model.dart';
import 'package:boxApp/util/size_fit.dart';
import 'package:boxApp/widget/center_field_dialog.dart';
import 'package:boxApp/widget/list_item_single.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';



class ExamPaperPage extends StatefulWidget {
  PaperParamsModel params;

  ExamPaperPage({Key key, @required this.params}) : super(key: key);

  @override
  _ExamPaperPageState createState() => _ExamPaperPageState();
}

class _ExamPaperPageState extends State<ExamPaperPage> {
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
    return ProviderWidget<ExamPaperPageModel>(
      model: ExamPaperPageModel(params: widget.params),
      onModelInit: (model) {
        model.loadData();
      },
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(widget.params.title, style: TextStyle(fontSize: 18,color: Colors.black)),
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
                        itemBuilder: (BuildContext context, int index) {
                          var itemModel = model.itemList[index];

                          if (itemModel.answerType == 8) {
                            return ExamPaperMaterialItem(
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
                          model.updateShowItemIndex(model.computeItemIndex(index), refresh: false);
                          model.setMoveIndex(showIndex: index, showSubIndex: 0);
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

  Widget _buildMenu(ExamPaperPageModel model) {
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
                  Text("答题卡", style: TextStyle(fontSize: 12, color: Colors.white))
                ],
              )
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                _showSubmitPaper(model);
              },
              child: Column(
                children: [
                  SvgPicture.asset("assets/svgs/submit_paper.svg", color: Colors.white, width: 20, height: 20),
                  SizedBox(height: 2),
                  Text("交卷", style: TextStyle(fontSize: 12, color: Colors.white))
                ],
              )
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                model.showItemModel.showSolveGuide = !model.showItemModel.showSolveGuide;
                model.updateItemModel(model.showItemModel);
              },
              child: Column(
                children: [
                  SvgPicture.asset((model.itemList.length > 0 && model.showItemModel.showSolveGuide) ? "assets/svgs/shut.svg" : "assets/svgs/view.svg", color: Colors.white, width: 20, height: 20),
                  SizedBox(height: 2),
                  Text((model.itemList.length > 0 && model.showItemModel.showSolveGuide) ? "收起答案" : "查看答案", style: TextStyle(fontSize: 12, color: Colors.white))
                ],
              )
            ),
          )
        ],
      )
    );
  }

  // 答题卡弹出层
  void _showSheetCard(ExamPaperPageModel model) {
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
                  title: Text('答题卡', style: TextStyle(fontSize: 16,color: Colors.black)),
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
                              _subSwiperController.move(itemModel.subIndex ?? 0);
                            }
                          }                            
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 1),
                            color: itemModel.answer.length > 0 ? Colors.blue : Colors.white,
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
  void _showFavoriteFolder(ExamPaperPageModel model) {
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

  void _showSubmitPaper(ExamPaperPageModel model) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        var list = model.tiledItemList.where((element) => element.answer.length > 0);
        var unanswered = model.tiledItemList.length - list.length;

        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          title: Container(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xffe2eaff),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4)
              )
            ),
            child: Text('温馨提示', style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.normal)),
          ),
          contentPadding: EdgeInsets.only(bottom: 12),
          content: Container(
            height: 160,
            alignment: Alignment.center,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      unanswered > 0 ? '尚有${unanswered}题未作答，确定交卷吗？' : '确定交卷吗？', 
                      style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.normal)
                    )
                  )
                ),
                SizedBox(
                  height: 30,
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    minWidth: 120,
                    height: 30,
                    onPressed: () {
                      Map<String, dynamic> data = {};
                      List<Map<String, dynamic>> answers = [];
                      
                      model.tiledItemList.forEach((item) {
                        answers.add({
                          'item_id': item.itemId,
                          'answer': item.answer
                        });
                      });

                      if (widget.params.subjectId != null) {
                        data['subject_id'] = widget.params.subjectId;
                      }
                      if (widget.params.examId != null) {
                        data['exam_id'] = widget.params.examId;
                      }
                      if (widget.params.paperId != null) {
                        data['paper_id'] = widget.params.paperId;
                      }
                      if (widget.params.chapterId != null) {
                        data['chapter_id'] = widget.params.chapterId;
                      }
                      
                      data['start_time'] = startTime;
                      data['submit_time'] = DateTime.now().millisecondsSinceEpoch;
                      data['answers'] = answers;

                      model.userExamExerciseCreate(data: data, callback: (res) {
                        NavigatorManager.pop();                                   
                        NavigatorManager.pushReplacement(ExamReportPage(parseId: res['data']['id']));
                      });
                    },
                    color: Colors.blue,
                    child: Text('确定', style: TextStyle(color: Colors.white))
                  ),
                ),
                SizedBox(height: 8),
                SizedBox(
                  height: 30,
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    minWidth: 120,
                    height: 30,
                    onPressed: () {
                      NavigatorManager.pop();   
                    },
                    color: Color(0xfff0f0f0),
                    child: Text('取消', style: TextStyle(color: Color(0xff666666)))
                  ),
                )
              ],
            ),
          )
        );
      }
    );
  }
}
