import 'package:flutter/material.dart';

import './course_display_entry.dart';
import '../classes/course.dart';

class IndividualWorklistDisplay extends StatelessWidget {
  List<Course> worklist;
  IndividualWorklistDisplay(this.worklist);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        //   Text('Course Name'),
        //   Text('Time'),
        //   Text('Available/Reg.'),
        // ]),
        ...worklist.map((cour) {
          return CourseDisplayEntry(cour);
        }).toList()
      ],
    );
  }
}
