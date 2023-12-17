import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../domain/models/user_full.dart';

class UserProfilePage extends StatefulWidget {
  final String userId;

  UserProfilePage({required this.userId});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late Future<UserFull> _userProfile;

  @override
  void initState() {
    super.initState();
    _userProfile = fetchUserProfile();
  }

  Future<UserFull> fetchUserProfile() async {
    final response = await http.get(
      Uri.parse('https://your-api-url.com/users/${widget.userId}'), // Замените на URL вашего API
      headers: {'Authorization': 'Bearer YOUR_ACCESS_TOKEN'}, // Замените на ваш токен доступа, если он нужен для авторизации
    );

    if (response.statusCode == 200) {
      return UserFull.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: FutureBuilder<UserFull>(
        future: _userProfile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userProfile = snapshot.data!;

            return SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(userProfile.picture),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Name: ${userProfile.title} ${userProfile.firstName} ${userProfile.lastName}',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text('Email: ${userProfile.email}'),
                  SizedBox(height: 10.0),
                  Text('Gender: ${userProfile.gender}'),
                  SizedBox(height: 10.0),
                  Text('Date of Birth: ${userProfile.dateOfBirth}'),
                  SizedBox(height: 10.0),
                  Text('Phone: ${userProfile.phone}'),
                  SizedBox(height: 20.0),
                  Text(
                    'Location:',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text('Street: ${userProfile.location.street}'),
                  Text('City: ${userProfile.location.city}'),
                  Text('State: ${userProfile.location.state}'),
                  Text('Country: ${userProfile.location.country}'),
                  Text('Timezone: ${userProfile.location.timezone}'),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load user profile'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UserProfilePage(userId: 'user_id_here'), // Подставьте ID пользователя
  ));
}