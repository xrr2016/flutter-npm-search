class Result {
  final Map package;
  final String publish;
  final String name;
  final String version;
  final String description;
  final double score;
  final double searchScore;

  Result({
    this.package,
    this.publish,
    this.name,
    this.version,
    this.description,
    this.score,
    this.searchScore,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    final date = json['package']['date'];
    DateTime _date = DateTime.parse(date);
    String _publish =
        '${_date.year} ${_date.month} ${_date.day} ${_date.hour}:${_date.minute}:${_date.second}';

    return Result(
      publish: _publish,
      package: json['package'] as Map,
      name: json['package']['name'] as String,
      version: json['package']['version'] as String,
      description: json['package']['description'] as String,
      score: json['score']['final'] as double,
      searchScore: json['searchScore'] as double,
    );
  }
}
