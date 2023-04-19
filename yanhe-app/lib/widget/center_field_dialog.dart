import 'package:flutter/material.dart';

class CenterFieldDialog extends AlertDialog {

  CenterFieldDialog({Widget contentWidget}) : super(
    content: contentWidget,
    contentPadding: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      // side: BorderSide(color: Colors.blue, width: 3)
    ),
  );
}


double borderWidth = 0.5;

// ignore: must_be_immutable
class CenterFieldDialogContent extends StatefulWidget {
  String title;
  String hintText;
  String cancelBtnTitle;
  String okBtnTitle;
  Function cancelBtnTap;
  Function okBtnTap;
  TextEditingController vc;

  CenterFieldDialogContent({@required this.title,
    this.hintText,
    this.cancelBtnTitle = "Cancel",
    this.okBtnTitle = "Ok",
    this.cancelBtnTap,
    this.okBtnTap,
    this.vc});

  @override
  _CenterFieldDialogContentState createState() => _CenterFieldDialogContentState();
}

class _CenterFieldDialogContentState extends State<CenterFieldDialogContent> {
  ///文本输入框的默认使用控制器
  TextEditingController _defaultTextController= TextEditingController();
  bool isShowError = false;

  @override
  void dispose() {
    _defaultTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 180,
      // width: 10000,
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 16, color: Color(0xFF333333)),
            )
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: TextField(
              style: TextStyle(color: Colors.black87),
              controller: widget.vc ?? _defaultTextController,
              decoration: InputDecoration(
                hintText: widget.hintText ?? "",
                hintStyle: TextStyle(fontSize: 13, color: Color(0xff999999)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF1F86FE)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF1F86FE)),
                )
              ),
              onChanged: (text) {
                if (text.isNotEmpty) {
                  setState(() {
                    isShowError = false;
                  });
                }
              }
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            height: 30,
            alignment: Alignment.centerLeft,
            child: Text(isShowError ? (widget.hintText ?? "请输入内容") : "", style: TextStyle(fontSize: 12, color: Colors.red))
          ),
          Container(
            // margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Column(
              children: [
                Container(
                  // 按钮上面的横线
                  width: double.infinity,
                  color: Color(0xFFEEEEEE),
                  height: borderWidth,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(right: BorderSide(width: borderWidth, color: Color(0xFFEEEEEE))),
                        ),
                        child: FlatButton(
                          onPressed: () {
                            if (widget.vc != null) {
                              widget.vc.text = "";
                            } else {
                              _defaultTextController.text = "";
                            }                            
                            widget.cancelBtnTap();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            widget.cancelBtnTitle,
                            style: TextStyle(fontSize: 14, color: Color(0xFF1F86FE)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: FlatButton(
                          onPressed: () {
                            var text = widget.vc != null ? widget.vc.text : _defaultTextController.text;
                            if (text.isEmpty) {
                              setState(() {
                                isShowError = true;
                              });
                              return;
                            }
                            widget.okBtnTap(text);
                            Navigator.of(context).pop();
                            if (widget.vc != null) {
                              widget.vc.text = "";
                            } else {
                              _defaultTextController.text = "";
                            }    
                          },
                          child: Text(
                            widget.okBtnTitle,
                            style: TextStyle(fontSize: 14, color: Color(0xFF1F86FE)),
                          )
                        ),
                      ),
                    ),                    
                  ],
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}

