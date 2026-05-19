import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widget/plane_details_app_bar.dart';
import '../widget/tab_views/overview_tab.dart';
import '../widget/tab_views/schedule_tab.dart';

class PlaneDetails extends StatefulWidget {
  final String name;
  final String image;
  final String details;
  final String guidelines;
  final String duration;
  final String difficulty;
  final List<String> chooseThisPlanIf;
  final List<String> whatYouWillDo;
  final Map<String, String> schedule;

  const PlaneDetails({
    Key? key,
    required this.name,
    required this.image,
    required this.details,
    required this.duration,
    required this.difficulty,
    required this.chooseThisPlanIf,
    required this.whatYouWillDo,
    required this.schedule,
    required this.guidelines,
  }) : super(key: key);

  @override
  State<PlaneDetails> createState() => _PlaneDetailsState();
}

class _PlaneDetailsState extends State<PlaneDetails>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final ScrollController _scrollController = ScrollController();
  bool _showAppBar = true;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_showAppBar) {
          setState(() {
            _showAppBar = false;
          });
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_showAppBar) {
          setState(() {
            _showAppBar = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(3, 11, 24, 1.0),
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              PlaneDetailsAppBar(
                image: widget.image,
                showAppBarTitle: _showAppBar,
              ),
            ];
          },
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TabBar(
                      controller: tabController,
                      tabs: const [
                        Tab(
                          child: Text(
                            "Overview",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Schedule",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    OverviewTab(
                      details: widget.details,
                      duration: widget.duration,
                      difficulty: widget.difficulty,
                      chooseThisPlanIf: widget.chooseThisPlanIf,
                      whatYouWillDo: widget.whatYouWillDo,
                      guidelines: widget.guidelines,
                    ),
                    ScheduleTab(
                      schedule: widget.schedule,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
