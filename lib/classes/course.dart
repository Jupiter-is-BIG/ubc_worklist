class Course {
  String? courseName;
  List<String>? courseDay;
  List<int>? courseTime;
  String? courseStat;
  int? courseTerm;
  String? courseAdditionalRequirements;
  // String? courseID;
  // int? courseCredits = 3;

  Course({
    required this.courseName,
    required this.courseDay,
    required this.courseTime,
    required this.courseStat,
    required this.courseTerm,
    required this.courseAdditionalRequirements,
    // this.courseID,
    // this.courseCredits
  });
}
