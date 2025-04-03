import 'package:flutter/material.dart';

class TabBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text("Basic TabBar"),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40), // TabBar height
            child: Container(
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 0),
              child: TabBar(
                isScrollable:
                    true, // Enables scrolling if tabs exceed screen width
                indicator: BoxDecoration(
                  border: Border.all(
                      color: Colors.black,
                      width: 1), // Black border for selected tab
                  borderRadius: BorderRadius.circular(20),
                ),
                labelColor: Colors.black, // Selected tab text color
                unselectedLabelColor: Colors.black, // Unselected tab text color
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                tabs: [
                  BasicTab(title: "All"),
                  BasicTab(title: "IT"),
                  BasicTab(title: "Local Jobs"),
                  BasicTab(title: "Remote"),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text("All Content")),
            Center(child: Text("IT Content")),
            Center(child: Text("Local Jobs Content")),
            Center(child: Text("Remote Content")),
          ],
        ),
      ),
    );
  }
}

class BasicTab extends StatelessWidget {
  final String title;

  const BasicTab({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35, // Fixed height
      width: 40,
      padding:
          EdgeInsets.symmetric(horizontal: 9), // Padding for equal tab size
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.black, width: 1), // Black border for all tabs
        borderRadius: BorderRadius.circular(0),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(title),
      ),
    );
  }
}
