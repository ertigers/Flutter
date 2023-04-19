class ExamAnswerModel {
  int id;
  int itemId;
  String description;
  int trueOption;
  int sort;

  ExamAnswerModel({
    this.id,
    this.itemId,
    this.description,
    this.trueOption,
    this.sort
  });

  ExamAnswerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    description = json['description'];
    trueOption = json['true_option'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['description'] = this.description;
    data['true_option'] = this.trueOption;
    data['sort'] = this.sort;

    return data;
  }
}