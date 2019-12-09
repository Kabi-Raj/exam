import 'package:exam/model/scopedModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Round3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScopedModel>(
      builder: (context, Widget child, MainScopedModel model) {
        return ListView.builder(
          itemCount: model.thirdRoundStudents.length,
          itemBuilder: (context, int index) {
            return ListTile(
              title: Text(
                model.thirdRoundStudents[index].name,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            );
          },
        );
      },
    );
  }
}
