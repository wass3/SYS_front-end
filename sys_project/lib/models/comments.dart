class Comment {
  final int commentId;
  final int planId;
  final String? text;
  final String? commentImg;
  final int userId;

  Comment({
    required this.commentId,
    required this.planId,
    this.text,
    this.commentImg,
    required this.userId,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: json['comment_id'] as int,
      planId: json['plan_id'] as int,
      text: json['text'] as String?,
      commentImg: json['comment_img'] as String?,
      userId: json['user_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comment_id': commentId,
      'plan_id': planId,
      'text': text,
      'comment_img': commentImg,
      'user_id': userId,
    };
  }
}
