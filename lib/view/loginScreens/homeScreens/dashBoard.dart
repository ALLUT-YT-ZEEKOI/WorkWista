import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    _pageController.jumpToPage(index);
    _tabController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Image(
          image: AssetImage('assets/Frame 26080486.png'),
          width: 50,
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10), // Add spacing
                child: const Image(
                  image: AssetImage('assets/bell.png'),
                  width: 30,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: const Image(
                  image: AssetImage('assets/ant-design_message-outlined.png'),
                  width: 30,
                ),
              ),
            ],
          ),
        ],
        backgroundColor: Colors.transparent, // Make AppBar transparent
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.50, -0.00),
              end: Alignment(0.50, 1.89),
              colors: [Color(0xFFDAE6FC), Colors.white],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          TabBar(
            tabAlignment: TabAlignment.start,
            controller: _tabController,
            isScrollable: true,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.blue,
                width: 2,
              ),
            ),
            splashFactory: NoSplash.splashFactory,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            tabs: const [
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text("All"),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text("IT"),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text("Local Jobs"),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text("Remote Jobs"),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text("New Jobs"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                _tabController.animateTo(index);
              },
              children: const [
                JobCategoryScreen1(),
                JobCategoryScreen2(),
                JobCategoryScreen3(),
                JobCategoryScreen4(),
                JobCategoryScreen5(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class JobCategoryScreen1 extends StatelessWidget {
  const JobCategoryScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "All Jobs",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class JobCategoryScreen2 extends StatelessWidget {
  const JobCategoryScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "IT Jobs",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class JobCategoryScreen3 extends StatelessWidget {
  const JobCategoryScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Local Jobs",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class JobCategoryScreen4 extends StatelessWidget {
  const JobCategoryScreen4({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Remote Jobs",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class JobCategoryScreen5 extends StatelessWidget {
  const JobCategoryScreen5({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "New Jobs",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
