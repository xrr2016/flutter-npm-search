class Suggestion {
  final Map<String, dynamic> package;
  final Map<String, dynamic> score;
  final searchScore;
  final String highlight;

  Suggestion({
    this.package,
    this.score,
    this.searchScore,
    this.highlight,
  });

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      package: json['package'] as Map<String, dynamic>,
      score: json['score'] as Map<String, dynamic>,
      searchScore: json['searchScore'],
      highlight: json['highlight'] as String,
    );
  }
}
