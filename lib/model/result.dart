class Result {
  final String name;
  final String description;
  final double score;
  final double searchScore;

  Result({this.name, this.description, this.score, this.searchScore});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      name: json['package']['name'] as String,
      description: json['package']['description'] as String,
      score: json['score']['final'] as double,
      searchScore: json['searchScore'] as double,
    );
  }
}
