import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rugram_521028/features/profile/bloc/profile_cubit.dart';
import 'package:rugram_521028/data_sources/profile/profile_data_source.dart';
import 'package:rugram_521028/features/home/bloc/posts_cubit.dart';
import 'package:rugram_521028/features/profile/widgets/user_preview_info.dart';
import '../../domain/models/user_preview.dart';

class ProfilePage extends StatefulWidget {

  ProfilePage({Key? key,}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late final ProfileDataSource profileDataSource;
  late TabController tabController;
  late final PostsCubit _postsCubit;
  TextEditingController nameController = TextEditingController();
  String nikname = "...";
  late UserPreview user;
  List<String> imageUrls = [];


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Text(
            nikname,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.add_box_outlined,
                    size: 30,
                  ),
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.add_box_outlined,
                  //     size: 30,
                  //   ),
                  //   onPressed: addImage,
                  // ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.table_rows_rounded,
                    size: 30,
                  ),
                ),
              ],
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              sliver: SliverToBoxAdapter(
                child: ProfileShortInfo(
                  imageUrls: imageUrls,
                  nikname: nikname,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Row(
                    children: [
                        ElevatedButton(
                          onPressed: () => _editProfile(),
                            // Действие при нажатии кнопки редактирования профиля// Вызов метода для добавления фотографии

                          child: Text('Редактировать имя пользователя'),

                        ),
                        ],
                      ),
                    ],
                  ),
                ),
            SliverToBoxAdapter(
              child: TabBar(
                controller: tabController,
                tabs: const [
                  Tab(icon: Icon(Icons.video_collection_outlined)),
                  Tab(icon: Icon(Icons.person_add_alt_outlined)),
                ],
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: tabController,
                children: [
                  BlocBuilder<PostsCubit, PostsState>(
                      bloc: _postsCubit,
                      builder: (context, state) {
                        return switch (state) {
                          PostsLoadedState() => GridView.builder(
                              shrinkWrap: true,
                              itemCount: state.postsInfo.data.length,
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 3,
                                mainAxisSpacing: 3,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                return Image.network(
                                  state.postsInfo.data[index].image,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                );
                              }),
                          _ => const Center(child: CircularProgressIndicator()),
                        };
                      }),
                  // GridView.count(
                  //   scrollDirection: Axis.vertical,
                  //   shrinkWrap: true,
                  //   primary: false,
                  //   padding: const EdgeInsets.all(4),
                  //   crossAxisSpacing: 2,
                  //   mainAxisSpacing: 2,
                  //   crossAxisCount: 3,
                  //   children: imageUrls.map((imageUrl) {
                  //     return buildImageContainer(imageUrl);
                  //   }).toList(),
                  // ),
                  Center(
                    child: Column(
                      children: const [
                        SizedBox(
                          height: 50,
                        ),
                        Icon(
                          Icons.person_add,
                          color: Colors.black,
                          size: 60,
                        ),
                        Text(
                          "Фотографии и видео с Вами",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    _postsCubit = PostsCubit(context.read())..initWithTag(tag: "person");
    profileDataSource = context.read<ProfileDataSource>();
    init();
    // loadImages();
  }

  Future<void> init() async {
    final usersInfo = await profileDataSource.getProfiles();
    user = usersInfo.data[8];
    nikname = user.firstName;
    setState(() {});
  }
  Future<void> update({required String name}) async {
    final updatedUser = await profileDataSource.updateProfile(profileId: user.id, name: name);
    nikname = updatedUser.firstName;
    setState(() {});
  }

  void _editProfile() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Редактирование профиля'),
          content: TextFormField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Новое имя'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: ()
              {
                update(name: nameController.text);
                Navigator.pop(context);
              },
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  void showFullScreenImage(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image.network(
              imageUrl,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

}