class MultiChatModel{
     
  final String? chat_id;
  final String? group_name;
  List<String>? recipients = [];

  MultiChatModel({this.chat_id,this.group_name,this.recipients});
}