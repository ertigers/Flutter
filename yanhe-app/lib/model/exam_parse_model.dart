class ExamParseModel {
  num id;
  num itemId;
  num exerciseId;
  num paperId;
  num subjectId;
  String answer;
  num isRight;
  num score;

  ExamParseModel({
    this.id,
    this.itemId,
    this.exerciseId,
    this.paperId,
    this.subjectId,
    this.answer,
    this.isRight,
    this.score
  });

  ExamParseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    exerciseId = json['exercise_id'];
    paperId = json['paper_id'];
    subjectId = json['subject_id'];
    answer = json['answer'];
    isRight = json['is_right'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['exercise_id'] = this.exerciseId;
    data['paper_id'] = this.paperId;
    data['subject_id'] = this.subjectId;
    data['answer'] = this.answer;
    data['is_right'] = this.isRight;
    data['score'] = this.score;

    return data;
  }
}