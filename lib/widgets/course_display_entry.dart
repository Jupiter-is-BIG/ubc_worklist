import 'package:flutter/material.dart';

import '../classes/course.dart';

class CourseDisplayEntry extends StatelessWidget {
  Course oneCourse;
  CourseDisplayEntry(this.oneCourse);
  Widget build(BuildContext context) {
    // String a = oneCourse.courseDay as String;
    return Container(
        height: (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top) *
            0.10,
        child: LayoutBuilder(builder: (ctx, vali) {
          return Card(
            elevation: 2,
            color: oneCourse.courseStat![0] == '0' &&
                    oneCourse.courseStat![1] == '/'
                ? Colors.red[50]
                : Colors.indigo[50],
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                      padding: EdgeInsets.all(vali.maxHeight * 0.1),
                      child: Column(
                        children: [
                          Text(
                            oneCourse.courseName!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: vali.maxHeight * 0.05,
                          ),
                          Text(
                            oneCourse.courseAdditionalRequirements as String,
                            style: TextStyle(color: Colors.red[700]),
                          ),
                        ],
                      )),
                  Column(
                    children: [
                      SizedBox(height: vali.maxHeight * 0.08),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ...(oneCourse.courseDay!).map((val) {
                              return Text(
                                ' ${val}',
                                style: TextStyle(color: Colors.indigo[900]),
                              );
                            }).toList()
                          ]),
                      SizedBox(
                        height: vali.maxHeight * 0.05,
                      ),
                      // Text('${oneCourse.courseDay!} '),
                      Text(
                          '${oneCourse.courseTime![0]} - ${oneCourse.courseTime![1]}'),
                      SizedBox(
                        height: vali.maxHeight * 0.05,
                      ),
                      Text(
                        'Term ${oneCourse.courseTerm!}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(children: [
                    SizedBox(
                      height: vali.maxHeight * 0.08,
                    ),
                    Text(
                      'Available Seats',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'A/T/R',
                      style: TextStyle(fontSize: vali.maxHeight * 0.1),
                    ),
                    SizedBox(
                      height: vali.maxHeight * 0.1,
                    ),
                    Text(oneCourse.courseStat!)
                  ]),
                ]),
          );
        }));
  }
}
