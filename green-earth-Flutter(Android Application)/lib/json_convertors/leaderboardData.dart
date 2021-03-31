class leaderboardJson {
  final int score;
  final String name;
  final int avatarId;

  leaderboardJson(this.name,this.score,this.avatarId);

  leaderboardJson.fromJson(Map<String, dynamic> json)
      : score = json["score"],
        name = json["name"],
        avatarId=json["avatarId"];

}