class ExamChapterModel {
  int id;
  int pid;
  int examId;
  int paperId;
  int itemCount;
  int learnItemCount;
  int level;
  String name;
  int createTime;
  List<ExamChapterModel> children;
  int subjectId;

  ExamChapterModel({
    this.id,
    this.pid,
    this.examId,
    this.paperId,
    this.itemCount,
    this.learnItemCount,
    this.level,
    this.name,
    this.createTime,
    this.children
  });

  ExamChapterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pid = json['pid'];
    examId = json['exam_id'];
    paperId = json['paper_id'];
    itemCount = json['item_count'];
    learnItemCount = json['learn_item_count'];
    level = json['level'];
    name = json['name'];
    createTime = json['create_time'];

    if (json['children'] != null) {
      children = (json['children'] as List).map((item) => ExamChapterModel.fromJson(item)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pid'] = this.pid;
    data['exam_id'] = this.examId;
    data['paper_id'] = this.paperId;
    data['item_count'] = this.itemCount;
    data['learn_item_count'] = this.learnItemCount;
    data['level'] = this.level;
    data['name'] = this.name;
    data['create_time'] = this.createTime;

    if (this.children != null) {
      data['children'] = this.children.map((item) => item.toJson()).toList();
    } else {
      data['children'] = this.children;
    }
    
    return data;
  }
}