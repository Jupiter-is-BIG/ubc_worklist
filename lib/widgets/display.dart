import 'package:flutter/material.dart';

import '../classes/course.dart';
import './individual_worklist_display.dart';

class Display extends StatelessWidget {
  List<List<Course>> mainSet;
  int index;

  Display(this.mainSet, this.index);
  Widget build(BuildContext context) {
    return IndividualWorklistDisplay(mainSet[index]);
  }
}
