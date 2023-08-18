class UserModel{
  final String username;
  final String postname;
  final String description;
  final String posturl;
  final String uid;
  final String datepublished;
  final String profileURL;
  final likes;

  const UserModel({
    required this.username,
    required this.postname,
    required this.description,
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
  "Description":description,
  "User Id":uid,
  "Date Published":datepublished,
  "Post URL":posturl,
  "Likes":likes,

};

}

