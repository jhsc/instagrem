import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagrem/models/post.dart';
import 'package:instagrem/models/user.dart';
import 'package:instagrem/utilities/constants.dart';

class DatabaseService {
  static void updateUser(User user) {
    usersRef.document(user.id).updateData({
      'name': user.name,
      'profileImageUrl': user.profileImageUrl,
      'bio': user.bio,
    });
  }

  static Future<QuerySnapshot> searchUsers(String name) {
    Future<QuerySnapshot> users = usersRef.where('name', isGreaterThanOrEqualTo: name).getDocuments();
    return users;
  }

  static void createPost(Post post) {
    postsRef.document(post.authorId).collection('usersPosts').add({
      'imageUrl': post.imageUrl,
      'caption': post.caption,
      'likes': post.likes,
      'authorId': post.authorId,
      'timestamp': post.timestamp,
    });
  }

  static void followUser({String currentUserId, String userId}) {
    // Add user to current users following collection.
    followingRef
      .document(currentUserId)
      .collection('userFollowing')
      .document(userId)
      .setData({});

      //Add current user to the user's followers collection.
    followersRef
      .document(userId)
      .collection('userFollowers')
      .document(currentUserId)
      .setData({});
  }

  static void unfollowUser({String currentUserId, String userId}) {
    // Remove user to current users following collection.
    followingRef
      .document(currentUserId)
      .collection('userFollowing')
      .document(userId)
      .get().then((doc) {
        if (doc.exists) {
          doc.reference.delete();
        }
      });

      // Remove current user to the user's followers collection.
    followersRef
      .document(userId)
      .collection('userFollowers')
      .document(currentUserId)
      .get().then((doc) {
        if (doc.exists) {
          doc.reference.delete();
        }
      });
  }

  static Future<bool> isFollowingUser({String currentUserId, String userId}) async {

  }


}