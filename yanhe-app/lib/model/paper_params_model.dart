import 'package:flutter/cupertino.dart';

class PaperParamsModel {
  String type;   // paper: 试卷，mistake: 错题本，favorite: 收藏夹
  String title;  // 练习标题
  int  paperId;  // 试卷id
  int folderId;  // 收藏夹/错题本id
  int random;    // 是否随机出题
  int examId;    // 题库id
  int chapterId; // 章节id
  int subjectId; // 科目id

  PaperParamsModel({
    @required this.type,
    @required this.title,
    this.paperId,
    this.folderId,
    this.random,
    this.examId,
    this.chapterId,
    this.subjectId
  });
}