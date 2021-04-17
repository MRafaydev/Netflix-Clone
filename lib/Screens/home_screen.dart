import 'package:flutter/material.dart';
import 'package:portfolio/cubits/cubits.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/widgets/content_header.dart';
import 'package:portfolio/widgets/content_list.dart';
import 'package:portfolio/widgets/custom_app_bar.dart';
import 'package:portfolio/widgets/previews.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        context.read<AppBarCubit>().setOffset(_scrollController.offset);
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[850],
        child: const Icon(Icons.cast),
        onPressed: () => print("cast"),
      ),
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50.0),
        child: BlocBuilder<AppBarCubit, double>(
          builder: (context, scrollOffset) {
            return CustomAppBar(
              scrollOffset: scrollOffset,
            );
          },
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ContentHeader(
              featuredContent: sintelContent,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: Previews(
                key: PageStorageKey('previews'),
                title: 'Previews',
                contentList: previews,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
                key: PageStorageKey('myList'),
                title: 'Mylist',
                contentList: myList),
          ),
          SliverToBoxAdapter(
            child: ContentList(
                key: PageStorageKey('originals'),
                title: 'Netflix Orignals',
                contentList: myList),
          ),
          SliverToBoxAdapter(
            child: ContentList(
                key: PageStorageKey('trending'),
                title: 'Trending',
                contentList: myList),
          )
        ],
      ),
    );
  }
}
