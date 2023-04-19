import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/page/auth/form_code.dart';
import 'package:boxApp/page/auth/login.dart';
import 'package:boxApp/provider/auth_page_model.dart';
import 'package:boxApp/util/constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/widget/provider_widget.dart';
import 'package:boxApp/page/webview/browser.dart';

class RegisterPage extends StatefulWidget {
  @override
  State createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isCodeShow = false;
  bool isAgree = true;

  @override
  void dispose() {
    _unameController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<AuthPageModel>(
      model: AuthPageModel(),
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
            centerTitle: false,
            actions: [
              IconButton(
                padding: EdgeInsets.only(right: 15),
                icon: Text('登录', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  NavigatorManager.push(LoginPage());
                },
              ),              
            ],
          ),
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              // 点击空白处收起键盘
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text(
                    '注册',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(51, 51, 51, 1)
                    )
                  ),
                  _buildForm(model),
                ],
              ),
            )
          )
        );
      }
    );
  }

  // 表单验证
  Map<String, dynamic> _formVerify() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    String phone = _unameController.text.trim();
    bool isPhone = Constant.isPhone(phone);
    String code = _pwdController.text.trim();
    bool isCode = Constant.isValidateCaptcha(code);
    data['phone'] = phone;
    data['isPhone'] = isPhone;
    data['code'] = code;
    data['isCode'] = isCode;
    data['isAgree'] = isAgree;

    return data;
  }

  //构建表单
  Widget _buildForm(AuthPageModel model) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      // padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Form(
        key: _formKey, //设置globalKey，用于后面获取FormState
        //开启自动校验
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: <Widget>[
            TextFormField(
              autofocus: false,
              controller: _unameController,
              decoration: InputDecoration(
                labelText: "手机号",
                hintText: "输入手机号",
                suffix: IconButton(
                  onPressed: () {
                    _unameController.clear();
                    setState(() {});
                  },
                  icon: Icon(Icons.cancel, size: 16, color: Color(0xFFd0d0d0)),
                ),
              ),
              onChanged: (text){
                if (text.isNotEmpty) {                  
                  setState(() {
                    isCodeShow = true;
                  });
                } else {
                  setState(() {
                    isCodeShow = false;
                  });
                }
              },  
              //校验用户名
              validator: (value) {
                if (!Constant.isPhone(value.trim())) {
                  return '请输入11位手机号码';
                }
                return null;
              }
            ),
            TextFormField(
              controller: _pwdController,
              decoration: InputDecoration(
                labelText: "验证码",
                hintText: "输入验证码",
                suffixIcon: isCodeShow ? InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoginFormCode(
                        available: _formVerify()['isPhone'],
                        onTapCallback: () async {
                          print('发送验证码操作');
                          var isOk = await model.getCode(_unameController.text.trim());
                          return isOk;
                        },
                      )
                    ],
                  ),
                  onTap: () {}
                ) : null
              ),
              onChanged: (text) {
                setState(() {});                  
              },
              obscureText: false,
              //校验密码
              validator: (value) {
                return value.trim().length == 6 ? null : "验证码格式不正确";
              }
            ),       
            SizedBox(height: 16,),
            Row(
              children: [
                InkWell(
                  onTap: () {                    
                    setState(() {
                      isAgree = !isAgree;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: isAgree ? Colors.blue : Color(0xFFCCCCCC), width: 1.5),
                      shape: BoxShape.circle, 
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Icon(Icons.check, size: 10.0, color: isAgree ? Colors.blue : Color(0xFFCCCCCC)),
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '我已阅读并同意 ',
                        style: TextStyle(fontSize: 12, color: Color(0xff999999))
                      ),
                      TextSpan(
                        text: '用户服务协议',
                        style: TextStyle(fontSize: 12, color: Color(0xFF333333), decoration: TextDecoration.underline,),
                        recognizer: TapGestureRecognizer()..onTap = () { 
                          print('《用户协议》');
                          NavigatorManager.push(Browser(url: 'http://render.koudaikaoyan.com/agreement', isFull: true));
                        },
                      ),
                      TextSpan(
                        text: ' 和 ',
                        style: TextStyle(fontSize: 12, color: Color(0xff999999))
                      ),
                      TextSpan(
                        text: '隐私政策',
                        style: TextStyle(fontSize: 12, color: Color(0xFF333333), decoration: TextDecoration.underline,),
                        recognizer: TapGestureRecognizer()..onTap = () { 
                          print('《隐私政策》');
                          NavigatorManager.push(Browser(url: 'http://render.koudaikaoyan.com/agreement', isFull: true));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),            
            // 登录按钮
            Padding(
              padding: const EdgeInsets.only(left: 0, top: 30.0, right: 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Builder(builder: (context) {
                      Map<String, dynamic> verify = _formVerify();
                      return RaisedButton(
                        padding: EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text("立即注册"),
                        color: Color(0xFF1F86FE),
                        disabledColor: Color(0xFFF8F8F8),
                        textColor: Colors.white,
                        disabledTextColor: Color(0xFFCCCCCC),
                        onPressed: (verify['isPhone'] && verify['isCode'] && verify['isAgree']) ? () {
                          print('注册操作');
                          model.register(verify['phone'], verify['code']);
                        } : null
                      );
                    })
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
