import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rugram_521028/data_sources/profile/profile_data_source.dart';
import 'package:rugram_521028/domain/models/user_preview.dart';
import 'package:rugram_521028/features/home/bloc/posts_cubit.dart';
import 'package:rugram_521028/features/profile/widgets/user_preview_info.dart';
import 'package:provider/provider.dart';

class ProfileShortInfoState extends State<ProfileShortInfo> {
  late final ProfileDataSource profileDataSource;
  late UserPreview user;
  String Photo = "...";


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                child: ClipOval(
                    child: Image.network(
                      Photo,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ))),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      '666',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Посты',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  '1000000',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
                Text(
                  'Подписчики',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 26.0),
              child: Column(
                children: [
                  Text(
                    '0',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  Text(
                    'Подписки',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                widget.nikname,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                'Тот, кто не падал, не умеет подниматься!',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    profileDataSource = context.read<ProfileDataSource>();
    init();
  }

  Future<void> init() async {
    final usersInfo = await profileDataSource.getProfiles();
    user = usersInfo.data[8];
    Photo = user.picture;
    setState(() {});
  }


}