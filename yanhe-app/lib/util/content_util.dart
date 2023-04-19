import 'package:boxApp/model/authorize_model.dart';
import 'package:boxApp/model/exam_model.dart';

class ContentUtils {

  ContentUtils._();

  static Map<String, dynamic> computeExamAuthStatus(ExamModel exam) {
    AuthorizeModel auth = exam.auth;
    var timestamp = DateTime.now().millisecondsSinceEpoch;
    Map<String, dynamic> data = {};
    String status = '';

    // 免费
    if (exam.price <= 0 ) {
      status = 'free';
    }
    // VIP免费
    else if (auth != null && auth.authType == 8 && auth.expireTime > timestamp) {
      status = 'vip_free';
    }
    // 已开通
    else if (auth != null && auth.authType == 1 && auth.expireTime > timestamp) {
      status = 'bought';
    }
    // 试用
    else if (auth != null && auth.authType == 0 && auth.trialCount > 0) {
      status = 'try';
    }
    // VIP免费解锁
    else if (exam.authVipStatus && exam.vipDiscountRate == 0) {
      status = 'unlock';
    }
    // 购买
    else if (exam.price > 0) {
      status = 'buy';
    }
    data['status'] = status;
    data['totalTrialCount'] = exam.trialCount;
    data['usableTrialCount'] = auth != null ? auth.trialCount : 0;

    return data;
  }

}
