import 'package:boxApp/model/exam_parse_model.dart';

class ExamExerciseModel {
  num id;
  num uid;
  num examId;
  num paperId;
  num paperType;
  num itemCount;
  num rightCount;
  num rightRate;
  num score;
  num totalCount;
  num startTime;
  num submitTime;
  num costTime;
  num rank;
  num highestRank;
  num refreshHighestRankCount;
  List<ExamParseModel> answers;

  ExamExerciseModel({
    this.id,
    this.uid,
    this.examId,
    this.paperId,
    this.paperType,
    this.itemCount,
    this.rightCount,
    this.rightRate,
    this.score,
    this.totalCount,
    this.startTime,
    this.submitTime,
    this.costTime,
    this.rank,
    this.highestRank,
    this.refreshHighestRankCount,
    this.answers
  });

  ExamExerciseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    examId = json['exam_id'];
    paperId = json['paper_id'];
    paperType = json['paper_type'];
    itemCount = json['item_count'];
    rightCount = json['right_count'];
    rightRate = json['right_rate'];
    score = json['score'];
    totalCount = json['total_count'];
    startTime = json['start_time'];
    submitTime = json['submit_time'];
    costTime = json['cost_time'];
    rank = json['rank'];
    highestRank = json['highest_rank'];
    refreshHighestRankCount = json['refresh_highest_rank_count'];
    
    if (json['answers'] != null) {
      answers = (json['answers'] as List).map((item) => ExamParseModel.fromJson(item)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = id;
    data['uid'] = uid;
    data['exam_id'] = examId;
    data['paper_id'] = paperId;
    data['paper_type'] = paperType;
    data['item_count'] = itemCount;
    data['right_count'] = rightCount;
    data['right_rate'] = rightRate;
    data['score'] = score;
    data['total_count'] = totalCount;
    data['start_time'] = startTime;
    data['submit_time'] = submitTime;
    data['cost_time'] = costTime;
    data['rank'] = rank;
    data['highest_rank'] = highestRank;
    data['refresh_highest_rank_count'] = refreshHighestRankCount;
    
    if (answers != null) {
      data['answers'] = answers.map((item) => item.toJson()).toList();
    } else {
      data['answers'] = answers;
    }

    return data;
  }
}