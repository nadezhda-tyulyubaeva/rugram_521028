import 'package:flutter/material.dart';
import 'package:rugram_521028/domain/models/user_preview.dart';

class ProfilePage extends StatelessWidget {
  final UserPreview user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль пользователя'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.picture),
            ),
            const SizedBox(height: 20),
            Text(
              '${user.firstName} ${user.lastName}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Добавьте другие детали профиля здесь
          ],
        ),
      ),
    );
  }
}