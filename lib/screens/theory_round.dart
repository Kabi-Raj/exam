import 'package:exam/model/scopedModel.dart';
import 'package:exam/screens/practical_round.dart';
import 'package:exam/theory_tab_screens/round1.dart';
import 'package:exam/theory_tab_screens/round2.dart';
import 'package:exam/theory_tab_screens/round3.dart';
import 'package:flutter/material.dart';

class Theory extends StatefulWidget {
  final MainScopedModel model;
  Theory(this.model);

  @override
  _TheoryState createState() => _TheoryState(model);
}

class _TheoryState extends State<Theory> {
  final MainScopedModel round1Model = MainScopedModel();
  final MainScopedModel round2Model = MainScopedModel();
  final MainScopedModel round3Model = MainScopedModel();

  final MainScopedModel model;
  _TheoryState(this.model);

  @override
  void initState() {
    model.addStudent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: true,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Theory Round',
            ),
            bottom: TabBar(
              labelPadding: EdgeInsets.symmetric(vertical: 10.0),
              tabs: <Widget>[
                Text(
                  'Round 1',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  'Round 2',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  'Round 3',
                  style: TextStyle(fontSize: 18.0),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              /*  ScopedModel<MainScopedModel>(model: round1Model, child: Round1()),
              ScopedModel<MainScopedModel>(model: round2Model, child: Round2()),
              ScopedModel<MainScopedModel>(model: round3Model, child: Round3()) */

              Round1(),
              Round2(),
              Round3()
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Practical()));
            },
            child: Icon(Icons.videocam),
          ),
        ),
      ),
    );
  }
}
