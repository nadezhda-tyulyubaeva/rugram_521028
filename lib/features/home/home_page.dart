import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/posts_cubit.dart';
import 'widgets/post_preview_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final ScrollController _scrollController;
  late final PostsCubit _postsCubit;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(listenScroll);
    _postsCubit = PostsCubit(context.read())..init();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<PostsCubit, PostsState>(
        bloc: _postsCubit,
        builder: (context, state) {
          if (state is PostsLoadedState) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.postsInfo.data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: PostPreviewCard(
                    postPreview: state.postsInfo.data[index],
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<void> listenScroll() async {
    final isPageEnd = _scrollController.offset + 150 > _scrollController.position.maxScrollExtent;
    if (isPageEnd) {
      await _postsCubit.nextPage();
    }
  }
}