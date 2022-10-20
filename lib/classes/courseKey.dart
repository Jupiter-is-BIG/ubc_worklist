import './course.dart';

class CourseKey {
  List<Course>? courseWithIDGroup;
  String? courseID;
  int courseCredits;
  // int? howMany = 1;

  CourseKey({
    required this.courseWithIDGroup,
    this.courseID,
    this.courseCredits = 3,
    // this.howMany,
  });
}
