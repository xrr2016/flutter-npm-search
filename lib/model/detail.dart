class Detail {
  final String analyzedAt;
  final Map<String, dynamic> collected;
  final Map<String, dynamic> evaluation;
  final Map<String, dynamic> score;

  Detail({this.analyzedAt, this.collected, this.evaluation, this.score});

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      analyzedAt: json['analyzedAt'] as String,
      collected: json['collected'] as Map,
      evaluation: json['evaluation'] as Map,
      score: json['score'] as Map,
    );
  }
}
