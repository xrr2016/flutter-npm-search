class Result {
  final Map<String, dynamic> package;
  final Map<String, dynamic> score;
  final double searchScore;

  Result({this.package, this.score, this.searchScore});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      package: json['package'] as Map,
      score: json['score'] as Map,
      searchScore: json['searchScore'] as double,
    );
  }
}
