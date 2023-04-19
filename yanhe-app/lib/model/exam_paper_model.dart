import 'package:boxApp/model/exam_Item_model.dart';

class ExamPaperModel {
  int id;
  String name;
  dynamic difficulty;
  int type;
  int score;
  int itemCount;
  int status;
  List<ExamItemModel> examItems;

  ExamPaperModel({
    this.id,
    this.name,
    this.difficulty,
    this.type,
    this.score,
    this.itemCount,
    this.status,
    this.examItems
  });

  ExamPaperModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    difficulty = json['difficulty'];
    type = json['type'];
    score = json['score'];
    itemCount = json['item_count'];
    status = json['status'];

    if (json['examItems'] != null) {
      examItems = (json['examItems'] as List).map((item) => ExamItemModel.fromJson(item)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;
    data['difficulty'] = this.difficulty;
    data['type'] = this.type;
    data['score'] = this.score;
    data['item_count'] = this.itemCount;
    data['status'] = this.status;

    if (this.examItems != null) {
      data['examItems'] = this.examItems.map((item) => item.toJson()).toList();
    } else {
      data['examItems'] = this.examItems;
    }
    
    return data;
  }
}