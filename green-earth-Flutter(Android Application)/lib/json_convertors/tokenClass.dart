class TokenClass{
  final String token;
  final String name;
  final String email;
  final String score;
  final String avatarID;
  TokenClass(this.token,this.name, this.email, this.score, this.avatarID);

  TokenClass.fromJson(Map<String,dynamic> json)
  : token=json['token'],
  name="John Doe",
  email="johndoe@gmail.com",
  score="180",
  avatarID="3";
}