import 'dart:io'; // for File
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tabzsnappro/models/user_data_models/blocked_data_model.dart';
import 'package:tabzsnappro/models/chat_model.dart';
import 'package:tabzsnappro/models/messages_model.dart';
import 'package:tabzsnappro/models/user_data_models/other_user_data_model.dart';
import 'package:tabzsnappro/models/post_model.dart';
import 'package:tabzsnappro/models/user_data_models/user_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/follower_data_model.dart';
import 'package:tabzsnappro/models/user_data_models/following_data_model.dart';

class DatabaseService {
  
  final String? uid;
  final String? otherId;
  final String? chatId;
  final String? otherUserProfileId;
  final String? usernameToSearch;
  final List<dynamic>? followersList;
  final List<dynamic>? followingsList;
  final List<dynamic>? blockedList;

  DatabaseService(
      {this.uid,
      this.otherId,
      this.chatId,
      this.otherUserProfileId,
      this.usernameToSearch,
      this.followersList,
      this.followingsList,
      this.blockedList});

  //collection reference (users)
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection("users");

  //collection reference (chats)
  final CollectionReference _chatCollection =
      FirebaseFirestore.instance.collection("chats");

  //collection reference (posts)
  final CollectionReference _postCollection =
      FirebaseFirestore.instance.collection("posts");

  //firebase storage profile pic reference
  Reference _firebaseStorageProfilePic =
      FirebaseStorage.instance.ref().child("profile pictures");

  //firebase storage posts reference
  Reference _firebaseStoragePostsImages =
      FirebaseStorage.instance.ref().child("posts images");

  //for creating user data
  Future createUserData(String name, String email) async {
    return await _userCollection.doc(uid).set({
      'uid': uid!,
      'name': name,
      'email': email,
      'followers': [],
      'followings': [],
      'blocked': [],
      'blocked_by': [],
      'profilePicUri': "",
      'hasProfilePic': false
    });
  }

  //user data from snapshot
  UserDataModel _userDataFromSnapshot(DocumentSnapshot snapshot) {

    return UserDataModel(
        uid: snapshot['uid'] ?? uid,
        name: snapshot['name'] ?? '',
        email: snapshot['email'] ?? '',
        followers: (snapshot['followers'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        followings: (snapshot['followings'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        blocked: (snapshot['blocked'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        blocked_by: (snapshot['blocked_by'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        profilePicUri: snapshot['profilePicUri'] ?? '',
        hasProfilePic: snapshot['hasProfilePic'] ?? false);
  }

  //other user data from snapshot
  OtherUserDataModel _otherUserDataFromSnapshot(DocumentSnapshot snapshot) {
    
    return OtherUserDataModel(
        uid: snapshot['uid'] ?? otherUserProfileId,
        name: snapshot['name'] ?? '',
        email: snapshot['email'] ?? '',
        followers: (snapshot['followers'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        followings: (snapshot['followings'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        blocked: (snapshot['blocked'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        blocked_by: (snapshot['blocked_by'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        profilePicUri: snapshot['profilePicUri'] ?? '',
        hasProfilePic: snapshot['hasProfilePic'] ?? false);
  }

  //user list from snapshot

  List<UserDataModel> _userListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return UserDataModel(
            uid: doc.get("uid") ?? '',
            name: doc.get("name") ?? '',
            email: doc.get("email") ?? '',
            followers: (doc.get('followers') as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
            followings: (doc.get('followings') as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
            blocked: (doc.get('blocked') as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
            blocked_by: (doc.get('blocked_by') as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
            profilePicUri: doc.get("profilePicUri") ?? '',
            hasProfilePic: doc.get("hasProfilePic") ?? false);
      }).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  //follower list from snapshot

  List<FollowerDataModel> _followerListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return FollowerDataModel(
            uid: doc.get("uid") ?? '',
            name: doc.get("name") ?? '',
            email: doc.get("email") ?? '',
            followers: (doc.get('followers') as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
            followings: (doc.get('followings') as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
            blocked: (doc.get('blocked') as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
            blocked_by: (doc.get('blocked_by') as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
            profilePicUri: doc.get("profilePicUri") ?? '',
            hasProfilePic: doc.get("hasProfilePic") ?? false);
      }).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  //following list from snapshot

  List<FollowingDataModel> _followingListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return FollowingDataModel(
            uid: doc.get("uid") ?? '',
            name: doc.get("name") ?? '',
            email: doc.get("email") ?? '',
            followers: (doc.get('followers') as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
            followings: (doc.get('followings') as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
            blocked: (doc.get('blocked') as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
            blocked_by: (doc.get('blocked_by') as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
            profilePicUri: doc.get("profilePicUri") ?? '',
            hasProfilePic: doc.get("hasProfilePic") ?? false);
      }).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  //blocked list from snapshot
  List<BlockedDataModel> _blockedListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return BlockedDataModel(
            uid: doc.get("uid") ?? '',
            name: doc.get("name") ?? '',
            email: doc.get("email") ?? '',
            followers: (doc.get('followers') as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
            followings: (doc.get('followings') as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
            blocked: (doc.get('blocked') as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
            blocked_by: (doc.get('blocked_by') as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
            profilePicUri: doc.get("profilePicUri") ?? '',
            hasProfilePic: doc.get("hasProfilePic") ?? false);
      }).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  //post list from snapshot

  List<PostModel> _postListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return PostModel(
            postText: doc.get("postText") ?? '',
            postImageUri: doc.get("postImageUri") ?? '',
            postVideoUri: doc.get("postVideoUri") ?? '',
            owner: doc.get("owner") ?? '',
            blockedBy: (doc.get('blockedBy') as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
            postId: doc.id ?? '');
      }).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  //message from snapshot

  List<MessageModel> _messageListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return MessageModel(
          text: doc.get("text") ?? '',
          sender: doc.get("sender") ?? '',
          timeStampMicro: doc.get("timeStampMicro") ?? '',
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  //chat from snapshot

  List<ChatModel> _chatListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return ChatModel(
            chat_id: doc.get("chat_id") ?? '',
            recipients: (doc.get('recipients') as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            []);
      }).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  //create new chat
  Future<bool?> add_chat() async {
    await _chatCollection.doc(chatId).set({
      'recipients': [uid, otherId],
      'chat_id': chatId
    });

    return true;
  }

  //for adding new message
  Future addMessage(String text, int timeStampMicro) async {
    await _chatCollection
        .doc(chatId)
        .collection("messages")
        .add({'text': text, 'sender': uid, 'timeStampMicro': timeStampMicro});
  }

  //for finding username of provided id
  Future<String?> getUserName(String otherPersonId) async {
    dynamic result = await _userCollection.doc(otherPersonId).get();

    return result["name"];
  }

  //for following a user
  Future follow(String userId, String userToFollowId) async {
    var newFollowerToAdd = [userId];
    await _userCollection
        .doc(userToFollowId)
        .update({'followers': FieldValue.arrayUnion(newFollowerToAdd)});

    var newFollowingToAdd = [userToFollowId];
    await _userCollection
        .doc(userId)
        .update({'followings': FieldValue.arrayUnion(newFollowingToAdd)});
  }

  //for unfollowing a user
  Future unfollow(String userId, String userToFollowId) async {
    var followerToRemove = [userId];
    await _userCollection
        .doc(userToFollowId)
        .update({'followers': FieldValue.arrayRemove(followerToRemove)});

    var followingToRemove = [userToFollowId];
    await _userCollection
        .doc(userId)
        .update({'followings': FieldValue.arrayRemove(followingToRemove)});
  }

  //for blocking a user
  Future addBlock(String userId, String userToBlockId) async {
    try {
      var followerToRemove = [userId];

      await _userCollection
          .doc(userToBlockId)
          .update({'followers': FieldValue.arrayRemove(followerToRemove)});
    } catch (e) {}

    try {
      var followerToRemove = [userToBlockId];

      await _userCollection
          .doc(userId)
          .update({'followers': FieldValue.arrayRemove(followerToRemove)});
    } catch (e) {}

    try {
      var followingToRemove = [userToBlockId];

      await _userCollection
          .doc(userId)
          .update({'followings': FieldValue.arrayRemove(followingToRemove)});
    } catch (e) {}

    try {
      var followingToRemove = [userId];

      await _userCollection
          .doc(userToBlockId)
          .update({'followings': FieldValue.arrayRemove(followingToRemove)});
    } catch (e) {
      print(e);
    }

    var userToBlock = [userToBlockId];

    await _userCollection
        .doc(userId)
        .update({'blocked': FieldValue.arrayUnion(userToBlock)});

    var userBlockedBy = [userId];

    await _userCollection
        .doc(userToBlockId)
        .update({'blocked_by': FieldValue.arrayUnion(userBlockedBy)});
  }

  //for unblocking a user
  Future unBlock(String userId, String userToUnBlockId) async {
    var userToUnBlock = [userToUnBlockId];

    await _userCollection
        .doc(userId)
        .update({'blocked': FieldValue.arrayRemove(userToUnBlock)});

    var userBlockedBy = [userId];

    await _userCollection
        .doc(userToUnBlockId)
        .update({'blocked_by': FieldValue.arrayRemove(userBlockedBy)});
  }

  //for blocking a post
  Future addPostBlock(String postId, String userId) async {
    var newBlockToAdd = [userId];

    await _postCollection
        .doc(postId)
        .update({'blockedBy': FieldValue.arrayUnion(newBlockToAdd)});
  }

  //stream for getting user details
  Stream<UserDataModel?> get userDetails {
    return _userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  //stream for getting user details
  Stream<OtherUserDataModel?> get otherUserDetails {
    return _userCollection
        .doc(otherUserProfileId)
        .snapshots()
        .map(_otherUserDataFromSnapshot);
  }

  //stream for getting users
  Stream<List<UserDataModel>> get getUsers {
    if (usernameToSearch != null && usernameToSearch!.isEmpty) {
      return _userCollection
          .where('uid', whereNotIn: blockedList)
          .snapshots()
          .map(_userListFromSnapshot);
    } else {
      return _userCollection
          .where('uid', whereNotIn: blockedList)
          .where('name', isEqualTo: usernameToSearch)
          .snapshots()
          .map(_userListFromSnapshot);
    }
  }

  //stream for getting followers of a user
  Stream<List<FollowerDataModel>> get otherUserFollowers {
    return _userCollection
        .where('uid', whereIn: followersList)
        .snapshots()
        .map(_followerListFromSnapshot);
  }

  //stream for getting followings of a user
  Stream<List<FollowingDataModel>> get otherUserFollowings {
    return _userCollection
        .where('uid', whereIn: followingsList)
        .snapshots()
        .map(_followingListFromSnapshot);
  }

  //stream for getting blocked users of a user
  Stream<List<BlockedDataModel>> get myBlocked {
    return _userCollection
        .where('uid', whereIn: blockedList)
        .snapshots()
        .map(_blockedListFromSnapshot);
  }

  //stream for getting messages in a single chat
  Stream<List<MessageModel>> get getMessages {
    return _chatCollection
        .doc(chatId)
        .collection("messages")
        .orderBy("timeStampMicro")
        .snapshots()
        .map(_messageListFromSnapshot);
  }

  //stream for getting all the chats of current user
  Stream<List<ChatModel>> get getMyChats {
    return _chatCollection
        .where('recipients', arrayContainsAny: [uid])
        .snapshots()
        .map(_chatListFromSnapshot);
  }

  //stream for getting posts of a user
  Stream<List<PostModel>> get otherUserPosts {
    return _postCollection
        .where('owner', isEqualTo: otherUserProfileId)
        .snapshots()
        .map(_postListFromSnapshot);
  }

  //stream for getting feed of a user
  Stream<List<PostModel>> get myFeed {
    return _postCollection
        .where('owner', whereIn: followingsList)
        .snapshots()
        .map(_postListFromSnapshot);
  }

  //for uploading profile picture

  Future uploadProfilePic(String uid, File imageFile) async {
    Reference _userProfilePic = _firebaseStorageProfilePic.child(uid);
    UploadTask uploadTask = _userProfilePic.putFile(imageFile);

    TaskSnapshot _taskSnapshot = await uploadTask.whenComplete(() {
      Future<String> _url = _userProfilePic.getDownloadURL();
    }).catchError((onError) {
      print(onError);
    });

    dynamic _profilePicUri = await _taskSnapshot.ref.getDownloadURL();

    await _userCollection.doc(uid).update({'hasProfilePic': true});

    await _userCollection.doc(uid).update({'profilePicUri': _profilePicUri});
  }

  //for creating new post
  Future createNewPost(String uid, String text, File? imageFile) async {
    String _postImageUri = "";
    String _postVideoUri = "";

    if (imageFile != null) {
      Reference _userPostImage =
          _firebaseStoragePostsImages.child(uid + imageFile.toString());
      UploadTask _uploadTask = _userPostImage.putFile(imageFile);

      TaskSnapshot _taskSnapshot = await _uploadTask.whenComplete(() {
        //Future<String> url = .getDownloadURL();
      }).catchError((onError) {
        print(onError);
      });

      _postImageUri = await _taskSnapshot.ref.getDownloadURL();
    }

    await _postCollection.add({
      'postText': text,
      'postImageUri': _postImageUri,
      'postVideoUri': _postVideoUri,
      'owner': uid,
      'blockedBy': []
    });
  }
}
