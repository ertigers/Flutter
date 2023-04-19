import 'package:boxApp/model/exam_chapter_model.dart';
import 'package:boxApp/model/exam_model.dart';
import 'package:boxApp/model/paper_params_model.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/page/order/buy.dart';
import 'package:boxApp/page/paper/paper.dart';
import 'package:boxApp/provider/exam_chapter_model.dart';
import 'package:boxApp/util/content_util.dart';
import 'package:boxApp/widget/empty.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class ExamChapterPage extends StatefulWidget {
  ExamModel examModel;

  ExamChapterPage({Key key, @required this.examModel}) : super(key: key);

  @override
  State createState() => _ExamChapterPageState();
}

class _ExamChapterPageState extends State<ExamChapterPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<ExamChapterPageModel>(
      model: ExamChapterPageModel(widget.examModel.id),
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
            title: Text(widget.examModel?.name ?? "题库章节", style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child: model.chapterList.length > 0 ? Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg_exam_list.png"),
                  fit: BoxFit.cover
                )
              ),
              child: Builder(builder: (context) {
                var authStatus = ContentUtils.computeExamAuthStatus(model.examModel);

                return Stack(
                  children: [
                    ListView.separated(
                      padding: EdgeInsets.only(top: 12.0, bottom: 24.0, left: 15.0, right: 15.0),
                      itemBuilder: (context, index) {
                        var chapter = model.chapterList[index];
                        if (widget.examModel != null && widget.examModel.subjectId != null) {
                          chapter.subjectId = widget.examModel.subjectId;
                        }
                        return ExamChapterItem(chapter: chapter);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 12);
                      },
                      itemCount: model.chapterList.length
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      right: 0,
                      bottom: 0,
                      child: Offstage(
                        offstage: authStatus['status'] == 'buy' ? false : true,
                        child: Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          alignment: Alignment.center,
                          color: Color(0xf0ffffff),
                          child: FractionallySizedBox(
                            widthFactor: 1.0,
                            heightFactor: 0.6,
                            child: Column(
                              children: [
                                Text('题库介绍', style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
                                SizedBox(height: 12),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Html(
                                      shrinkWrap: true,
                                      data: model.examModel.description != null ? model.examModel.description.replaceAll('\n', '<br/>') : "",
                                      style: {                       
                                        "body": Style(
                                          fontSize: FontSize(12),
                                          padding: EdgeInsets.all(0),
                                          margin: EdgeInsets.all(0)
                                        ),
                                        "p": Style(
                                          fontSize: FontSize(12),
                                          padding: EdgeInsets.all(0),
                                          margin: EdgeInsets.all(0)
                                        )
                                      },
                                    ),
                                  )
                                ),
                                SizedBox(height: 24),
                                Container(
                                  child: SizedBox(
                                    height: 30,
                                    child: FlatButton(
                                      padding: EdgeInsets.zero,
                                      minWidth: 160,
                                      onPressed: () {
                                        NavigatorManager.push(BuyPage());
                                      },
                                      color: Colors.blue,
                                      child: Text('¥${model.examModel.price} 开通本题库', style: TextStyle(color: Colors.white))
                                    ),
                                  )
                                ),
                              ],
                            )
                          )
                        )
                      )
                    )
                  ]
                );
              }
            )) : Container(
              margin: EdgeInsets.only(top: 50),
              child: Empty(),
            ),            
          )
        );
      }
    );
  }
}


class ExamChapterItem extends StatefulWidget {
  ExamChapterModel chapter;

  ExamChapterItem({key, this.chapter}) : super(key: key);

  @override
  State createState() => _ExamChapterItemState();

}

class _ExamChapterItemState extends State<ExamChapterItem> 
  with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _animationController;
  bool _isExpansion = false;

  var _crossFadeState = CrossFadeState.showFirst;

  bool get isFirst => _crossFadeState == CrossFadeState.showFirst;


  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _animation = Tween(begin: 0.0, end: 0.5).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _togglePanel() {
    setState(() {
      _crossFadeState = !isFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond;
    });
  }

  void _changeOpacity(bool expand) {
    setState(() {
      if (expand) {
        _animationController.forward();        
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            _isExpansion = !_isExpansion;
            _changeOpacity(_isExpansion);
            _togglePanel();
          },
          child: Container(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 12.0, right: 12.0),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${widget.chapter.name}",
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 13.0,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    RotationTransition(
                      turns: _animation,
                      child: const Icon(Icons.expand_more, size: 16, color: Color(0xffacacac)),
                    )
                  ],
                ),
                SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '已练习：',
                        style: TextStyle(fontSize: 12, color: Color(0xff666666))
                      ),
                      TextSpan(
                        text: '${widget.chapter.learnItemCount}',
                        style: TextStyle(fontSize: 12, color: Colors.blue),
                      ),
                      TextSpan(
                        text: '/${widget.chapter.itemCount}',
                        style: TextStyle(fontSize: 12, color: Color(0xff666666))
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ),
        _buildPanel(widget.chapter)
        
      ],
    );
  }

  Widget _buildPanel(ExamChapterModel chapter) {
    return AnimatedCrossFade(
      firstCurve: Curves.easeInCirc,
      secondCurve: Curves.easeInToLinear,
      firstChild: Container(),
      secondChild: Container(
        // height: 150,
        // color: Colors.blue,
        child: Column(
          children: chapter.children.map((e) {
            if (chapter.subjectId != null) {
              e.subjectId = chapter.subjectId;
            }
            return _buildSub(e);
          }).toList(),
        )
      ),
      duration: Duration(milliseconds: 300),
      crossFadeState: _crossFadeState,
    );
  }

  Widget _buildSub(ExamChapterModel chapter){
    //可以设置撑满宽度的盒子 称之为百分百布局
    return FractionallySizedBox(
      //宽度因子 1为百分百撑满
      widthFactor: 1,
      child: InkWell(
        onTap: () {
          NavigatorManager.push(ExamPaperPage(
            params: PaperParamsModel(
              type: 'paper',
              title: chapter.name,
              paperId: chapter.paperId,
              chapterId: chapter.id,
              examId: chapter.examId,
              subjectId: chapter.subjectId
            )
          ));
        },
        child: Container(
          margin: EdgeInsets.only(top: 12),
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 12.0, right: 12.0),
          decoration: BoxDecoration(
            color: Color(0xfff9f9f9),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${chapter.name}",
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 12.0,
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 5),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '已练习：',
                          style: TextStyle(fontSize: 11, color: Color(0xff666666))
                        ),
                        TextSpan(
                          text: '${chapter.learnItemCount}',
                          style: TextStyle(fontSize: 11, color: Colors.blue),
                        ),
                        TextSpan(
                          text: '/${chapter.itemCount}',
                          style: TextStyle(fontSize: 11, color: Color(0xff666666))
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF1F86FE), width: 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  "开始刷题",
                  style: TextStyle(
                    color: Color(0xFF1F86FE),
                    fontSize: 10.0,
                    // fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ),
        )
      )
    );
  }

}



