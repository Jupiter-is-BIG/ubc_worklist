import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worklist/widgets/worklist_creds.dart';

import './courseDataPlan/courseData.dart';
import './classes/courseKey.dart';
import './classes/course.dart';
import './widgets/display.dart';

void main() {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  bool enableBackToBack = false;

  List<List<String>> Displayer(List<List<Course>> well) {
    return well.map((val) {
      return val.map((hmm) {
        return hmm.courseName as String;
      }).toList();
    }).toList();
  }

  bool CourseClash(Course c1, Course c2) {
    int a = c1.courseTime![0];
    int b = c1.courseTime![1];
    int c = c2.courseTime![0];
    int d = c2.courseTime![1];

    if ((c1.courseTerm == c2.courseTerm) &&
        (Interestion(c1.courseDay, c2.courseDay)) &&
        (enableBackToBack == false
            ? ((a <= c && c <= b) || (c <= a && a <= d))
            : ((a <= c && c < b) || (c <= a && a < d)))) {
      return true;
    } else {
      return false;
    }
  }

  bool ClashInList(List<Course> subject, Course cour) {
    int i = 0;
    int k = subject.length;
    while (i < k) {
      if (CourseClash(subject[i], cour)) {
        return true;
      }
      i += 1;
    }
    return false;
  }

// intializer of the main list
  List<List<Course>> InitalizerWorklistMaker(List<Course> e1, List<Course> e2) {
    List<List<Course>> op = [];
    int i = 0;
    int k = e1.length;
    int m = e2.length;
    while (i < k) {
      List<Course> temp = [e1[i]];
      int j = 0;
      while (j < m) {
        if (CourseClash(e1[i], e2[j]) == false) {
          temp.add(e2[j]);
          op.add(temp);
          temp = [e1[i]];
        }
        j++;
      }
      i++;
    }
    return op;
  }

// advances the main list after 2nd step
  List<List<Course>> SecondaryBuilderWorklistMaker(
      List<List<Course>> i1, List<Course> i2) {
    int k = i1.length;
    int m = i2.length;
    int count = 0;
    List<List<Course>> ansList = [];

    while (count < k) {
      int j = 0;
      while (j < m) {
        List<Course> temp = [];

        if (ClashInList(i1[count], i2[j]) == false) {
          temp = [...i1[count]];
          // print('=====HAKUNA MATATA=====');
          // print(Displayer([temp]));
          // print('>>>>>>>>>>>>');
          temp.add(i2[j]);
          ansList.add(temp);
        }
        j++;
      }

      count++;
    }
    return ansList;
  }

  List<List<Course>> TheMainBuilder(List<CourseKey> w) {
    List<List<Course>> finalResult = [];
    int i = 2;
    int ok = 0;
    int k = w.length;
    List<List<Course>> finRes = [];
    finalResult = InitalizerWorklistMaker(
        w[0].courseWithIDGroup!, w[1].courseWithIDGroup!);
    // print(Displayer(finalResult));
    while (i < k) {
      finalResult =
          SecondaryBuilderWorklistMaker(finalResult, w[i].courseWithIDGroup!);
      // print(Displayer(finalResult));
      i++;
    }
    int ww = finalResult.length;
    // print(finalResult);
    while (ok < ww) {
      // print(finalResult[ok].length);

      if (finalResult[ok].length == k) {
        finRes.add(finalResult[ok]);
      }
      ok++;
    }
    // print(Displayer(finRes));
    return finRes;
  }

  // print(Displayer(TheMainBuilder(courseData)));
  // print('ok');
  // Display Executer () {

  // }
  // final List<List<Course>> hakunaMatata = TheMainBuilder(courseData);
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  int index = 0;
  void indexIncrementer() {
    // print();
    setState(() {
      index++;
    });
  }

  void indexDecrementer() {
    // print();
    setState(() {
      index--;
    });
  }

  Widget build(BuildContext context) {
    // double check =
    Row rowwing = Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FloatingActionButton(
              backgroundColor: Colors.indigo,
              onPressed: index > 0 ? indexDecrementer : null,
              child: Text(
                '< Back',
                style: TextStyle(fontSize: 10),
              )),
          Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.indigo, width: 1.5)),
              child: FittedBox(
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Center(
                          child: Text(
                        '${index + 1} / ${widget.TheMainBuilder(courseData).length}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))))),
          FloatingActionButton(
            backgroundColor: Colors.indigo,
            child: Text(
              'Next >',
              style: TextStyle(fontSize: 10),
            ),
            onPressed: index < widget.TheMainBuilder(courseData).length - 1
                ? indexIncrementer
                : null,
          )
        ]);

    AppBar appBar = AppBar(
      actions: [
        Row(children: [
          widget.enableBackToBack == false
              ? Text(
                  'Back2back disabled',
                  style: TextStyle(fontSize: 10),
                )
              : Text('Back2back enabled', style: TextStyle(fontSize: 10)),
          Switch(
              value: widget.enableBackToBack,
              onChanged: (val) {
                setState(() {
                  widget.enableBackToBack = val;
                });
              })
        ])
      ],
      title: Text('Worklist'),
      backgroundColor: Colors.indigo[900],
    );
    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
            child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              widget.TheMainBuilder(courseData).length != 0
                  ? Container(
                      child: Column(children: [
                      WorklistCreds(
                        workCreds: courseData,
                        redPointer: widget.TheMainBuilder(courseData)[index],
                        indi: index,
                        appBARsize: appBar.preferredSize.height,
                      ),
                      SizedBox(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.02,
                      ),
                      Container(
                          height: (MediaQuery.of(context).size.height -
                                  appBar.preferredSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.7,
                          child: SingleChildScrollView(
                              child: Display(
                                  widget.TheMainBuilder(courseData), index))),
                      SizedBox(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.025,
                      ),
                      rowwing
                    ]))
                  : Center(
                      child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          SizedBox(
                            height: (MediaQuery.of(context).size.height -
                                    appBar.preferredSize.height -
                                    MediaQuery.of(context).padding.top) *
                                0.25,
                          ),
                          Text(
                            'No possible worklist found!',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          Image.asset('assets/images/not_found.png')
                        ])),
            ])));
  }
}
