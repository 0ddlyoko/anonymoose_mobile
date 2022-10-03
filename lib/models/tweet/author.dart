import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable(explicitToJson: true)
class Author {
  String id;
  String name;
  String picture;
  bool hidden;

  Author({
    required this.id,
    required this.name,
    required this.picture,
    required this.hidden,
  });

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}
