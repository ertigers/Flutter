import 'package:boxApp/util/size_fit.dart';
import 'package:flutter/material.dart';

class BottomFieldContent extends StatefulWidget {
  String defaultValue;
  String title;
  String hintText;
  String okBtnTitle;
  Function okBtnTap;
  TextEditingController vc;

  BottomFieldContent({
    Key key,
    this.defaultValue,
    this.title,
    this.hintText,
    this.okBtnTitle = "Ok",
    this.okBtnTap,
    this.vc
  }) : super(key: key);

  @override
  _BottomFieldContentState createState() => _BottomFieldContentState();  
}

class _BottomFieldContentState extends State<BottomFieldContent> {
  ///文本输入框的默认使用控制器
  TextEditingController _defaultTextController;
  TextEditingController _textController;
  bool isShowError = false;

  @override
  void initState() {
    super.initState();

    _defaultTextController = TextEditingController(text: widget.defaultValue ?? '');
    _textController = widget.vc ?? _defaultTextController;
  }

  @override
  void dispose() {
    _defaultTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 0, bottom: MediaQuery.of(context).viewInsets.bottom + MSizeFit.bottomBarHeight),
      child: Container(
        // height: 200,
        // padding: EdgeInsets.only(top: 0, bottom: MediaQuery.of(context).viewInsets.bottom + MSizeFit.bottomBarHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close, size: 18),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title ?? '', style: TextStyle(fontSize: 14, color: Color(0xff666666))),
                  SizedBox(height: 12),
                  TextField(
                    maxLines: 1,
                    style: TextStyle(color: Colors.black87),
                    controller: _textController,
                    decoration: InputDecoration(
                      helperText: isShowError ? (widget.hintText ?? "请输入内容") : "",
                      helperStyle: TextStyle(fontSize: 14, color: Colors.red),
                      hintText: widget.hintText ?? "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))
                      ),
                    ),
                    onChanged: (text) {
                      if (text.isNotEmpty) {
                        setState(() {
                          isShowError = false;
                        });
                      }
                    }
                  ),
                  SizedBox(height: 18),
                  Container(
                    alignment: Alignment.center,
                    child: FlatButton(
                      minWidth: MSizeFit.screenWidth / 2,
                      height: 44,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(44),
                      ),
                      onPressed: () {
                        var text =_textController.text;
                        if (text.isEmpty) {
                          setState(() {
                            isShowError = true;
                          });
                          return;
                        }
                        widget.okBtnTap(text);
                        Navigator.of(context).pop();
                      },
                      color: Colors.blue,
                      disabledColor: Color(0xfff0f0f0),
                      textColor: Colors.white,
                      disabledTextColor: Colors.grey,
                      child: Text(widget.okBtnTitle, style: TextStyle())
                    )
                  )
                ],
              )
            )
          ],
        ),
      )
    );
  }
}