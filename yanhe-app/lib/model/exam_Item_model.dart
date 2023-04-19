import 'package:boxApp/model/exam_answer_model.dart';

class ExamItemModel {
  int id;
  int itemId;
  dynamic pid;
  dynamic difficulty;
  dynamic score;
  String answerTypeText;
  int answerType;
  String description;
  String solveGuide;
  dynamic source;
  dynamic userCount;
  dynamic totalCount;
  dynamic rightCount;
  dynamic rightRate;
  int status;
  int material;
  int materialType;
  String richText;
  dynamic resourceId;
  String videoAnalysisUrl;
  List<ExamAnswerModel> options;
  List<ExamItemModel> children;
  bool favorite;
  // 私有属性 用作逻辑判断
  String answer = '';
  int isRight;
  bool showSolveGuide = false;
  int index;
  int subIndex;

  ExamItemModel({
    this.id,
    this.itemId,
    this.pid,
    this.difficulty,
    this.score,
    this.answerTypeText,
    this.answerType,
    this.description,
    this.solveGuide,
    this.source,
    this.userCount,
    this.totalCount,
    this.rightCount,
    this.rightRate,
    this.status,
    this.material,
    this.materialType,
    this.richText,
    this.resourceId,
    this.videoAnalysisUrl,
    this.options,
    this.children,
    this.answer,
    this.isRight,
    this.favorite
  });

  ExamItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    pid = json['pid'];
    difficulty = json['difficulty'];
    score = json['score'];
    answerTypeText = json['answer_type_text'];
    answerType = json['answer_type'];
    description = json['description'];
    solveGuide = json['solve_guide'];
    source = json['source'];
    userCount = json['user_count'];
    totalCount = json['total_count'];
    rightCount = json['right_count'];
    rightRate = json['right_rate'];
    status = json['status'];
    material = json['material'];
    materialType = json['material_type'];
    richText = json['rich_text'];
    resourceId = json['resource_id'];
    videoAnalysisUrl = json['video_analysis_url'];

    if (json['options'] != null) {
      options = (json['options'] as List).map((item) => ExamAnswerModel.fromJson(item)).toList();
    }
    if (json['answer'] != null) {
      answer = json['answer'];
    }
    if (json['favorite'] != null) {
      favorite = json['favorite'];
    }
    if (json['is_right'] != null) {
      isRight = json['is_right'];
    }
    if (json['children'] != null) {
      children = (json['children'] as List).map((item) => ExamItemModel.fromJson(item)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['pid'] = this.pid;
    data['difficulty'] = this.difficulty;
    data['score'] = this.score;
    data['answer_type_text'] = this.answerTypeText;
    data['bgCanswer_typeolor'] = this.answerType;
    data['description'] = this.description;
    data['solve_guide'] = this.solveGuide;
    data['source'] = this.source;
    data['user_count'] = this.userCount;
    data['total_count'] = this.totalCount;
    data['right_count'] = this.rightCount;
    data['right_rate'] = this.rightRate;
    data['status'] = this.status;
    data['material'] = this.material;
    data['material_type'] = this.materialType;
    data['rich_text'] = this.richText;
    data['resource_id'] = this.resourceId;
    data['video_analysis_url'] = this.videoAnalysisUrl;
    data['answer'] = this.answer;
    data['is_right'] = this.isRight;
    data['favorite'] = this.favorite;

    if (this.options != null) {
      data['options'] = this.options.map((item) => item.toJson()).toList();
    } else {
      data['options'] = this.options;
    }
    if (this.children != null) {
      data['children'] = this.children.map((item) => item.toJson()).toList();
    } else {
      data['children'] = this.children;
    }

    return data;
  }
}