import 'package:json_annotation/json_annotation.dart';
import 'user.dart';

part 'user_list.g.dart';

@JsonSerializable(explicitToJson: true)
class UserList {
  int size;
  List<User> items;

  UserList({
    required this.size,
    required this.items,
  });

  factory UserList.fromJson(Map<String, dynamic> json) => _$UserListFromJson(json);

  Map<String, dynamic> toJson() => _$UserListToJson(this);
}
