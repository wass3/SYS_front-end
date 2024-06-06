class Follower {
  final int followerId;
  final int followedId;

  Follower({
    required this.followerId,
    required this.followedId,
  });

  factory Follower.fromJson(Map<String, dynamic> json) {
    return Follower(
      followerId: json['follower_id'] as int,
      followedId: json['followed_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'follower_id': followerId,
      'followed_id': followedId,
    };
  }
}
