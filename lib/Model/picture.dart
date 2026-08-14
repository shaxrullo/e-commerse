class Picture {
  final String file;
  final bool asMain;

  Picture({
    required this.file,
    required this.asMain,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      file: json["file"],
      asMain: json["as_main"],
    );
  }
}