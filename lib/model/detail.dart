class Detail {
  final String analyzedAt;
  final Map<String, dynamic> collected;
  final Map<String, dynamic> evaluation;
  final Map<String, dynamic> score;

  Detail({
    this.analyzedAt,
    this.collected,
    this.evaluation,
    this.score,
  });

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      analyzedAt: json['analyzedAt'],
      collected: json['collected'],
      evaluation: json['evaluation'],
      score: json['score'],
    );
  }
}
