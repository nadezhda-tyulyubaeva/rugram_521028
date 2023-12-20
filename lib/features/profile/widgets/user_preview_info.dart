import 'package:flutter/cupertino.dart';
import 'package:rugram_521028/features/profile/widgets/user_info_state.dart';


class ProfileShortInfo extends StatefulWidget {
  const ProfileShortInfo({
    super.key,
    required this.imageUrls,
    required this.nikname,
  });

  final List<String> imageUrls;
  final String nikname;

  @override
  ProfileShortInfoState createState() => ProfileShortInfoState();
}