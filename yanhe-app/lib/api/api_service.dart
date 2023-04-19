import 'package:boxApp/page/entry.dart';
import 'package:boxApp/util/toast_util.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/util/app_manager.dart';

class ApiService {
  ApiService._();
  static Dio _dio;

  // host
  static const baseUrl = 'http://192.168.1.128:5001/api/v1/front';
  // static const baseUrl = 'http://box-api.koudaikaoyan.com/api/v1/front';

  // 用户登入
  static const sendSmscode = '$baseUrl/sendSmsCode';
  // 验证码登入
  static const loginBySmsCode = '$baseUrl/member/loginBySmsCode';
  // 用户注册
  static const register = '$baseUrl/member/register';
  // 用户信息
  static const userInfo = '$baseUrl/member';
  // 用户报考信息
  static const userApplicant = '$baseUrl/member/applicant';
  // 用户已选科目
  static const userSubjectList = '$baseUrl/member/subject/list';
  // 用户科目添加、删除
  static const userSubject = '$baseUrl/member/subject';
  // 科目信息
  static const subjectInfo = '$baseUrl/subject';
  // 用户可添加科目列表
  static const subjectUsableList = '$baseUrl/member/subject/usable/list';  
  // 用户科目学习统计
  static const userSubjectCounts = '$baseUrl/member/subject/counts';
  // 用户已选参考书
  static const userConsultList = '$baseUrl/member/consult/list';
  // 用户参考书添加、删除
  static const userConsult = '$baseUrl/member/consult';
  // 参考书信息
  static const consultInfo = '$baseUrl/consult';
  // 用户可添加参考书列表
  static const consultUsableList = '$baseUrl/member/consult/usable/list';  
  // 用户题库最近练习
  static const userExamRecent = '$baseUrl/member/exam/recent';
  // 科目&题库列表
  static const examList = '$baseUrl/exam/list';
  // 科目&题库列表
  static const examContent = '$baseUrl/exam/content';
  // 题库>试卷内容
  static const paperContent = '$baseUrl/examPaper/content';
  // 题库>题目列表
  static const paperItemList = '$baseUrl/examPaper/item/list';
  // 题库>试卷内容
  static const userExamTrial = '$baseUrl/member/exam/trial';
  // 用户交卷
  static const userExamExercise = '$baseUrl/member/examExercise';
  // 用户收藏
  static const userFavorite = '$baseUrl/member/favorite';
  // 用户收藏夹列表
  static const userFavoriteFolderList = '$baseUrl/member/favoriteFolder/list';
  // 用户收藏夹
  static const userFavoriteFolder = '$baseUrl/member/favoriteFolder';
  // 用户收藏夹出题
  static const userFavoriteItems = '$baseUrl/member/favorite/items';
  // 用户错题本
  static const userExamMistakeFolder = '$baseUrl/member/examMistakeFolder/list';
  // 用户错题本出题
  static const userExamMistakeItems = '$baseUrl/member/examMistake/items';
  // 图片上传 token
  static const uploadImageToken = '$baseUrl/upload/image/token';
  // 图片上传
  static const uploadImage = '$baseUrl/upload/image';
  // 院校列表
  static const collegeList = '$baseUrl/college/list';
  // 院校专业列表
  static const collegeMajorList = '$baseUrl/college/major/list';
  // 专业科目列表
  static const majorSubjectList = '$baseUrl/major/subject/list';
  // 用户收货地址列表
  static const userAddressList = '$baseUrl/member/address/list';
  // 用户收货地址
  static const userAddress = '$baseUrl/member/address';
  // 课程
  static const courseInfo = '$baseUrl/course';
  // 课程列表
  static const courseList = '$baseUrl/course/list';
  // 课程内容
  static const courseContent = '$baseUrl/course/content';
  // 资料
  static const materialInfo = '$baseUrl/material';
  // 资料列表
  static const materialList = '$baseUrl/material/list';
  // 资料内容
  static const materialContent = '$baseUrl/material/content';




  // 静态资源域名
  static const static_domain = '$baseUrl/storage/qiniu/domain';
  


  static Dio getInstance() {
    if (_dio == null) {
      BaseOptions options = new BaseOptions(
        connectTimeout: 5000,
        receiveTimeout: 10000,
      );
      _dio = new Dio(options);
      _dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        print('url:${options.uri}');
        print('method ${options.method}');
        print('headers:${options.headers}');
        print('data:\n${options.data}');
        print('queryParameters:\n${options.queryParameters}');
        return options;
      }, onResponse: (Response response) {
        print('url:${response.request.uri}');
        print('response:${response.data}');
        return response;
      }, onError: (DioError e) {
        print('Error url:${e.request.uri}');
        return e;
      }));

      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (url) {
          ///设置代理 电脑ip地址
          // return "PROXY 127.0.0.1:8888";

          ///不设置代理
          return 'DIRECT';
        };

        ///忽略证书
        // client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      };
    }
    return _dio;
  }

  ///统一网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[success] 请求成功回调
  ///[fail] 请求失败回调
  ///[complete] 请求完成回调
  ///[options] 请求配置
  static Future request(String url,
      {String method,
      data,
      Map<String, dynamic> params,
      Options options,
      Function success,
      Function fail,
      Function onSendProgress,
      Function onReceiveProgress,
      Function complete}) async {
    //检查网络是否连接
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      if (fail != null) {
        fail("网络异常，请稍后重试！");
      }
      return;
    }

    //设置默认值
    params = params ?? {};
    method = method ?? 'GET';

    options?.method = method;

    options = options ?? Options(method: method);

    // headers设置
    final accessToken = AppManager.prefs.getString('token') ?? '';
    if (accessToken != null) {
      options = options.merge(headers: {"Authorization": accessToken});
    }

    url = _restfulUrl(url, params);

    try {
      Response response = await getInstance().request(
        url, 
        data: data, 
        queryParameters: params, 
        options: options,
        // onSendProgress: (int progress, int total) {
        //   print("当前进度是 $progress 总进度是 $total");
        //   if (onSendProgress != null) {
        //     onSendProgress(progress, total);
        //   }
        // },
        // onReceiveProgress: (int received, int total) {
        //   if (onSendProgress != null) {
        //     onSendProgress(received, total);
        //   }
        // }
      );
      if (response.data['code'] != 0) {
        if (response.data['error'] != null) {
          throw DioError(response: response, error: response.data['error']);
        } else {
          throw '请求异常！';
        }
      }
      if (success != null) {
        success(response.data);
      }
      return response.data;
    } on DioError catch (e) {
      print(e);
      // token过期 重新登录
      if (e.response.data['code'] == 401) {
        // 跳转目标页面的同时清除其它页面的路径，防止滑动返回
        AppManager.prefs.clear();
        NavigatorManager.pushAndRemoveUntil(EntryPage());
      }
      if (fail != null) {
        fail(e);
      } else {
        ToastUtils.showError(e.error);
        Future.error(e);
      }
    } finally {
      if (complete != null) {
        complete();
      }
    }
  }

  ///restful处理
  static String _restfulUrl(String url, Map<String, dynamic> params) {
    // restful 请求处理
    // /gysw/search/hist/:user_id        user_id=27
    // 最终生成 url 为     /gysw/search/hist/27
    params.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });
    return url;
  }
}
