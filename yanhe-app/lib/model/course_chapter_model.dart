class CourseChapterModel {
  int id;
  int pid;
  int courseId;
  int level;
  String name;
  List<CourseChapterModel> children;
  int subjectId;

  CourseChapterModel({
    this.id,
    this.pid,
    this.courseId,
    this.level,
    this.name,
    this.children
  });

  CourseChapterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pid = json['pid'];
    courseId = json['course_id'];
    level = json['level'];
    name = json['name'];

    if (json['children'] != null) {
      children = (json['children'] as List).map((item) => CourseChapterModel.fromJson(item)).toList();
    } else {
      children = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pid'] = this.pid;
    data['course_id'] = this.courseId;
    data['level'] = this.level;
    data['name'] = this.name;

    data['children'] = this.children.map((item) => item.toJson()).toList();
    
    return data;
  }
}