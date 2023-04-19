import 'package:boxApp/model/exam_item_model.dart';
import 'package:boxApp/model/exam_answer_model.dart';
import 'package:boxApp/provider/exam_paper_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

const INDEX_KEYS = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'V', 'W', 'X', 'Y', 'Z'];
const ANSWER_TYPE_TEXTS = {'0': '单选题', '1': '多选题', '2': '填空题', '3': '判断题', '4': '自测题', '8': '材料题'};
const ANSWER_TYPE_KEYS = {'0': "单", "1": "多", "2": "填", "3": "判", "4": "测", "8": "材"};

class ExamPaperNormalItem extends StatelessWidget {
  final ExamItemModel itemModel;
  int length;
  int index;
  bool isParse;
  ExamPaperPageModel paperModel;
  Function chooseCallback = (ExamItemModel itemModel) => {};

  ExamPaperNormalItem({
    Key key, 
    @required this.itemModel, 
    @required this.paperModel, 
    @required this.length, 
    @required this.index, 
    this.isParse = false,
    @required this.chooseCallback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTop(),          
          Expanded(
            child: _buildBottom()
          )
        ],
      )
    );
  }

  Widget _buildTop() {
    return Container(
      padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 15),
      height: 200,
      color: Color(0xfff6f6f6),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(right: 8),
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(6.0)
                ),
                child: Text(ANSWER_TYPE_KEYS[itemModel.answerType.toString()], style: TextStyle(fontSize: 14, color: Colors.white))
              ),
              Expanded(
                child: Text(itemModel.answerTypeText ?? ANSWER_TYPE_TEXTS[itemModel.answerType.toString()], style: TextStyle(fontSize: 16, color: Color(0xff000000)))
              ),
              Text("${index+1}/${length}", style: TextStyle(fontSize: 16, color: Color(0xff000000)))
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Html(
                data: itemModel.description,
                style: {                           
                  "body": Style(
                    padding: EdgeInsets.all(0),
                    margin: EdgeInsets.all(0)
                  ),
                  "p": Style(
                    padding: EdgeInsets.all(0),
                    margin: EdgeInsets.all(0)
                  ),
                },
              ),
            )
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    List<Widget> list = [];
    itemModel.options.asMap().forEach((key, value) {
      list.add(_buildOptionItem(value, key));
    });
    if (itemModel.showSolveGuide) {
      list.addAll(_buildSolveGuide());
    }    
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list,
        )
      )
    );
  }

  Widget _buildOptionItem(ExamAnswerModel answer, int index) {
    var indexKey = INDEX_KEYS[index];
    var v = answer.id.toString();
    var answers = itemModel.answer.length > 0 ? itemModel.answer.split(',') : [];

    return Container(
      margin: EdgeInsets.only(top: 12, bottom: 12),
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              // 解析状态，不作其它操作
              if (isParse) { 
                return;
              }
              if (itemModel.answerType == 1) {                
                if (answers.contains(v)) {
                  answers.removeWhere((element) => element == v);
                } else {
                  answers.add(v);
                }
                itemModel.answer = answers.join(',');
              } else {
                itemModel.answer = answer.id.toString();
              }
              chooseCallback(itemModel);
            },
            child: Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 1),
                color: answers.contains(v) ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.circular(itemModel.answerType == 1 ? 6 : 22),
              ),
              child: Text(indexKey, style: TextStyle(fontSize: 14, color: answers.contains(v) ? Colors.white : Colors.blue)),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Html(
              data: answer.description,
              style: {                           
                "body": Style(
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.all(0)
                ),
                "p": Style(
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.all(0)
                ),
                "span": Style(
                  backgroundColor: Colors.transparent
                ),
              },
            )
          )
        ],
      )
    );
  }

  List<Widget> _buildSolveGuide() {
    List<Widget> list = [];

    list.add(Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.only(left: 15, top: 5, right: 15, bottom: 5),
      decoration: BoxDecoration(
        color: Color(0xffffd85d),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16)
        )
      ),
      child: Text("答案", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold)),
    ));
    list.add(Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '正确答案：【',
                  style: TextStyle(fontSize: 14, color: Color(0xff333333))
                ),
                TextSpan(
                  text: _computeRightOption(itemModel),
                  style: TextStyle(fontSize: 14, color: Colors.blue)
                ),
                TextSpan(
                  text: '】',
                  style: TextStyle(fontSize: 14, color: Color(0xff333333))
                )
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '你的答案：【',
                  style: TextStyle(fontSize: 14, color: Color(0xff333333))
                ),
                TextSpan(
                  text: _computeUserOption(itemModel),
                  style: TextStyle(fontSize: 14, color: Colors.blue)
                ),
                TextSpan(
                  text: '】',
                  style: TextStyle(fontSize: 14, color: Color(0xff333333))
                )
              ],
            ),
          ),
        ],
      ),
    ));
    list.add(Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Text("共${itemModel.userCount}位考生做过此题，平均正确率：【${(itemModel.rightRate * 100).toInt()}%】", style: TextStyle(fontSize: 14, color: Colors.black))
    ));

    list.add(Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.only(left: 15, top: 5, right: 15, bottom: 5),
      decoration: BoxDecoration(
        color: Color(0xffffd85d),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16)
        )
      ),
      child: Text("题目解析", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold)),
    ));
    list.add(Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Html(
        data: itemModel.solveGuide,
        style: {                           
          "body": Style(
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(0)
          ),
          "p": Style(
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(0)
          ),
          "span": Style(
            backgroundColor: Colors.transparent
          ),
        },
      )
    ));
    return list;
  }

  // 正确选项计算
  String _computeRightOption(ExamItemModel itemModel) {
    List<int> indexs = [];
    for (var i = 0; i < itemModel.options.length; i++) {
      var item = itemModel.options[i];
      if (item.trueOption == 1) {
        indexs.add(i);
      }
    }
    if (indexs.length > 0) {
      var list = indexs.map((index) => INDEX_KEYS[index]).toList();
      list.sort();
      return list.join('、');
    }
    return "未设置";
  }

  // 计算用户选项
  String _computeUserOption(ExamItemModel itemModel) {
    List<int> indexs = [];
    if (itemModel.answer != null && itemModel.answer.length > 0) {
      itemModel.answer.split(',').forEach((item) {
        var index = itemModel.options.indexWhere((option) => option.id == int.parse(item));
        if (index != -1) {
          indexs.add(index);
        }
      });
    }
    if (indexs.length > 0) {
      var list = indexs.map((index) => INDEX_KEYS[index]).toList();
      list.sort();
      return list.join('、');
    }
    return '未作答';
  }
}