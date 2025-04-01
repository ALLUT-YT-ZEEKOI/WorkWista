import 'package:flutter/material.dart';
import 'package:workwista/view/Wdigets/search_field.dart';
import 'package:workwista/view/responsive_helper.dart';

class AddJobScreen extends StatefulWidget {
  const AddJobScreen({super.key});

  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Job",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            Center(
              child: SizedBox(
                  width: ResponsiveHelper.width(365, context),
                  child: searchField(height: 50)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(25, context),
                vertical: 35,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  20,
                  (index) {
                    return Container(
                        margin: EdgeInsets.only(
                            bottom: ResponsiveHelper.height(
                                20, context)), // Vertical gap
                        padding: EdgeInsets.all(ResponsiveHelper.width(
                            12, context)), // Inner padding
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: []),
                        child: Text(
                          "Grass cutting",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
