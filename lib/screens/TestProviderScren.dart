import 'package:flutter/material.dart';
import 'package:ims_seller/routes.dart';
import 'package:ims_seller/view_models/add_new_product_view_model.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatelessWidget {
  TestScreen({Key? key}) : super(key: key);
  static final id = 'sd';

  var view = Provider.of<AddNewProductViewModel>(myContext!, listen: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => TestTwo("title")),
            );
          },
          child: Text(view.nextTitle.toString()),
        ),
      ),
    ));
  }
}

class TestTwo extends StatelessWidget {
  String title;

  TestTwo(this.title);
  var view = Provider.of<AddNewProductViewModel>(myContext!, listen: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: GestureDetector(
          onTap: () {
            view.nextTitle = DateTime.now().toString();
          },
          child: Text(view.nextTitle),
        ),
      ),
    ));
  }
}
