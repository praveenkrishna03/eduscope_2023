class PostModel{
  final String username;
  final String postname;
  final String posturl;
  final String uid;
  final datepublished;
  final String profileURL;
  final String type;
  final likes;

  const PostModel({
    required this.type,
    required this.username,
    required this.postname,
    required this.posturl,
    required this.uid,
    required this.datepublished,
    required this.profileURL,
    required this.likes,
  });
  Map<String , dynamic>toJson()=>{
  "Username": username,
  "Post Name": postname,
  "Profile URL":profileURL,
  "User Id":uid,
  "Date Published":datepublished,
  "Post URL":posturl,
  "Likes":likes,

};

}

