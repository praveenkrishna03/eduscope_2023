class PostModel{
  final String username;
  final String postname;
  final String posturl;
  final String uid;
  final datepublished;
  final String profileURL;
  final String type;
  final List likes;
  final bool isreported;
  final String subtag;
  final String classtag;
  final String chaptag;
  final String documentURL;
  


  const PostModel({
    required this.type,
    required this.username,
    required this.postname,
    required this.posturl,
    required this.uid,
    required this.datepublished,
    required this.profileURL,
    required this.likes,
    required this.isreported,
    required this.chaptag,
    required this.classtag,
    required this.documentURL,

    required this.subtag
  });
  Map<String , dynamic>toJson()=>{
  "Username": username,
  "Post Name": postname,
  "Profile URL":profileURL,
  "User Id":uid,
  "Date Published":datepublished,
  "Post URL":posturl,
  "Likes":likes,
  "Dislikes":false,
  "ClassTag":classtag,
  "ChapTag":chaptag,
  "SubTag":subtag,
  "Document URL":documentURL

};

}

