import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagrem/models/user.dart';
import 'package:instagrem/models/user_data.dart';
import 'package:instagrem/screens/pages/profile_screen.dart';
import 'package:instagrem/services/database_service.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with AutomaticKeepAliveClientMixin<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  Future<QuerySnapshot> _users;

  @override
  bool get wantKeepAlive => true;

  _buildUserTile(User user) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20.0,
        backgroundImage: user.profileImageUrl.isEmpty
          ? AssetImage('assets/images/user_placeholder.png')
          : CachedNetworkImageProvider(user.profileImageUrl),
      ),
      title: Text(user.name),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProfileScreen(
            userId: user.id,
            currentUserId: Provider.of<UserData>(context).currentUserId,
          )
        ),
      ),
    );
  }

  _clearSearch() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _searchController.clear());
    setState(() {
      _users = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15.0),
            border: InputBorder.none,
            hintText: 'Search..',
            prefixIcon: Icon(
              Icons.search,
              size: 30.0,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
              ),
              onPressed: _clearSearch,
            ),
            filled: true,
          ),
          onSubmitted: (input) {
            print(input);
            if (input.isNotEmpty) {
              setState(() {
                _users = DatabaseService.searchUsers(input);
              });
            }
          },
        ),
      ),
      body: _users == null
        ? Center(child: Text('Search for a user'),
          )
        : FutureBuilder(
          future: _users,
          // initialData: InitialData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data.documents.length == 0) {
              return Center(
                child: Text('No users found! Please try again.'),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                User user = User.fromDoc(snapshot.data.documents[index]);
                return _buildUserTile(user);
              },
            );
          },
        ),
    );
  }
}