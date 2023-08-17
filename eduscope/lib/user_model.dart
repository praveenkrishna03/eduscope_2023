class UserModel{
  final String name;
  final String email;
  final String password;
  final String imageurl;
  final String uid;
  final List followers;
  final List following;
  final int posts;

  const UserModel({
    required this.email,
    required this.name,
    required this.password,
    required this.imageurl,
    required this.uid,
    required this.followers,
    required this.following,
    required this.posts,
  });
  Map<String , dynamic>toJson()=>{
  "Email": email,
  "Name": name,
  "Image URL":imageurl,
  "Password":password,
  "User Id":uid,
  "Followers":followers,
  "Following":following,
  "Posts":posts,

};

}

