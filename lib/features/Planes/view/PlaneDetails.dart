import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';

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
    tabController = TabController(vsync: this, length: 2, initialIndex: 0);
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_showAppBar) {
          setState(() {
            _showAppBar = false;
          });
        }
      }
      if (_scrollController.position.userScrollDirection ==
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
              SliverAppBar(
                backgroundColor: const Color.fromRGBO(3, 11, 24, 1.0),
                title: _showAppBar
                    ? const Text(
                        "Plans Details",
                        style: TextStyle(color: Colors.white),
                      )
                    : null,
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                expandedHeight: 250.0,
                elevation: 0,
                pinned: true,
                floating: false,
                snap: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: 'planImage${widget.image}',
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover,
                      imageUrl: widget.image,
                    ),
                  ),
                ),
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
                    Column(
                      children: [
                        TabBar(
                          controller: tabController,
                          tabs: const [
                            Tab(
                              child: Text(
                                "OverView",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "SCHEDULE",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.details,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 16),
                            ),
                            const Gap(20),
                            Row(
                              children: [
                                const Text(
                                  'Duration :',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                const Spacer(),
                                Text(
                                  widget.duration,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                            const Gap(10),
                            const Row(
                              children: [
                                Text(
                                  'Time Per Week :',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Spacer(),
                                Text(
                                  'Daily',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                            const Gap(10),
                            Row(
                              children: [
                                const Text(
                                  'Difficulty :',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                const Spacer(),
                                Text(
                                  widget.difficulty,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Choose This Plan If',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.chooseThisPlanIf
                                  .map((item) =>
                                      '• $item') // Add a new line, dot, and space before each item
                                  .join(
                                      ' \n  \n'), // Join the items with two new lines
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'What You Will Do ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.whatYouWillDo.join('\n\n'),
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Guidelines',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.guidelines,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var entry in widget.schedule.entries)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${entry.key} :\n",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    Text(
                                      entry.value,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
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
