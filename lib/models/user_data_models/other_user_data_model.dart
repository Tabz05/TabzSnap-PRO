class OtherUserDataModel{
    
    final String? uid;
    final String? name;
    final String? email;

    List<String>? followers = [];
    List<String>? followings = [];
    List<String>? blocked=[];
    List<String>? blocked_by=[];

    String? profilePicUri;
    bool? hasProfilePic;

    OtherUserDataModel({this.uid,this.name,this.email,this.followers,this.followings,this.blocked,this.blocked_by,this.profilePicUri,this.hasProfilePic});

}