import 'package:flutter/material.dart';

import '../classes/courseKey.dart';
import '../classes/course.dart';

class WorklistCreds extends StatelessWidget {
  List<CourseKey> workCreds;
  List<Course> redPointer;
  int indi;
  double appBARsize;

  WorklistCreds(
      {required this.workCreds,
      required this.redPointer,
      required this.indi,
      required this.appBARsize});
  @override
  Widget build(BuildContext context) {
    List<int> numberOfCourseTakenEachTerm() {
      var term1 = 0;
      var term2 = 0;
      var i = 0;
      while (i < redPointer.length) {
        if (redPointer[i].courseTerm == 1) {
          term1++;
        } else if (redPointer[i].courseTerm == 2) {
          term2++;
        }
        i++;
      }
      return [term1, term2];
    }

    int CreditCounter() {
      int credits = 0;
      int numCourse = workCreds.length;
      int i = 0;
      while (i < numCourse) {
        credits += workCreds[i].courseCredits as int;
        i++;
      }
      return credits;
    }

    int RedCourses() {
      int i = 0;
      int numLectures = redPointer.length;
      int redCourse = 0;
      while (i < numLectures) {
        if (redPointer[i].courseStat![0] == '0' &&
            redPointer[i].courseStat![1] == '/') {
          redCourse++;
        }
        i++;
      }
      return redCourse;
    }

    return Padding(
        padding: EdgeInsets.all((MediaQuery.of(context).size.height -
                appBARsize -
                MediaQuery.of(context).padding.top) *
            0.01),
        child: Container(
            decoration: BoxDecoration(
                color: RedCourses() == 0 ? Colors.green[100] : Colors.red[100]),
            height: (MediaQuery.of(context).size.height -
                    appBARsize -
                    MediaQuery.of(context).padding.top) *
                0.12,
            child: LayoutBuilder(builder: (ctx, val) {
              return Container(
                  height: val.maxHeight,
                  width: val.maxWidth,
                  padding: EdgeInsets.all(val.maxHeight * 0.05),
                  child: Row(
                    children: [
                      SizedBox(
                        width: val.maxWidth * 0.1,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: val.maxHeight * 0.1),
                          child: Column(children: [
                            Text(
                              'Worklist ${indi + 1}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: val.maxHeight * 0.3,
                                  color: Colors.indigo),
                            ),
                            SizedBox(
                              height: val.maxHeight * 0.02,
                            ),
                            Text(
                              'Total courses: ${redPointer.length as int}',
                              style: TextStyle(
                                  color: Colors.cyan[900],
                                  fontSize: val.maxHeight * 0.16),
                            ),
                            Text(
                              'Term 1: ${numberOfCourseTakenEachTerm()[0] as int} Term 2: ${numberOfCourseTakenEachTerm()[1] as int}',
                              style: TextStyle(
                                  color: Colors.cyan[900],
                                  fontSize: val.maxHeight * 0.1),
                            )
                          ])),
                      SizedBox(
                        width: val.maxWidth * 0.2,
                      ),
                      Column(
                        children: [
                          SizedBox(height: val.maxHeight * 0.1),
                          Container(
                              padding: EdgeInsets.all(val.maxWidth * 0.02),
                              height: val.maxHeight * 0.4,
                              // width: 40,
                              child: FittedBox(
                                  child: Center(
                                      child: Text(
                                'Total Credits: ${CreditCounter() as int}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ))),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 2),
                                  borderRadius: BorderRadius.circular(10))),
                          SizedBox(height: val.maxHeight * 0.1),
                          Text(
                            'Lectures filled: ${RedCourses() as int}',
                            style: TextStyle(color: Colors.cyan[900]),
                          )
                        ],
                      )
                    ],
                  ));
            })));
  }
}
