class MultiMessageModel{
    
    final String? text;
    final String? sender;
    final String? senderUsername;
    final bool? senderHasProfilePic;
    final String? senderProfilePicUri; 
    final int? timeStampMicro;

    MultiMessageModel({this.text,this.sender,this.senderUsername,this.senderHasProfilePic,this.senderProfilePicUri,this.timeStampMicro});

}