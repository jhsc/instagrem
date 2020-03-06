import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String imageUrl;
  final String caption;
  final dynamic likes;
  final String authorId;
  final Timestamp timestamp;

  Post({
    this.id,
    this.imageUrl,
    this.authorId,
    this.caption,
    this.likes,
    this.timestamp,
  });

  factory Post.fromDoc(DocumentSnapshot doc) {
    return Post(
      id: doc.documentID,
      imageUrl: doc['imageUrl'],
      authorId: doc['authorId'],
      caption: doc['caption'],
      likes: doc['likes'],
      timestamp: doc['timestamp'],
    );
  }

}