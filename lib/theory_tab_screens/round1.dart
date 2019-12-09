import 'package:exam/model/scopedModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Round1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScopedModel>(
      builder: (BuildContext context, Widget child, MainScopedModel model) {
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          itemCount: model.firstRoundStudent.length,
          itemBuilder: (context, int index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  model.firstRoundStudent[index].name,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                FlatButton(
                    child: Text(
                        '${model.firstRoundStudent[index].isAdded ? 'Remove' : 'Add'}'),
                    onPressed: () {
                      //model.selectStudent(students[index]);
                      model.addStudentsToSecRound(
                          model.firstRoundStudent[index]);
                    })
              ],
            );
          },
        );
      },
    );
  }
}
