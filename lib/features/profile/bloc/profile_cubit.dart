import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rugram_521028/domain/models/list_model.dart';
import 'package:rugram_521028/domain/models/post_preview.dart';

import '../../../data_sources/post/post_data_source.dart';

// 1. Создать класс, который будет содержать состояния о постах пользователя.
abstract class ProfileState {}

// 2. Класс, когда блок только создан.
class ProfileInitialState extends ProfileState {}

// 3. Состояние загрузки постов пользователя.
class ProfileLoadingState extends ProfileState {}

// 4. Класс, когда посты успешно загружены.
class ProfileLoadedState extends ProfileState {
  final ListModel<PostPreview> userPosts;

  ProfileLoadedState({required this.userPosts});
}

// 5. Класс-блок, который работает с классом, в котором содержатся различные состояния.
class ProfileCubit extends Cubit<ProfileState> {


  final PostDataSource postDataSource;


  ProfileCubit(this.postDataSource) : super(ProfileInitialState());

  Future<void> init({required String userId}) async {
    emit(ProfileLoadingState());
    final postsInfo = await postDataSource.getPostsByUserId(id: userId);
    emit(ProfileLoadedState(userPosts: postsInfo));
  }

}