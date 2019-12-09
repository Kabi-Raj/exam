import 'package:exam/model/scopedModel.dart';
import 'package:exam/screens/documents.dart';
import 'package:exam/screens/theory_round.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainScopedModel model = MainScopedModel();
    return ScopedModel<MainScopedModel>(
      model: model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (BuildContext context) => Theory(model),
          '/documents': (BuildContext context) => Documents(),
        },
      ),
    );
  }
}
